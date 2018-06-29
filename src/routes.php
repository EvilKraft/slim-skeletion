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
    $this->get('/{lang:'.$langRegExp.'|dev}/{ns}.json', \Controller\i18n::class.':getResource');
    $this->post('/add/{lang}/{ns}',                 \Controller\i18n::class.':addMissingKey');
});




$app->group('/{lang:'.$langRegExp.'}', function () use ($app) {
    $this->get('', \Controller\Frontend::class.':index')->setName('home');

    $this->get('/about',                    \Controller\Frontend::class.':about')->setName('about');
    $this->get('/privacy',                  \Controller\Frontend::class.':privacy')->setName('privacy');
    $this->get('/rules',                    \Controller\Frontend::class.':rules')->setName('rules');
    $this->map(['GET', 'POST'], '/contact', \Controller\Frontend::class.':contact')->setName('contact');

    $this->get('/industry/{id:[0-9]+}[/page/{page:\d+}]', \Controller\Frontend::class.':blog')->setName('blog');
    $this->get('/type/{id:[0-9]+}[/page/{page:\d+}]',     \Controller\Frontend::class.':postType')->setName('postType');
    $this->get('/post/{id:[0-9]+}',                       \Controller\Frontend::class.':post')->setName('post');

    $this->get('/search[/page/{page:\d+}]',               \Controller\Frontend::class.':searchPost')->setName('search');

    $this->group('/member', function () use ($app) {
        $this->get('',                          \Controller\Member\User::class.':dashboard')->setName('member_dashboard');
        $this->map(['GET', 'PUT'],  '/profile', \Controller\Member\User::class.':profile')->setName('member_profile');
        $this->group('/posts',                  \Controller\Member\Posts::class.'::registerRoutes');
    })->add(\Controller\Auth::class.':checkAuth');

})->add(\Controller\Frontend::class.':frontendMiddleware');

$app->group('/{lang:'.$langRegExp.'}', function () use ($app) {
    $this->group('', function () use ($app) {
        $this->map(['GET', 'POST'], '/login',           \Controller\Auth::class.':login')->setName('login');
        $this->map(['GET', 'POST'], '/register',        \Controller\Auth::class.':Register')->setName('register');
        $this->map(['GET', 'POST'], '/forgot-password', \Controller\Auth::class.':forgotPassword')->setName('forgotPassword');
        $this->get('/confirm-mail/{code:.+}',           \Controller\Auth::class.':confirmMail')->setName('confirmMail');
    })->add(\Controller\Frontend::class.':frontendMiddleware');
    $this->get('/check-exists',                     \Controller\Auth::class.':checkNotExists')->setName('checkNotExists');
    $this->any('/logout',                           \Controller\Auth::class.':logout')->setName('logout');


    $this->group('/admin', function () use ($app) {
        $this->get('',                         \Controller\Admin\Dashboard::class.':index')->setName('admin_dashboard');
        $this->map(['GET', 'PUT'], '/profile', \Controller\Admin\Users::class.':profile')->setName('admin_profile');

        $this->group('/posts',      \Controller\Admin\Posts::class.'::registerRoutes');
        $this->group('/users',      \Controller\Admin\Users::class.'::registerRoutes');
        $this->group('/posttypes',  \Controller\Admin\PostTypes::class.'::registerRoutes');
        $this->group('/industries', \Controller\Admin\Industries::class.'::registerRoutes');
        $this->group('/pages',      \Controller\Admin\Pages::class.'::registerRoutes');

        $this->group('/banners',        \Controller\Admin\Banners::class.'::registerRoutes');
        $this->group('/bannersClients', \Controller\Admin\bannersClients::class.'::registerRoutes');

        $this->group('/translations',      \Controller\Admin\Translations::class.'::registerRoutes');

    })->add(\Controller\Auth::class.':checkIsAdmin')
      ->add(\Controller\Auth::class.':checkAuth');
});

$app->get('/img[/{image_name:.*}]', \Controller\Image::class)->setName('image');


