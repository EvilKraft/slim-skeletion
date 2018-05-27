<?php
/**
 * Created by PhpStorm.
 * Author: Konstantin Kaluzhnikov k.kaluzhnikov@gmail.com
 * Date: 22.08.2017
 */

namespace Controller\Admin;

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

class Dashboard extends \Controller\BaseController
{
    protected  $data = [];

    public function index(Request $request, Response $response, Array $args)
    {
        $this->data['pageTitle'] = $this->trans('Dashboard');

        $stmt = $this->db->prepare("SELECT COUNT(*) FROM posts WHERE status = 0");
        $stmt->execute();
        $this->data['total_posts_moderate'] = $stmt->fetchColumn();

        $stmt = $this->db->prepare("SELECT COUNT(*) FROM posts WHERE status = 1");
        $stmt->execute();
        $this->data['total_posts'] = $stmt->fetchColumn();


        $stmt = $this->db->prepare("SELECT COUNT(*) FROM users WHERE groupId != 1 AND status = 1");
        $stmt->execute();
        $this->data['total_users'] = $stmt->fetchColumn();


        return $this->renderer->render($response, 'Admin/Dashboard.twig', $this->data);
    }
}