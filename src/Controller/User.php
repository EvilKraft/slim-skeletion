<?php
/**
 * Created by PhpStorm.
 * Author: Konstantin Kaluzhnikov k.kaluzhnikov@gmail.com
 * Date: 22.08.2017
 */

namespace Controller;

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;


class User extends BaseController
{
    protected  $data = [];

    public function profile(Request $request, Response $response, Array $args) {

        $stmt = $this->db->query("SELECT * FROM users WHERE userId=".(int) $_SESSION['user']['userId']);
        if (!$item = $stmt->fetch()) {
            $this->flash->addMessage('error', $this->trans('Item %item_id% not found', ['%item_id%' => $_SESSION['user']['userId']]));
            return $response->withStatus(302)->withHeader('Location', $this->getListUrl());
        }
        $this->data['item'] = $item;

        $sql = "SELECT I.industryId, IL.name
                FROM industries I
                INNER JOIN industries_lang IL ON I.industryId = IL.industryId AND lang=?";
        $stmt = $this->db->prepare($sql);
        $stmt->execute([$this->lang]);
        $this->data['industries'] = $stmt->fetchAll();

        if($request->isPut()){
            $vars = array_intersect_key($request->getParsedBody(), array_flip([
                'name', 'voen', 'city', 'address', 'phone', 'email', 'site', 'facebook', 'description', 'password'
            ]));
            $contacts_vars = array_intersect_key($request->getParsedBody(), array_flip([
                'contact_id', 'contact_name', 'contact_position', 'contact_phone', 'contact_email'
            ]));

            if($item['country'] != 'AZ'){
                unset($vars['voen']);
                unset($vars['city']);
            }

            if(trim($vars['password']) == ''){
                unset($vars['password']);
            }else{
                $vars['password'] = password_hash((string)$vars['password'], PASSWORD_DEFAULT);
            }

            $sets = array();
            foreach($vars as $name => $val){
                $sets[] = $name.' = ?';
            }
            $colNames = implode(' , ', $sets);

            $vals = array_values($vars);
            $vals[] = $item['userId'];

            try {
                $this->db->beginTransaction();

                if($item['groupId'] == 2){
                    $insert_stmt = $this->db->prepare("INSERT INTO userContacts SET userId=?, name=?, position=?, phone=?, email=?");
                    $update_stmt = $this->db->prepare("UPDATE      userContacts SET name=?, position=?, phone=?, email=? WHERE userContactId=?");
                    $delete_stmt = $this->db->prepare("UPDATE      userContacts SET status = 0 WHERE userContactId=?");

                    foreach ($this->data['contacts'] as $contact){
                        $key = array_search($contact['userContactId'], $contacts_vars['contact_id']);

                        if($key !== false){
                            $update_stmt->execute([
                                $contacts_vars['contact_name'][$key],
                                $contacts_vars['contact_position'][$key],
                                $contacts_vars['contact_phone'][$key],
                                $contacts_vars['contact_email'][$key],
                                $contact['userContactId'],
                            ]);
                        }else{
                            $delete_stmt->execute([$contact['id']]);
                        }
                    }

                    foreach($contacts_vars['contact_id'] as $key => $contact_id){
                        if($contact_id == ''){
                            $insert_stmt->execute([
                                $item['userId'],
                                $contacts_vars['contact_name'][$key],
                                $contacts_vars['contact_position'][$key],
                                $contacts_vars['contact_phone'][$key],
                                $contacts_vars['contact_email'][$key],
                            ]);
                        }
                    }
                }

                if($item['groupId'] == 3){
                    $insert_stmt = $this->db->prepare("INSERT INTO userIndustries SET userId=?, industryId=?");
                    $delete_stmt = $this->db->prepare("DELETE FROM userIndustries WHERE userIndustryId=?");

                    foreach ($this->data['industries'] as $industry){
                        if(!is_null($industry['UI_Id']) && !in_array($industry['industryId'], $request->getParsedBody()['industry'])){
                            $delete_stmt->execute([$industry['UI_Id']]);
                        }elseif(is_null($industry['UI_Id']) && in_array($industry['industryId'], $request->getParsedBody()['industry'])){
                            $insert_stmt->execute([$item['userId'], $industry['industryId']]);
                        }
                    }
                }

                $stmt = $this->db->prepare("UPDATE users SET ".$colNames." WHERE userId = ?");
                $stmt->execute($vals);

                $this->db->commit();
                $this->flash->addMessage('success', $this->trans('Profile updated'));
            } catch (\Exception $e) {
                $this->db->rollBack();

                $flashMsg = ($this->settings['displayErrorDetails']) ? $e->getMessage() : $this->trans('Profile not updated');
                $this->flash->addMessage('error', $flashMsg);
            }
            return $response->withStatus(302)->withHeader('Location', $this->router->pathFor('profile', ['lang' => $this->lang]));
        }

        $this->data['pageTitle'] = $this->trans('Profile');

        $stmt = $this->db->prepare("SELECT * FROM cities");
        $stmt->execute();
        $this->data['cities'] = $stmt->fetchAll();

        return $this->renderer->render($response, 'User/profile.twig', $this->data);
    }

    public function help(Request $request, Response $response, Array $args) {

        $sql = "SELECT H.*, L.title, L.text
                FROM help H
                INNER JOIN help_lang L ON L.pageId=H.helpId AND L.lang=?
                ORDER BY sort";

        $stmt = $this->db->prepare($sql);
        $stmt->execute([$this->lang]);
        $this->data['items'] = $stmt->fetchAll();

        $this->data['pageTitle'] = $this->trans('Help');

        return $this->renderer->render($response, 'User/help.twig', $this->data);
    }

    public function support(Request $request, Response $response, Array $args){

        if($request->isPost()){
            $vars = $request->getParsedBody();

            $stmt = $this->db->prepare("SELECT * FROM users WHERE login = 'admin'");
            $stmt->execute();
            $admin = $stmt->fetch();

            $emailFrom = array($_SESSION['user']['email'] => $_SESSION['user']['name']);
            $emailTo   = array($admin['email'] => $admin['name']);
            $emailBody = $this->renderer->fetch('Emails/support.twig', array(
                'from' => $_SESSION['user']['name'],
                'text' => $vars['text']
            ));


            $logger = new \Swift_Plugins_Loggers_ArrayLogger();
            $this->mailer->registerPlugin(new \Swift_Plugins_LoggerPlugin($logger));


            // Setting all needed info and passing in my email template.
            $message = (new \Swift_Message($this->trans('Support').': '.$_SESSION['user']['name']))
                ->setFrom($emailFrom)
                ->setTo($emailTo)
                ->setBody($emailBody)
                ->setContentType("text/html");

            // Send the message
            $result = $this->mailer->send($message);

            if($result == 1){
                $this->flash->addMessage('success', $this->trans('Email was send'));
            }else{

                // Dump the log contents
                // NOTE: The EchoLogger dumps in realtime so dump() does nothing for it. We use ArrayLogger instead.
                echo "Error:" . $logger->dump();
                return $response;

                $this->flash->addMessage('error', $this->trans('An error occurred. Please contact administrator'));
            }
            return $response->withStatus(302)->withHeader('Location', $this->router->pathFor('tenders', ['lang' => $this->lang]));
        }

        $this->data['pageTitle'] = $this->trans('Support');

        return $this->renderer->render($response, 'User/support.twig', $this->data);
    }
}