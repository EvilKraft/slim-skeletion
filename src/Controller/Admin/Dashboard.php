<?php
/**
 * Created by PhpStorm.
 * Author: Konstantin Kaluzhnikov k.kaluzhnikov@gmail.com
 * Date: 22.08.2017
 */

namespace Controller\Admin;

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

class Dashboard extends \Controller\BaseController
{
    protected  $data = [];

    public function index(Request $request, Response $response, Array $args)
    {
        $this->data['pageTitle'] = $this->trans('Dashboard');


        return $this->renderer->render($response, 'Admin/Dashboard.twig', $this->data);
    }
}