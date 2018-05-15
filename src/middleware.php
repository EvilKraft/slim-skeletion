<?php
/**
 * Created by PhpStorm.
 * Author: Konstantin Kaluzhnikov k.kaluzhnikov@gmail.com
 * Date: 22.08.2017
 */

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

// Application middleware

// e.g: $app->add(new \Slim\Csrf\Guard);

$app->add(new \RunTracy\Middlewares\TracyMiddleware($app));

$app->add(function (Request $request, Response $response, callable $next) {
    $route = $request->getAttribute('route');

    $translator = $this->get('i18n');
    $translator->setLocale($this->lang);

//    $this->get('renderer')->getEnvironment()->addGlobal('trans_catalogue',    json_encode($translator->getCatalogue()->all('messages'), JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_NUMERIC_CHECK));

    $this->get('renderer')->getEnvironment()->addGlobal('lang',               $this->lang);
    $this->get('renderer')->getEnvironment()->addGlobal('langs',              $this->get('settings')['i18n']['langs']);

    $this->get('renderer')->getEnvironment()->addGlobal('session',            $_SESSION);
    $this->get('renderer')->getEnvironment()->addGlobal('session_id',         session_id());

    $this->get('renderer')->getEnvironment()->addGlobal('currentRoute',       $route->getName());
    $this->get('renderer')->getEnvironment()->addGlobal('currentUrl',         $request->getUri());
    $this->get('renderer')->getEnvironment()->addGlobal('currentRouteArgs',   $request->getAttribute('routeInfo')[2]);

    $this->get('renderer')->getEnvironment()->addGlobal('flash_messages',     $this->flash->getMessages());

    $this->get('renderer')->getEnvironment()->addGlobal('version',            $this->get('settings')['version']);

    $response = $next($request, $response);

    return $response;
});


$app->add(function (Request $request, Response $response, callable $next)
{
    $langSettings = $this->get('settings')['i18n'];

    $lang = $request->getAttribute('route')->getArgument('lang');

    if(!in_array($lang, $langSettings['langs'])){
        $lang = $langSettings['default_lang'];
        $request = $request->withAttribute('lang', $lang);
    }

    $this->lang = $lang;

    $response = $next($request, $response);
    return $response;
});


$app->add(function (Request $request, Response $response, callable $next) {
    $route = $request->getAttribute('route');
    if(!($route instanceof Slim\Route)){
        throw new \Slim\Exception\NotFoundException($request, $response);
    }

    return $next($request, $response);
});

// Trailing / in route patterns
$app->add(function (Request $request, Response $response, callable $next) {
    $uri = $request->getUri();
    $path = $uri->getPath();
    if ($path != '/' && substr($path, -1) == '/') {
        // permanently redirect paths with a trailing slash
        // to their non-trailing counterpart
        $uri = $uri->withPath(substr($path, 0, -1));

        if($request->getMethod() == 'GET') {
            return $response->withRedirect((string)$uri, 301);
        }
        else {
            return $next($request->withUri($uri), $response);
        }
    }

    return $next($request, $response);
});