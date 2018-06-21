<?php
/**
 * Created by PhpStorm.
 * Author: Konstantin Kaluzhnikov k.kaluzhnikov@gmail.com
 * Date: 22.08.2017
 */

namespace Controller\Admin;

use Controller\RESTController;
use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;
use Symfony\Component\Config\Definition\Exception\Exception;

class Users extends \Controller\RESTController
{
    protected $table       = 'users';
    protected $idxField    = 'userId';
    protected $template    = 'Admin\Users.twig';

    protected        $columns     = ['login', 'name', 'country', 'createdAt'];
    protected static $actions     = ['create', 'update', 'delete'];
    protected        $col_filters = ['country', 'stars'];

    protected function doCreate(Request $request, Response $response)
    {
        $vars          = $this->getPostedVars($request);
        $contacts_vars = array_intersect_key($request->getParsedBody(), array_flip([
            'contact_id', 'contact_name', 'contact_position', 'contact_phone', 'contact_email'
        ]));

        $vars['password'] = password_hash((string)$vars['password'], PASSWORD_DEFAULT);
        $vars['status']   = 1;

        $colNames  = implode(',', array_keys($vars));
        $questions = '?'.str_repeat(',?', (count($vars)-1));

        try {
            $this->db->beginTransaction();

            $stmt = $this->db->prepare("INSERT INTO ".$this->table." (".$colNames.") VALUES (".$questions.")");
            $stmt->execute(array_values($vars));

            $userId = $this->db->lastInsertId();

            if(isset($vars['groupId']) && $vars['groupId'] == 2){
                $insert_stmt = $this->db->prepare("INSERT INTO userContacts SET userId=?, name=?, position=?, phone=?, email=?");

                foreach($contacts_vars['contact_id'] as $key => $contact_id){
                    $insert_stmt->execute([
                        $userId,
                        $contacts_vars['contact_name'][$key],
                        $contacts_vars['contact_position'][$key],
                        $contacts_vars['contact_phone'][$key],
                        $contacts_vars['contact_email'][$key],
                    ]);
                }
            }

            if(isset($request->getParsedBody()['industry'])){
                $stmt = $this->db->prepare("INSERT INTO userIndustries SET userId=?, industryId=?");

                foreach($request->getParsedBody()['industry'] as $industryId){
                    $stmt->execute([
                        $userId,
                        $industryId,
                    ]);
                }
            }

            $this->db->commit();
            $this->flash->addMessage('success', $this->trans('New item added'));
        } catch (\Exception $e) {
            $this->db->rollBack();

            $flashMsg = ($this->settings['displayErrorDetails']) ? $e->getMessage() : $this->trans('New item not added');
            $this->flash->addMessage('error', json_encode($flashMsg, JSON_PRETTY_PRINT));
        }

        return $response->withStatus(302)->withHeader('Location', $this->getListUrl());
    }

