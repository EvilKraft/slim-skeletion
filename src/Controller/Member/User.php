<?php
/**
 * Created by PhpStorm.
 * Author: Konstantin Kaluzhnikov k.kaluzhnikov@gmail.com
 * Date: 22.08.2017
 */

namespace Controller\Member;

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;


class User extends \Controller\BaseController
{
    protected  $data = [];

    public function dashboard(Request $request, Response $response, Array $args) {
        $this->data['pageTitle'] = $this->trans('Dashboard');

        $stmt = $this->db->prepare("SELECT COUNT(*) FROM posts WHERE userId = ?");
        $stmt->execute([$_SESSION['user']['userId']]);
        $this->data['total_posts'] = $stmt->fetchColumn();

        return $this->render($response, 'Member/User/dashboard.twig', $this->data);
    }

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
                $this->flash->addMessage('error', json_encode($flashMsg, JSON_PRETTY_PRINT));
            }
            return $response->withStatus(302)->withHeader('Location', $this->router->pathFor('member_profile', ['lang' => $this->lang]));
        }

        $this->data['pageTitle'] = $this->trans('Profile');

        $stmt = $this->db->prepare("SELECT * FROM cities");
        $stmt->execute();
        $this->data['cities'] = $stmt->fetchAll();

        return $this->render($response, 'Member/User/profile.twig', $this->data);
    }
}