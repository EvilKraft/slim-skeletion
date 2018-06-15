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

class BannersClients extends \Controller\RESTController
{
    protected $table     = 'bannersClients';
    protected $idxField  = 'clientId';
    protected $template  = 'Admin\BannersClients.twig';

    protected        $columns   = ['name', 'email', 'phone'];
    protected static $actions   = ['create', 'update', 'delete'];

}