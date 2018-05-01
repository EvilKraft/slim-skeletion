<?php
/**
 * Created by PhpStorm.
 * Author: Konstantin Kaluzhnikov k.kaluzhnikov@gmail.com
 * Date: 22.08.2017
 */

namespace Interfaces;

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

interface RESTInterface
{
    public function index(Request $request, Response $response, Array $args);
    public function get(Request $request, Response $response, Array $args);
    public function create(Request $request, Response $response, Array $args);
    public function update(Request $request, Response $response, Array $args);
    public function delete(Request $request, Response $response, Array $args);

}