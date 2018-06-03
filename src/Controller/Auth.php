<?php
/**
 * Created by PhpStorm.
 * Author: Konstantin Kaluzhnikov k.kaluzhnikov@gmail.com
 * Date: 22.08.2017
 */

namespace Controller;

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

class Auth extends BaseController
{
    public function login(Request $request, Response $response, Array $args) {

        if(!$request->isPost()){
            return $this->render($response, 'Auth/login.twig');
        }

        $data = $request->getParsedBody();

        $sql = "SELECT U.*, G.name AS groupName
                FROM users U
                LEFT JOIN userGroups G ON U.groupId = G.userGroupId
                WHERE (U.login = ? OR U.email = ?) AND U.status = 1";
        $stmt = $this->db->prepare($sql);
        $stmt->execute([$data['login'], $data['login']]);
        if(!$user = $stmt->fetch()){
            $this->flash->addMessage('error', $this->trans('User does not exists'));
            return $response->withStatus(302)->withHeader('Location', $this->router->pathFor('login', ['lang' => $this->lang]));
        }

        if(password_verify($data['password'], $user['password'])) {
            // If the password inputs matched the hashed password in the database
            if (session_status() == PHP_SESSION_NONE) {
                session_start();
            }

            $_SESSION['user']   = $user;

            $routeName = ($user['groupId'] == 1) ? 'admin_dashboard' : 'member_dashboard';
            return $response->withStatus(302)->withHeader('Location', $this->router->pathFor($routeName, ['lang' => $this->lang]));
        }

        $this->flash->addMessage('error', $this->trans('Wrong login or password'));
        return $response->withStatus(302)->withHeader('Location', $this->router->pathFor('login', ['lang' => $this->lang]));
    }

    public function logout(Request $request, Response $response, Array $args) {
        session_destroy();

        $url = $this->router->pathFor('home', ['lang' => $this->lang]);
        return $response->withStatus(302)->withHeader('Location', $url);
    }

    public function register(Request $request, Response $response, Array $args) {

        if(!$request->isPost()){
            return $this->render($response, 'Auth/login.twig');
        }

        $data = $request->getParsedBody();

        if($this->checkExists('email', $data['email'])){
            $this->flash->addMessage('error', $this->trans("Email '%email%' already exists.", ['%email%' => $data['email']]));
            return $response->withStatus(302)->withHeader('Location', $this->router->pathFor('register', ['lang' => $this->lang]));
        }

        $hashpass = password_hash((string)$data['password'], PASSWORD_DEFAULT);
        $activationCode = md5($data['email']);

        $data = array(
            'login'          => $data['email'],
            'password'       => $hashpass,
            'activationCode' => $activationCode,
            'groupId'        => 2,
            'name'           => $data['name'],
            'country'        => $data['country'],
            'cityId'         => $data['city'],
            'phone'          => $data['phone'],
            'email'          => $data['email'],
            'site'           => $data['site'],
            'facebook'       => $data['facebook'],
        );

        try {
            $this->db->beginTransaction();

            $keys = array_keys($data);
            $fields = '`'.implode('`, `',$keys).'`';
            $placeholder = substr(str_repeat('?,',count($keys)),0,-1);
            $this->db->prepare("INSERT INTO `users` ($fields) VALUES ($placeholder)")->execute(array_values($data));

            $userId = $this->db->lastInsertId();

            $emailFrom = $this->settings['info_mail'];
            $emailTo   = array($data['email'] => $data['name']);
            $emailBody = $this->renderer->fetch('Emails/registrationConfirm.twig', array('code' => $activationCode));

            // Setting all needed info and passing in my email template.
            $message = (new \Swift_Message($this->trans('Conformation')))
                ->setFrom($emailFrom)
                ->setTo($emailTo)
                ->setBody($emailBody)
                ->setContentType("text/html");

            // Send the message
            if(!$this->mailer->send($message)){
                throw new \Exception('Message has not been sent');
            }

            $this->db->commit();
            return $this->render($response, 'Frontend/page.twig', ['title' => 'Info', 'text' => 'Please, check email to complete registration']);
        } catch (\Exception $e) {
            $this->db->rollBack();
            $flashMsg = ($this->settings['displayErrorDetails']) ? $e->getMessage() : $this->trans('An error occurred. Please contact administrator');
            $this->flash->addMessage('error', json_encode($flashMsg, JSON_PRETTY_PRINT));
            return $response->withStatus(302)->withHeader('Location', $this->router->pathFor('register', ['lang' => $this->lang]));
        }
    }

