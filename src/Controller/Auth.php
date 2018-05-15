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


        if($request->isPost()){
            $data = $request->getParsedBody();

            $sql = "SELECT U.*, G.name AS groupName
                    FROM users U
                    LEFT JOIN userGroups G ON U.groupId = G.userGroupId
                    WHERE U.login = ? AND U.status = 1";
            $stmt = $this->db->prepare($sql);
            $stmt->execute(array($data['login']));
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

                $url = ($user['groupId'] == 1)
                     ? $this->router->pathFor('admin_tenders_moderate', ['lang' => $this->lang])
                     : $this->router->pathFor('tenders', ['lang' => $this->lang]);
                return $response->withStatus(302)->withHeader('Location', $url);
            }

            $this->flash->addMessage('error', $this->trans('Wrong login or password'));
            return $response->withStatus(302)->withHeader('Location', $this->router->pathFor('login', ['lang' => $this->lang]));
        }

        $data = $this->getLoginData();

        return $this->renderer->render($response, 'Auth/login.twig', $data);
    }

    public function logout(Request $request, Response $response, Array $args) {
        session_destroy();

        $url = $this->router->pathFor('home', ['lang' => $this->lang]);
        return $response->withStatus(302)->withHeader('Location', $url);
    }

    public function register(Request $request, Response $response, Array $args) {

        if($request->isPost()){
            $data = $request->getParsedBody();

            if($this->loginExists($data['login'])){
                $this->flash->addMessage('error', $this->trans("Login '%login%' already exists.", ['%login%' => $data['login']]));
                return $response->withStatus(302)->withHeader('Location', $this->router->pathFor('register', ['lang' => $this->lang]));
            }

            if($this->emailExists($data['email'])){
                $this->flash->addMessage('error', $this->trans("Email '%email%' already exists.", ['%email%' => $data['email']]));
                return $response->withStatus(302)->withHeader('Location', $this->router->pathFor('register', ['lang' => $this->lang]));
            }

            $hashpass = password_hash((string)$data['password'], PASSWORD_DEFAULT);
            $activationCode = md5($data['email']);

            $bindVals = array(
                $data['login'],
                $hashpass,
                $activationCode,
                $data['group'],
                $data['name'],
                (int) $data['voen'],
                $data['country'],
                (int) $data['city'],
                $data['address'],
                $data['phone'],
                $data['email'],
                $data['site'],
                $data['facebook'],
                $data['description'],
            );

            try {
                $this->db->beginTransaction();

                $sql = "INSERT INTO users SET login=?, password=?, activationCode=?, groupId=?, name=?, voen=?, country=?, city=?, address=?, phone=?, email=?, site=?, facebook=?, description=?, fullAccessTo=?";
                $stmt = $this->db->prepare($sql);
                $stmt->execute($bindVals);

                $userId = $this->db->lastInsertId();

                if(isset($data['contact_name'])){
                    $stmt = $this->db->prepare("INSERT INTO userContacts SET userId=?, name=?, position=?, phone=?, email=?");

                    foreach($data['contact_name'] as $key => $contact_name){
                        $stmt->execute([
                            $userId,
                            $contact_name,
                            $data['contact_position'][$key],
                            $data['contact_phone'][$key],
                            $data['contact_email'][$key],

                        ]);
                    }
                }

                if(isset($data['industry'])){
                    $stmt = $this->db->prepare("INSERT INTO userIndustries SET userId=?, industryId=?");

                    foreach($data['industry'] as $industryId){
                        $stmt->execute([
                            $userId,
                            $industryId,
                        ]);
                    }
                }

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
                $result = $this->mailer->send($message);

                if($result == 1){
                    $this->db->commit();
                    return $this->renderer->render($response, 'Frontend/info.twig', ['header' => 'Info', 'text' => 'Please, check email to complete registration']);
                }else{
                    $this->db->rollBack();
                    $this->flash->addMessage('error', $this->trans('An error occurred. Please contact administrator'));
                    return $response->withStatus(302)->withHeader('Location', $this->router->pathFor('register', ['lang' => $this->lang]));
                }
            } catch (\Exception $e) {
                $this->db->rollBack();
                $flashMsg = ($this->settings['displayErrorDetails']) ? $e->getMessage() : $this->trans('An error occurred. Please contact administrator');
                $this->flash->addMessage('error', $flashMsg);
                return $response->withStatus(302)->withHeader('Location', $this->router->pathFor('register', ['lang' => $this->lang]));
            }
        }

        $data = $this->getLoginData();

        return $this->renderer->render($response, 'Auth/login.twig', $data);
    }

    public function whyReg(Request $request, Response $response, Array $args) {

        $data = $this->getLoginData();

        return $this->renderer->render($response, 'Auth/login.twig', $data);
    }

    public function checkLogin(Request $request, Response $response, Array $args) {
        $allGetVars = $request->getQueryParams();

        $key = key($allGetVars);
        $val = reset($allGetVars);

        switch ($key){
            case 'login' :
                if(!$this->loginExists($val)){
                    return $response->withJson('OK', 200);
                }

                break;
        }

        return  $response->withJson('Not valid', 400);
    }

    public function checkEmail(Request $request, Response $response, Array $args) {
        $allGetVars = $request->getQueryParams();

        $key = key($allGetVars);
        $val = reset($allGetVars);

        switch ($key){
            case 'email' :
                if(!$this->emailExists($val)){
                    return $response->withJson('OK', 200);
                }

                break;
        }

        return  $response->withJson('Not valid', 400);
    }

    public function confirmMail(Request $request, Response $response, Array $args) {

        $stmt = $this->db->prepare("SELECT * FROM users where activationCode = ? AND status = 0");
        $stmt->execute(array($args['code']));
        if(!$user = $stmt->fetch()){
            return $this->renderer->render($response, 'Frontend/info.twig', ['header' => 'Error!', 'text' => 'Wrong activation code.']);
        }

        try {
            $this->db->beginTransaction();

            $stmt = $this->db->prepare("UPDATE users SET status = 1 WHERE userId = ?");
            $stmt->execute(array($user['userId']));

            $this->db->commit();
            return $this->renderer->render($response, 'Frontend/info.twig', ['header' => 'Info', 'text' => 'Conformation complete. Please, sign in.']);
        } catch (\Exception $e) {
            $this->db->rollBack();
            $flashMsg = ($this->settings['displayErrorDetails']) ? $e->getMessage() : $this->trans('An error occurred. Please contact administrator');
            $this->flash->addMessage('error', $flashMsg);
            return $response->withStatus(302)->withHeader('Location', $this->router->pathFor('register', ['lang' => $this->lang]));
        }
    }

    public function forgotPassword(Request $request, Response $response, Array $args) {

        if($request->isPost()) {
            $vars = $request->getParsedBody();

            $stmt = $this->db->prepare("SELECT * FROM users WHERE login=? AND email=?");
            $stmt->execute([$vars['login'], $vars['email']]);
            if($item = $stmt->fetch()){

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
                    $result = $this->mailer->send($message);

                    if($result == 1){
                        $this->db->commit();
                        return $this->renderer->render($response, 'Frontend/info.twig', ['header' => 'Info', 'text' => 'Please, check email']);
                    }else{
                        $this->db->rollBack();
                        $this->flash->addMessage('error', $this->trans('An error occurred. Please contact administrator'));
                        return $response->withStatus(302)->withHeader('Location', $this->router->pathFor('forgotPassword', ['lang' => $this->lang]));
                    }
                } catch (\Exception $e) {
                    $this->db->rollBack();
                    $flashMsg = ($this->settings['displayErrorDetails']) ? $e->getMessage() : $this->trans('An error occurred. Please contact administrator');
                    $this->flash->addMessage('error', $flashMsg);
                    return $response->withStatus(302)->withHeader('Location', $this->router->pathFor('forgotPassword', ['lang' => $this->lang]));
                }
            }

            $this->flash->addMessage('error', $this->trans('Wrong login or email'));
            return $response->withStatus(302)->withHeader('Location', $this->router->pathFor('forgotPassword', ['lang' => $this->lang]));
        }

        $data = array();

        return $this->renderer->render($response, 'Auth/forgotPassword.twig', $data);;
    }

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

    public function checkIsAdmin(Request $request, Response $response, callable $next)
    {
        if ($_SESSION['user']['groupId'] != 1) {
            throw new \Slim\Exception\NotFoundException($request, $response);
        }

        $sql = "SELECT COUNT(*) AS to_moderate FROM tenders T WHERE T.status = 0";
        $stmt = $this->db->prepare($sql);
        $stmt->execute();
        $toModerate = $stmt->fetch()['to_moderate'];
        $this->renderer->getEnvironment()->addGlobal('toModerate', $toModerate);

        return $next($request, $response, $next);
    }

    private function getLoginData(){
        $data = array();

        $stmt = $this->db->prepare("SELECT * FROM cities");
        $stmt->execute();
        $data['cities'] = $stmt->fetchAll();

        $stmt = $this->db->prepare("SELECT I.industryId, IL.name FROM industries I INNER JOIN industries_lang IL ON I.industryId = IL.industryId AND lang=?");
        $stmt->execute([$this->lang]);
        $data['industries'] = $stmt->fetchAll();

        $sql = "SELECT 
                    PL.title AS why_title, 
                    PL.text  AS why_text 
                FROM pages P
                INNER JOIN pages_lang PL ON PL.pageId = P.pageId
                WHERE P.alias = 'why' AND PL.lang=?";
        $stmt = $this->db->prepare($sql);
        $stmt->execute([$this->lang]);
        $why = $stmt->fetch();
        $data['why_title'] = $why['why_title'];
        $data['why_text']  = $why['why_text'];

        return $data;
    }

    private function loginExists($login){
        $stmt = $this->db->prepare("SELECT COUNT(*) AS count FROM users where login = ?");
        $stmt->execute([$login]);
        $row = $stmt->fetch();

        if($row['count'] > 0){
            return true;
        }
        return false;
    }

    private function emailExists($email){
        $stmt = $this->db->prepare("SELECT COUNT(*) AS count FROM users where email = ?");
        $stmt->execute([$email]);
        $row = $stmt->fetch();

        if($row['count'] > 0){
            return true;
        }
        return false;
    }
}