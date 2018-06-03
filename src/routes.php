<?php
/**
 * Created by PhpStorm.
 * Author: Konstantin Kaluzhnikov k.kaluzhnikov@gmail.com
 * Date: 22.08.2017
 */

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

// Routes

$langSetings = $app->getContainer()->get('settings')['i18n'];
$langRegExp = implode('|', $langSetings['langs']);

$app->any('/', function (Request $request, Response $response, Array $args) use ($app) {
    $langSetings = $app->getContainer()->get('settings')['i18n'];
    return $response->withStatus(302)->withHeader('Location', $this->router->pathFor('home', ['lang' => $langSetings['default_lang']]));
});

$app->group('/locales', function () use ($app, $langRegExp) {
    $this->get('/{lang:'.$langRegExp.'}/{ns}.json', \Controller\i18n::class.':getResource');
    $this->post('/add/{lang}/{ns}',                 \Controller\i18n::class.':addMissingKey');
});




$app->group('/{lang:'.$langRegExp.'}', function () use ($app) {
    $this->get('', \Controller\Frontend::class.':index')->setName('home');

    $this->get('/about',                    \Controller\Frontend::class.':about')->setName('about');
    $this->get('/privacy',                  \Controller\Frontend::class.':privacy')->setName('privacy');
    $this->get('/rules',                    \Controller\Frontend::class.':rules')->setName('rules');
    $this->map(['GET', 'POST'], '/contact', \Controller\Frontend::class.':contact')->setName('contact');

    $this->get('/industries/',                            \Controller\Frontend::class.':blogss')->setName('blogs');
    $this->get('/industry/{id:[0-9]+}[/page/{page:\d+}]', \Controller\Frontend::class.':blog')->setName('blog');
    $this->get('/post/{id:[0-9]+}',                       \Controller\Frontend::class.':post')->setName('post');

    $this->get('/search[/page/{page:\d+}]',               \Controller\Frontend::class.':searchPost')->setName('search');

    $this->group('/member', function () use ($app) {
        $this->get('',                          \Controller\Member\User::class.':dashboard')->setName('member_dashboard');
        $this->map(['GET', 'PUT'],  '/profile', \Controller\Member\User::class.':profile')->setName('member_profile');
        $this->map(['GET', 'POST'], '/support', \Controller\Member\User::class.':support')->setName('member_support');
        $this->get('/help',                     \Controller\Member\User::class.':help')->setName('member_help');

        $this->group('/posts',      \Controller\Member\Posts::class.'::registerRoutes');

    })->add(\Controller\Auth::class.':checkAuth');

})->add(\Controller\Frontend::class.':frontendMiddleware');

$app->group('/{lang:'.$langRegExp.'}', function () use ($app) {
    $this->group('', function () use ($app) {
        $this->map(['GET', 'POST'], '/login',           \Controller\Auth::class.':login')->setName('login');
        $this->map(['GET', 'POST'], '/register',        \Controller\Auth::class.':Register')->setName('register');
        $this->map(['GET', 'POST'], '/forgot-password', \Controller\Auth::class.':forgotPassword')->setName('forgotPassword');
    })->add(\Controller\Frontend::class.':frontendMiddleware');
    $this->get('/check-exists',                     \Controller\Auth::class.':checkNotExists')->setName('checkNotExists');
    $this->get('/confirm-mail/{code:.+}',           \Controller\Auth::class.':confirmMail')->setName('confirmMail');
    $this->any('/logout',                           \Controller\Auth::class.':logout')->setName('logout');


    $this->group('/admin', function () use ($app) {
        $this->get('',              \Controller\Admin\Dashboard::class.':index')->setName('admin_dashboard');
        $this->group('/posts',      \Controller\Admin\Posts::class.'::registerRoutes');
        $this->group('/users',      \Controller\Admin\Users::class.'::registerRoutes');
        $this->group('/industries', \Controller\Admin\Industries::class.'::registerRoutes');
        $this->group('/pages',      \Controller\Admin\Pages::class.'::registerRoutes');
        $this->group('/help',       \Controller\Admin\Help::class.'::registerRoutes');
    })->add(\Controller\Auth::class.':checkIsAdmin')
      ->add(\Controller\Auth::class.':checkAuth');
});

$app->get('/img[/{image_name:.*}]', function (Request $request, Response $response, Array $args) {

    $server = \League\Glide\ServerFactory::create([
        'source' => DIR.'public',
        'cache' => DIR.'cache',
        'source_path_prefix' => 'uploads',
        'cache_path_prefix'  => 'thumbnails',
        'response' => new \League\Glide\Responses\SlimResponseFactory(),

        'max_image_size' => 2000*2000,

        // <img src="kayaks.jpg?p=small">
        'presets' => [
            'xs' => ['w' => 130, 'h' => 100, 'fit' => 'crop',],
            's'  => ['w' => 200, 'h' => 200, 'fit' => 'crop',],
            'm'  => ['w' => 600, 'h' => 400, 'fit' => 'crop',],


            'rp'   => ['w' => 100, 'h' =>  80, 'fit' => 'crop',],
            'bs1'  => ['w' => 181, 'h' => 100, 'fit' => 'crop',],
            'bs4'  => ['w' => 218, 'h' => 120, 'fit' => 'crop',],
            'bs5'  => ['w' => 309, 'h' => 170, 'fit' => 'crop',],
        ]
    ]);


    if(!$server->sourceFileExists($args['image_name'])){
        $args['image_name'] = '../resources/img/default-placeholder.png';
    }

    $mimeType = $server->getSource()->getMimetype($server->getSourcePath($args['image_name']));
    if(!in_array($mimeType, ['image/gif', 'image/jpeg', 'image/png'])){
        $args['image_name'] = '../resources/img/default-placeholder.png';
    }

    return $server->getImageResponse($args['image_name'], $request->getQueryParams());

})->setName('image');