    public function confirmMail(Request $request, Response $response, Array $args) {

        $stmt = $this->db->prepare("SELECT * FROM users where activationCode = ? AND status = 0");
        $stmt->execute(array($args['code']));
        if(!$user = $stmt->fetch()){
            return $this->render($response, 'Frontend/page.twig', ['title' => 'Error!', 'text' => 'Wrong activation code.']);
        }

        try {
            $this->db->beginTransaction();

            $stmt = $this->db->prepare("UPDATE users SET status = 1 WHERE userId = ?");
            $stmt->execute(array($user['userId']));

            $this->db->commit();
            return $this->render($response, 'Frontend/page.twig', ['title' => 'Info', 'text' => 'Conformation complete. Please, sign in.']);
        } catch (\Exception $e) {
            $this->db->rollBack();
            $flashMsg = ($this->settings['displayErrorDetails']) ? $e->getMessage() : $this->trans('An error occurred. Please contact administrator');
            $this->flash->addMessage('error', json_encode($flashMsg, JSON_PRETTY_PRINT));
            return $response->withStatus(302)->withHeader('Location', $this->router->pathFor('register', ['lang' => $this->lang]));
        }
    }

    public function forgotPassword(Request $request, Response $response, Array $args) {

        if(!$request->isPost()){
            return $this->render($response, 'Auth/forgotPassword.twig');
        }

        $vars = $request->getParsedBody();

        $stmt = $this->db->prepare("SELECT * FROM users WHERE email=?");
        $stmt->execute([$vars['email']]);

        if(!$item = $stmt->fetch()){
            $this->flash->addMessage('error', $this->trans('Wrong email'));
            return $response->withStatus(302)->withHeader('Location', $this->router->pathFor('forgotPassword', ['lang' => $this->lang]));
        }

        $password = (string)bin2hex(random_bytes(4));
        $hashpass = password_hash($password, PASSWORD_DEFAULT);

        try {
            $this->db->beginTransaction();

            $stmt = $this->db->prepare("UPDATE users SET password=? WHERE userId=?");
            $stmt->execute([$hashpass, $item['userId']]);

            $emailFrom = $this->settings['info_mail'];
            $emailTo   = array($item['email'] => $item['name']);
            $emailBody = $this->renderer->fetch('Emails/forgotPassword.twig', array('password' => $password));

            // Setting all needed info and passing in my email template.
            $message = (new \Swift_Message($this->trans('Conformation')))
                ->setFrom($emailFrom)
                ->setTo($emailTo)
                ->setBody($emailBody)
                ->setContentType("text/html");

            // Send the message
            if(!$this->mailer->send($message)){
                throw new \Exception('Message has not been sent');
            }

            $this->db->commit();
            return $this->render($response, 'Frontend/page.twig', ['title' => 'Info', 'text' => 'Please, check email']);
        } catch (\Exception $e) {
            $this->db->rollBack();
            $flashMsg = ($this->settings['displayErrorDetails']) ? $e->getMessage() : $this->trans('An error occurred. Please contact administrator');
            $this->flash->addMessage('error', json_encode($flashMsg, JSON_PRETTY_PRINT));
            return $response->withStatus(302)->withHeader('Location', $this->router->pathFor('forgotPassword', ['lang' => $this->lang]));
        }
    }

    // Check Auth Middleware
    public function checkAuth(Request $request, Response $response, callable $next)
    {
        if (session_status() == PHP_SESSION_NONE) {
            session_start();
        }

        if(!isset($_SESSION['user'])){
            $url = $this->router->pathFor('login', ['lang' => $this->lang]);
            return $response->withStatus(302)->withHeader('Location', $url);
        }

        return $next($request, $response, $next);
    }

    // Check is Admin Middleware
    public function checkIsAdmin(Request $request, Response $response, callable $next)
    {
        if ($_SESSION['user']['groupId'] != 1) {
            throw new \Slim\Exception\NotFoundException($request, $response);
        }

        return $next($request, $response, $next);
    }

    // Check if user not exists
    public function checkNotExists(Request $request, Response $response, Array $args) {
        $allGetVars = $request->getQueryParams();

        if($this->checkExists(key($allGetVars), reset($allGetVars))){
            return  $response->withJson('Not valid', 400);
        }

        return $response->withJson('OK', 200);
    }

    protected function checkExists($field, $value) {
        $field = preg_replace('/[^A-Za-z0-9\-]/', '', $field);

        $stmt = $this->db->prepare("SELECT COUNT(*) FROM users where ".$field." = ?");
        $stmt->execute([$value]);

        return (bool) $stmt->fetchColumn();
    }
}