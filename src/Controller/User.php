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

        $stmt = $this->db->prepare("SELECT * FROM userContacts WHERE userId = ? AND status = 1");
        $stmt->execute(array($this->data['item']['userId']));
        $this->data['contacts'] = $stmt->fetchAll();

        $sql = "SELECT I.industryId, IL.name, UI.industryId AS UI_Id, UI.userId
                FROM industries I
                INNER JOIN industries_lang IL ON I.industryId = IL.industryId AND lang=?
                LEFT JOIN userIndustries UI ON UI.industryId = I.industryId AND userId=?";
        $stmt = $this->db->prepare($sql);
        $stmt->execute([$this->lang, $this->data['item']['userId']]);
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

    public function mailbox(Request $request, Response $response, Array $args) {

        $this->data['pageTitle'] = $this->trans('Mailbox');

        switch ($_SESSION['user']['groupId']){
            case 2 :    // if buyer
                $sql = "SELECT 
                        TA.*, 
                        T.status,
                        T.name         AS tender_name, 
                        U.userId       AS user_id,
                        U.groupId      AS user_group,
                        U.name         AS user_name,
                        U.address      AS user_address,
                        U.phone        AS user_phone,
                        U.email        AS user_email,
                        U.description  AS user_description,
                        U.stars        AS user_stars,
                        1              AS voted
                    FROM tenderAccess TA
                    INNER JOIN tenders T ON TA.tenderId = T.tenderId
                    INNER JOIN users U ON U.userId = TA.userId
                    WHERE TA.participate = 1 AND T.userId = ?";

                $bindVals = array($_SESSION['user']['userId']);
                break;

            case 1 :
                $sql = "SELECT
                            TA.*, 
                            1 as status,
                            T.name         AS tender_name, 
                            U.userId       AS user_id,
                            U.groupId      AS user_group,
                            U.name         AS user_name,
                            U.address      AS user_address,
                            U.phone        AS user_phone,
                            U.email        AS user_email,
                            U.description  AS user_description,
                            U.stars        AS user_stars,
                            1              AS voted,
                            UC.name        AS contact_name,
                            UC.position    AS contact_position,
                            UC.phone       AS contact_phone,
                            UC.email       AS contact_email
                        FROM tenderAccess TA
                        INNER JOIN tenders T ON TA.tenderId = T.tenderId
                        INNER JOIN userContacts UC ON T.contact = UC.userContactId
                        INNER JOIN users U ON U.userId = T.userId
                        
                        INNER JOIN (
                            SELECT TM.tenderAccessId, COUNT(TM.tenderMsgId) msgs
                            FROM tenderMsgs TM
                            INNER JOIN tenderAccess TA ON TM.tenderAccessId = TA.tenderAccessId AND TA.userId = ?
                            GROUP BY TM.tenderAccessId
                        ) TM ON TA.tenderAccessId = TM.tenderAccessId AND TM.msgs > 0
                        
                        WHERE TA.userId = ?";

                $bindVals = array($_SESSION['user']['userId'], $_SESSION['user']['userId']);
                break;
            case 3 :
                $sql = "SELECT
                            TA.*, 
                            T.status,
                            T.name         AS tender_name, 
                            U.userId       AS user_id,
                            U.groupId      AS user_group,
                            U.name         AS user_name,
                            U.address      AS user_address,
                            U.phone        AS user_phone,
                            U.email        AS user_email,
                            U.description  AS user_description,
                            U.stars        AS user_stars,
                            (CASE WHEN V.stars IS NULL THEN 0 ELSE 1 END) AS voted,
                            UC.name        AS contact_name,
                            UC.position    AS contact_position,
                            UC.phone       AS contact_phone,
                            UC.email       AS contact_email
                        FROM tenderAccess TA
                        INNER JOIN tenders T ON TA.tenderId = T.tenderId
                        INNER JOIN userContacts UC ON T.contact = UC.userContactId
                        INNER JOIN users U ON U.userId = T.userId
                        
                        LEFT JOIN votes V ON V.votedFor = U.userId AND voter = ?
                        
                        WHERE T.status = 1 AND TA.participate = 1 AND TA.userId = ?";

                $bindVals = array($_SESSION['user']['userId'], $_SESSION['user']['userId']);
                break;
        }

        $stmt = $this->db->prepare($sql);
        $stmt->execute($bindVals);
        $this->data['chats'] = $stmt->fetchAll();

        return $this->renderer->render($response, 'User/mailbox.twig', $this->data);
    }

    public function billing(Request $request, Response $response, Array $args) {

        if($request->isPost()){

            $result = 1;

            if($result == 1){
                $this->flash->addMessage('success', $this->trans('OK'));
            }else{
                $this->flash->addMessage('error', $this->trans('An error occurred. Please contact administrator'));
            }
            return $response->withStatus(302)->withHeader('Location', $this->router->pathFor('tenders', ['lang' => $this->lang]));
        }

        $this->data['pageTitle'] = $this->trans('Billing options');

        $stmt = $this->db->prepare("SELECT * FROM billingOptions WHERE groupId=?");
        $stmt->execute([$_SESSION['user']['groupId']]);
        $this->data['billingOptions'] = $stmt->fetch();

        return $this->renderer->render($response, 'User/billing.twig', $this->data);
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