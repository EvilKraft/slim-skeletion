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
        $sql = "SELECT P.*, L.title, L.keywords, L.description, L.text
                FROM pages P
                INNER JOIN pages_lang L ON L.pageId=P.pageId AND L.lang=?
                WHERE alias=?";

        $stmt = $this->db->prepare($sql);
        $stmt->execute([$this->lang, 'member_dashboard']);
        $item = $stmt->fetch();

        $this->data['page'] = array(
            'title'       => $item['title'],
            'keywords'    => $item['keywords'],
            'description' => $item['description'],
            'text'        => $item['text'],
        );

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

        if($request->isPut()){
            $vars = array_intersect_key($request->getParsedBody(), array_flip([
                'name', 'cityId', 'phone', 'email', 'site', 'facebook', 'password'
            ]));

            if(trim($vars['password']) == ''){
                unset($vars['password']);
            }else{
                $vars['password'] = password_hash((string)$vars['password'], PASSWORD_DEFAULT);
            }

            try {
                $this->db->beginTransaction();

                $colNames = implode(', ', array_map(function($n) {return($n.'=?');}, array_keys($vars)));

                $stmt = $this->db->prepare("UPDATE users SET ".$colNames." WHERE userId = ?");
                $stmt->execute(array_merge_recursive(array_values($vars), [$args['id']]));

                $this->db->commit();
                $this->flash->addMessage('success', $this->trans('Profile updated'));
            } catch (\Exception $e) {
                $this->db->rollBack();

                $flashMsg = ($this->settings['displayErrorDetails']) ? $e->getMessage() : $this->trans('Profile not updated');
                $this->flash->addMessage('error', json_encode($flashMsg, JSON_PRETTY_PRINT));
            }
            return $response->withStatus(302)->withHeader('Location', $this->router->pathFor('member_profile', ['lang' => $this->lang]));
        }

        $this->data['page']['title'] = $this->trans('Profile');

        $stmt = $this->db->prepare("SELECT * FROM cities");
        $stmt->execute();
        $this->data['cities'] = $stmt->fetchAll();

        return $this->render($response, 'Member/User/profile.twig', $this->data);
    }
}