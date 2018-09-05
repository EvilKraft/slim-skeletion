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
        $this->cleanOldPosts();

        $this->data['page']['title'] = $this->trans('REST.Dashboard.page.title');

        $stmt = $this->db->prepare("SELECT COUNT(*) FROM posts WHERE status = 0");
        $stmt->execute();
        $this->data['total_posts_moderate'] = $stmt->fetchColumn();

        $stmt = $this->db->prepare("SELECT COUNT(*) FROM posts WHERE status = 1");
        $stmt->execute();
        $this->data['total_posts'] = $stmt->fetchColumn();


        $stmt = $this->db->prepare("SELECT COUNT(*) FROM users WHERE groupId != 1 AND status = 1");
        $stmt->execute();
        $this->data['total_users'] = $stmt->fetchColumn();


        return $this->render($response, 'Admin/Dashboard.twig', $this->data);
    }

    protected function cleanOldPosts(){
        $stmt = $this->db->prepare("SELECT postId FROM posts WHERE createdAt < DATE_SUB(NOW(), INTERVAL ".$this->settings['post_live_months']." MONTH)");
        $stmt->execute();
        $ids = array_column($stmt->fetchAll(), 'postId');

        $questionsStr = implode(',', array_fill(0, count($ids), '?'));

        try {
            $this->db->beginTransaction();

            $stmt = $this->db->prepare("DELETE FROM posts WHERE postId IN (".$questionsStr.")");
            $stmt->execute($ids);

            $stmt = $this->db->prepare("SELECT * FROM posts_files WHERE postId IN (".$questionsStr.")");
            $stmt->execute($ids);

            $server = \Controller\Image::initServer();
            $del_stmt = $this->db->prepare("DELETE FROM posts_files WHERE fileId = ?");
            foreach ($stmt->fetchAll() as $file){
                $server->deleteCache($file['file']);
                unlink(UPLOAD_DIR.$file['file']);
                $del_stmt->execute(array($file['fileId']));
            }

            $this->db->commit();
            $data['status'] = 1;
        } catch (\Exception $e) {
            $this->db->rollBack();
            $data['errors'][] = array('message' => $this->trans('Records not deleted'));
        }




    }
}