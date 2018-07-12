<?php
/**
 * Created by PhpStorm.
 * Author: Konstantin Kaluzhnikov k.kaluzhnikov@gmail.com
 * Date: 22.08.2017
 */

namespace Controller\Admin;

use Controller\RESTController;
use Interfaces\Node;
use Interfaces\Tree;
use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;
use Symfony\Component\Config\Definition\Exception\Exception;

class Content extends \Controller\MPTTController
{
    protected $table     = 'content';
    protected $idxField  = 'contentId';
    protected $template  = 'Admin\Content.twig';

    protected        $columns   = ['title', 'alias',];
    protected static $actions   = [ 'move', 'addChild', 'create', 'update', 'delete', ];

    protected $idxFieldLang = 'langId';




    protected function doCreate(Request $request, Response $response)
    {
        try {
            $this->db->beginTransaction();

            $vars      = $this->getPostedVars($request);

            if(isset($vars['parentId']) && !empty($vars['parentId'])){
                $this->addChild($vars['parentId'], $vars);

                $lastId = $this->db->lastInsertId();
            }else{
                unset($vars['parentId']);
                $tree = $this->createTree($vars);

                $lastId = $tree[$this->idxField];
            }

       //     echo '<pre>'.print_r($tree, true).'</pre>';
        //    echo '<pre>'.print_r($lastId, true).'</pre>'; exit;

            if(!empty($this->idxFieldLang)){
                $tableColumns = $this->getTableColumns($this->table.'_lang');

                $vars_lang = array();
                foreach ($this->settings['i18n']['langs'] as $lang){
                    $vars = array_intersect_key($request->getParsedBody()[$lang], $tableColumns);
                    $vars_lang[$lang] = array_merge_recursive( [$this->idxField => $lastId, 'lang' => $lang ], $vars);
                }
                $colNames  = implode(', ', array_keys(reset($vars_lang)));
                $questions = implode(',', array_fill(0, count(reset($vars_lang)), '?'));

                $stmt = $this->db->prepare("INSERT INTO ".$this->table."_lang (".$colNames.") VALUES (".$questions.")");

                foreach ($vars_lang as $lang => $vars){
                    $stmt->execute(array_values($vars));
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

    protected function extraFormData(){
        parent::extraFormData();

        $sql = "SELECT T.".$this->idxField.", T.".$this->lvl.", L.title
                FROM ".$this->table." T
                INNER JOIN ".$this->table."_lang L ON T.".$this->idxField." = L.".$this->idxField." AND lang = ?
                ORDER BY T.".$this->treeId.", T.".$this->lft;
        $stmt = $this->db->prepare($sql);
        $stmt->execute([$this->lang]);
        $this->data['parents'] = $stmt->fetchAll();

    }
}