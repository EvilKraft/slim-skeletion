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

class Help extends \Controller\RESTController
{
    protected $table        = 'help';
    protected $idxField     = 'helpId';
    protected $template     = 'Admin\Help.twig';

    protected $columns      = ['title'];
    protected $actions      = ['create', 'update', 'delete', 'move'];

    protected $idxFieldLang = 'langId';

    protected function doCreate(Request $request, Response $response)
    {
        $vars = $request->getParsedBody();

        $stmt = $this->db->prepare("SELECT IFNULL(MAX(sort), 0) + 1 AS next_sort FROM ".$this->table);
        $stmt->execute();
        $sort = $stmt->fetch()['next_sort'];

        try {
            $this->db->beginTransaction();

            $stmt = $this->db->prepare("INSERT INTO ".$this->table." SET sort=?");
            $stmt->execute([$sort]);

            $pageId = $this->db->lastInsertId();

            $stmt = $this->db->prepare("INSERT INTO ".$this->table."_lang SET pageId=?, lang=?, title=?, text=?");
            foreach ($vars['id'] as $lang => $val){
                $stmt->execute(array(
                    $pageId,
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
            $this->flash->addMessage('error', json_encode($flashMsg, JSON_PRETTY_PRINT));
        }

        return $response->withStatus(302)->withHeader('Location', $this->getListUrl());
    }
}