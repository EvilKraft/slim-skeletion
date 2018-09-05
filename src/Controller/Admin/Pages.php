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

    protected        $columns      = ['alias', 'title'];
    protected static $actions      = ['update'];

    protected $idxFieldLang = 'langId';

}