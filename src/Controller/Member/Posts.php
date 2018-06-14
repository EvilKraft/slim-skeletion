<?php
/**
 * Created by PhpStorm.
 * Author: Konstantin Kaluzhnikov k.kaluzhnikov@gmail.com
 * Date: 22.08.2017
 */

namespace Controller\Member;

use \Controller\RESTController;
use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;
use \Symfony\Component\Config\Definition\Exception\Exception;

class Posts extends \Controller\Admin\Posts
{
    protected $table          = 'posts';
    protected $idxField       = 'postId';
  //  protected $template    = 'Admin\Posts.twig';
    protected $table_template = 'frontend_table.twig';

    protected        $columns      = ['title', 'createdAt', 'status'];
    protected static $actions      = ['create', 'update', 'delete'];

    protected $idxFieldLang = 'langId';

    public static function registerRoutes($app){
        $class  = static::class;
        $prefix = self::routePrefix();

        $app->get('',                      $class.':index')->setName($prefix);
        $app->map(['GET', 'POST'], '/new', $class.':create')->setName($prefix.'_create');

        $app->group('/{id:[0-9]+}', function () use ($app, $class, $prefix) {
            $app->get('',    $class.':get')->setName($prefix.'_get');
            $app->put('',    $class.':update')->setName($prefix.'_update');
            $app->delete('', $class.':delete')->setName($prefix.'_delete');

            $app->get('/move',   $class.':move')->setName($prefix.'_move');
        });

        $app->delete('/{ids: .+}', $class.':deleteSelected')->setName($prefix.'_deleteSelected');

        $app->get('/getTable',    $class.':dtServerProcessing')->setName($prefix.'_getTable');

        $app->post('/upload-file', $class.':uploadFile')->setName($prefix.'_upload_file');
        $app->post('/delete-file', $class.':deleteFile')->setName($prefix.'_delete_file');
    }

    public function dtServerProcessing(Request $request, Response $response, Array $args)
    {
        $l_columns = 'L.'.implode(', L.', array_keys($this->getTableColumns($this->table.'_lang', [$this->idxField, $this->idxFieldLang])));

        $table = "(
                SELECT T.*, ".$l_columns."
                FROM ".$this->table." T
                INNER JOIN ".$this->table."_lang L ON L.".$this->idxField." = T.".$this->idxField." AND L.lang = '".$this->lang."'
                WHERE T.userId = ".$_SESSION['user']['userId']."
                ORDER BY T.".$this->idxField." ASC
        ) temp";

        $dtColumns = $this->getDtColumns();
        $this->setFormatter($dtColumns, 'status', function( $d, $row ) {
            switch ($d){
                case 1  : $class = 'label-success'; $text = 'Approved';      break;
                case 0  : $class = 'label-warning'; $text = 'On moderation'; break;
                case -1 : $class = 'label-danger';  $text = 'Finished';      break;
            }

            return '<div class="text-center"><span class="label '.$class.'">'.$this->trans($text).'</span></div>';
        });

        $data = \Helpers\dataTableSSP::simple($request->getQueryParams(), $this->db, $table, $this->idxField, $dtColumns);

        return $response->withJson($data, 200);
    }
}