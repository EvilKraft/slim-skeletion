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

class Posts extends \Controller\Admin\Pages
{
    protected $table        = 'posts';
    protected $idxField     = 'postId';
  //  protected $template    = 'Admin\Posts.twig';

    protected $columns      = ['title', 'createdAt'];
    protected $actions      = ['create', 'update', 'delete'];

    protected $idxFieldLang = 'langId';

    public static function registerRoutes($app){
        \Controller\RESTController::registerRoutes($app);

        $class  = static::class;
        $prefix = self::routePrefix();

        $app->post('/upload-file', $class.':uploadFile')->setName($prefix.'_upload_file');
        $app->post('/delete-file', $class.':deleteFile')->setName($prefix.'_delete_file');
    }

}