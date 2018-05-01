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

class Pages extends \Controller\RESTController
{
    protected $table        = 'pages';
    protected $idxField     = 'pageId';
    protected $template     = 'Admin\Pages.twig';

    protected $columns      = ['alias', 'title'];
    protected $actions      = ['create', 'update'];

    protected $idxFieldLang = 'langId';

    public static function registerRoutes($app){
        $class  = static::class;
        $prefix = self::routePrefix();

        $app->get('',                      $class.':index')->setName($prefix);
        $app->map(['GET', 'POST'], '/new', $class.':create')->setName($prefix.'_create');

        $app->group('/{id:[0-9]+}', function () use ($app, $class, $prefix) {
            $app->get('',    $class.':get')->setName($prefix.'_get');
            $app->put('',    $class.':update')->setName($prefix.'_update');
 //           $app->delete('', $class.':delete')->setName($prefix.'_delete');
        });

  //      $app->delete('/{ids: .+}', $class.':deleteSelected')->setName($prefix.'_deleteSelected');

        $app->get('/getTable',    $class.':dtServerProcessing')->setName($prefix.'_getTable');
    }

    protected function extraFormData()
    {
        $this->data['langs'] = $this->settings['i18n']['langs'];

        $stmt = $this->db->prepare("SELECT * FROM ".$this->table."_lang WHERE pageId = ?");
        $stmt->execute(array($this->data['item']['id']));
        while ($row = $stmt->fetch()){
            $this->data['item_langs'][$row['lang']] = $row;
        }

    }

    protected function doCreate(Request $request, Response $response)
    {
        $vars = $request->getParsedBody();

        try {
            $this->db->beginTransaction();

            $stmt = $this->db->prepare("INSERT INTO ".$this->table." SET alias=?");
            $stmt->execute([$vars['alias']]);

            $pageId = $this->db->lastInsertId();

            $stmt = $this->db->prepare("INSERT INTO ".$this->table."_lang SET pageId=?, lang=?, title=?, keywords=?, description=?, text=?");
            foreach ($vars['id'] as $lang => $val){
                $stmt->execute(array(
                    $pageId,
                    $lang,
                    $vars['title'][$lang],
                    $vars['keywords'][$lang],
                    $vars['description'][$lang],
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

            $stmt = $this->db->prepare("UPDATE ".$this->table."_lang SET title=?, keywords=?, description=?, text=? WHERE id=?");

            foreach ($vars['id'] as $lang => $lang_id){
                $stmt->execute(array(
                    $vars['title'][$lang],
                    $vars['keywords'][$lang],
                    $vars['description'][$lang],
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