    protected function doUpdate(Request $request, Response $response, Array $args)
    {
        $stmt = $this->db->query("SELECT * FROM ".$this->table." WHERE ".$this->idxField." = ".(int) $args['id']);
        if (!$item = $stmt->fetch()) {
            $this->flash->addMessage('error', $this->trans('Item %item_id% not found', ['%item_id%' => $args['id']]));
            return $response->withStatus(302)->withHeader('Location', $this->getListUrl());
        }

        $sql = "SELECT I.industryId, IL.title, UI.userIndustryId AS UI_Id, UI.userId
                FROM industries I
                INNER JOIN industries_lang IL ON I.industryId = IL.industryId AND lang=?
                LEFT JOIN userIndustries UI ON UI.industryId = I.industryId AND userId=?";
        $stmt = $this->db->prepare($sql);
        $stmt->execute([$this->lang, $item['id']]);
        $industries = $stmt->fetchAll();

        $vars          = $this->getPostedVars($request);
        $contacts_vars = array_intersect_key($request->getParsedBody(), array_flip([
            'contact_id', 'contact_name', 'contact_position', 'contact_phone', 'contact_email'
        ]));

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
        $vals[] = $args['id'];

        try {
            $this->db->beginTransaction();

            if($item['groupId'] == 2 && $item['groupId'] != $vars['groupId']){
                $stmt = $this->db->prepare("DELETE FROM userContacts WHERE userId = ?");
                $stmt->execute([$item['id']]);
            }else if($vars['groupId'] == 2){
                $insert_stmt = $this->db->prepare("INSERT INTO userContacts SET userId=?, name=?, position=?, phone=?, email=?");
                $update_stmt = $this->db->prepare("UPDATE      userContacts SET name=?, position=?, phone=?, email=? WHERE id=?");
                $delete_stmt = $this->db->prepare("UPDATE      userContacts SET status = 0 WHERE id=?");

                $stmt = $this->db->prepare("SELECT * FROM userContacts WHERE userId = ? AND status = 1");
                $stmt->execute([$item['id']]);

                while ($contact = $stmt->fetch()){
                    $key = array_search($contact['id'], $contacts_vars['contact_id']);

                    if($key !== false){
                        $update_stmt->execute([
                            $contacts_vars['contact_name'][$key],
                            $contacts_vars['contact_position'][$key],
                            $contacts_vars['contact_phone'][$key],
                            $contacts_vars['contact_email'][$key],
                            $contact['id'],
                        ]);
                    }else{
                        $delete_stmt->execute([$contact['id']]);
                    }

                 }

                foreach($contacts_vars['contact_id'] as $key => $contact_id){
                    if($contact_id == ''){
                        $insert_stmt->execute([
                            $item['id'],
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
                $delete_stmt = $this->db->prepare("DELETE FROM userIndustries WHERE id=?");

                foreach ($industries as $industry){
                    if(!is_null($industry['UI_Id']) && !in_array($industry['id'], $request->getParsedBody()['industry'])){
                        $delete_stmt->execute([$industry['UI_Id']]);
                    }elseif(is_null($industry['UI_Id']) && in_array($industry['id'], $request->getParsedBody()['industry'])){
                        $insert_stmt->execute([$item['id'], $industry['id']]);
                    }
                }
            }

            $stmt = $this->db->prepare("UPDATE ".$this->table." SET ".$colNames." WHERE ".$this->idxField." = ?");
            $stmt->execute($vals);

            $this->db->commit();
            $this->flash->addMessage('success', $this->trans('Item %item_id% updated', ['%item_id%' => $args['id']]));
        } catch (\Exception $e) {
            $this->db->rollBack();

            $flashMsg = ($this->settings['displayErrorDetails']) ? $e->getMessage() : $this->trans('Item %item_id% not updated', ['%item_id%' => $args['id']]);
            $this->flash->addMessage('error', json_encode($flashMsg, JSON_PRETTY_PRINT));
        }

        return $response->withStatus(302)->withHeader('Location', $this->getListUrl());
    }

    protected function extraFormData(){
        $stmt = $this->db->prepare("SELECT * FROM userGroups WHERE userGroupId != 1");
        $stmt->execute();
        $this->data['groups'] = $stmt->fetchAll();

        $stmt = $this->db->prepare("SELECT * FROM cities");
        $stmt->execute();
        $this->data['cities'] = $stmt->fetchAll();
    }

    public function profile(Request $request, Response $response, Array $args) {

        $stmt = $this->db->query("SELECT * FROM users WHERE userId=".(int) $_SESSION['user']['userId']);
        if (!$item = $stmt->fetch()) {
            $this->flash->addMessage('error', $this->trans('Item %item_id% not found', ['%item_id%' => $_SESSION['user']['userId']]));
            return $response->withStatus(302)->withHeader('Location', $this->getListUrl());
        }
        $this->data['item'] = $item;

        if($request->isPut()){

            $vars = $this->getPostedVars($request);

            if(empty(trim($vars['password']))){
                unset($vars['password']);
            }else{
                $vars['password'] = password_hash((string)$vars['password'], PASSWORD_DEFAULT);
            }

            try {
                $this->db->beginTransaction();

                if(count($vars) > 0){
                    $colNames = implode(', ', array_map(function($n) {return($n.'=?');}, array_keys($vars)));

                    $stmt = $this->db->prepare("UPDATE ".$this->table." SET ".$colNames." WHERE ".$this->idxField." = ?");
                    $stmt->execute(array_merge_recursive(array_values($vars), [$args['id']]));
                }

                $this->db->commit();
                $this->flash->addMessage('success', $this->trans('Profile updated'));
            } catch (\Exception $e) {
                $this->db->rollBack();

                $flashMsg = ($this->settings['displayErrorDetails']) ? $e->getMessage() : $this->trans('Profile not updated');
                $this->flash->addMessage('error', json_encode($flashMsg, JSON_PRETTY_PRINT));
            }
            return $response->withStatus(302)->withHeader('Location', $request->getUri());
        }

        $this->data['page']['title'] = $this->trans('Profile');

        return $this->render($response, 'Admin/profile.twig', $this->data);
    }
}