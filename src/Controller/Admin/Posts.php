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

class Posts extends \Controller\RESTController
{
    protected $table        = 'posts';
    protected $idxField     = 'postId';
  //  protected $template    = 'Admin\Posts.twig';

    protected $columns      = ['title', 'createdAt'];
    protected $actions      = ['create', 'update', 'delete'];

    protected $idxFieldLang = 'langId';

    protected function extraFormData()
    {
        parent::extraFormData();

        $stmt = $this->db->prepare("SELECT I.industryId, IL.name FROM industries I INNER JOIN industries_lang IL ON I.industryId = IL.industryId AND lang=?");
        $stmt->execute([$this->lang]);
        $this->data['industries'] = $stmt->fetchAll();

        $this->data['files'] = array();
        if(isset($this->data['item'])){
            $stmt = $this->db->prepare("SELECT * FROM postFiles WHERE ".$this->idxField." = ?");
            $stmt->execute(array($this->data['item'][$this->idxField]));
            $this->data['files'] = $stmt->fetchAll();

            foreach($this->data['files'] as $key => $file){

                switch ($file['type']) {
                    case (preg_match('/image.*/',                   $file['type']) ? true : false) : $this->data['files'][$key]['type'] = 'image';  break;
                    case 'text/html'                                                                       : $this->data['files'][$key]['type'] = 'html';   break;
                    case (preg_match('/text.*/',                    $file['type']) ? true : false) : $this->data['files'][$key]['type'] = 'text';   break;
                    case (preg_match('/\.video\/(ogg|mp4|webm)$/i', $file['type']) ? true : false) : $this->data['files'][$key]['type'] = 'video';  break;
                    case (preg_match('/\.audio\/(ogg|mp3|wav)$/i',  $file['type']) ? true : false) : $this->data['files'][$key]['type'] = 'audio';  break;
                    case 'application/x-shockwave-flash'                                                   : $this->data['files'][$key]['type'] = 'flash';  break;
                    default                                                                                : $this->data['files'][$key]['type'] = 'object'; break;
                }
            }
        }
    }

    protected function doCreate(Request $request, Response $response)
    {
        $vars = $request->getParsedBody();

        try {
            $this->db->beginTransaction();

            $stmt = $this->db->prepare("INSERT INTO ".$this->table." SET userId=?");
            $stmt->execute([$_SESSION['user']['userId']]);

            $blogId = $this->db->lastInsertId();

            $stmt = $this->db->prepare("INSERT INTO ".$this->table."_lang SET blogId=?, lang=?, title=?, text=?");
            foreach ($vars['id'] as $lang => $val){
                $stmt->execute(array(
                    $blogId,
                    $lang,
                    $vars['title'][$lang],
                    $vars['text'][$lang],
                ));
            }

            $this->db->commit();
            $this->flash->addMessage('success', $this->trans('New item added'));
        } catch (\Exception $e) {
            $this->db->rollBack();

            $flashMsg = ($this->settings['displayErrorDetails']) ? $e->getMessage() : $this->trans('New item not added');
            $this->flash->addMessage('error', $flashMsg);
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

        $vars = $request->getParsedBody();

        try {
            $this->db->beginTransaction();

            $stmt = $this->db->prepare("UPDATE ".$this->table."_lang SET title=?, text=? WHERE id=?");

            foreach ($vars['id'] as $lang => $lang_id){
                $stmt->execute(array(
                    $vars['title'][$lang],
                    $vars['text'][$lang],
                    $lang_id
                ));
            }

            $this->db->commit();
            $this->flash->addMessage('success', $this->trans('Item %item_id% updated', ['%item_id%' => $args['id']]));
        } catch (\Exception $e) {
            $this->db->rollBack();

            $flashMsg = ($this->settings['displayErrorDetails']) ? $e->getMessage() : $this->trans('Item %item_id% not updated', ['%item_id%' => $args['id']]);
            $this->flash->addMessage('error', $flashMsg);
        }

        return $response->withStatus(302)->withHeader('Location', $this->getListUrl());
    }

}