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

    protected        $columns   = ['title'];
    protected static $actions   = ['create', 'update', 'delete'];

    protected $idxFieldLang = 'langId';

}