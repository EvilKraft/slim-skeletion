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

// Twig Globals Middleware
$app->add(function (Request $request, Response $response, callable $next) {
    $route = $request->getAttribute('route');

    $twigEnv = $this->get('renderer')->getEnvironment();

    $twigEnv->addGlobal('lang',               $this->lang);
    $twigEnv->addGlobal('langs',              $this->get('settings')['i18n']['langs']);
    $twigEnv->addGlobal('trans_catalogue',    json_encode([$this->lang => ['translation' => $this->get('i18n')->getCatalogue()->all('messages')]], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_NUMERIC_CHECK));

    $twigEnv->addGlobal('session',            $_SESSION);
    $twigEnv->addGlobal('session_id',         session_id());

    $twigEnv->addGlobal('currentRoute',       $route->getName());
    $twigEnv->addGlobal('currentUrl',         $request->getUri());
    $twigEnv->addGlobal('currentRouteArgs',   $request->getAttribute('routeInfo')[2]);

    $twigEnv->addGlobal('version',            $this->get('settings')['version']);

    $response = $next($request, $response);

    return $response;
});

// i18n middleware
$app->add(function (Request $request, Response $response, callable $next)
{
    $langSettings = $this->get('settings')['i18n'];

    $lang = $request->getAttribute('route')->getArgument('lang');

    if(!in_array($lang, $langSettings['langs'])){
        $lang = $langSettings['default_lang'];
        $request = $request->withAttribute('lang', $lang);
    }
    $this->lang = $lang;

    $translator = $this->get('i18n');
    $translator->setLocale($this->lang);

    // remove founded translations from log
    $this->get('i18n_logger')->checkTranslations($translator->getCatalogue());

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