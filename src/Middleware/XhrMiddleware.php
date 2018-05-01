<?php
/**
 * Created by PhpStorm.
 * User: Kraft
 * Date: 18.01.2018
 * Time: 11:05
 */

namespace Middleware;

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

class XhrMiddleware
{

    public function __construct(\Slim\Container $container)
    {

    }

    public function __invoke(Request $request, Response $response, callable $next)
    {
        if (!$request->isXhr()) {
            throw new \Slim\Exception\NotFoundException($request, $response);
        }

        // add media parser to automatically parse JSON that is sent with a text/javascript
        $request->registerMediaTypeParser(
            "text/javascript",
            function ($input) {
                return json_decode($input, true);
            }
        );

        return $next($request, $response);
    }
}