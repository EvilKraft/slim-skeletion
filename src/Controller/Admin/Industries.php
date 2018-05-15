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

class Industries extends \Controller\RESTController
{
    protected $table     = 'industries';
    protected $idxField  = 'industryId';
    protected $template  = 'Admin\Industries.twig';

    protected $columns   = ['name'];
    protected $actions   = ['create', 'update', 'delete'];

    protected $idxFieldLang = 'langId';

    protected function doCreate(Request $request, Response $response)
    {
        $vars = $request->getParsedBody();

        try {
            $this->db->beginTransaction();

            $stmt = $this->db->prepare("INSERT INTO ".$this->table." VALUES ()");
            $stmt->execute();

            $industryId = $this->db->lastInsertId();

            $stmt = $this->db->prepare("INSERT INTO ".$this->table."_lang SET industryId=?, lang=?, name=?");
            foreach ($vars['id'] as $lang => $val){
                $stmt->execute(array(
                    $industryId,
                    $lang,
                    $vars['name'][$lang],
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

            $stmt = $this->db->prepare("UPDATE ".$this->table."_lang SET name=? WHERE id=?");

            foreach ($vars['id'] as $lang => $lang_id){
                $stmt->execute(array(
                    $vars['name'][$lang],
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