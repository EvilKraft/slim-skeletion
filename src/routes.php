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

    $this->get('/blog[/{page:\d+}]',        \Controller\Frontend::class.':blog')->setName('blog');
    $this->get('/about',                    \Controller\Frontend::class.':about')->setName('about');
    $this->get('/services',                 \Controller\Frontend::class.':services')->setName('services');
    $this->get('/partners',                 \Controller\Frontend::class.':partners')->setName('partners');
    $this->get('/rules',                    \Controller\Frontend::class.':rules')->setName('rules');
    $this->map(['GET', 'POST'], '/contact', \Controller\Frontend::class.':contact')->setName('contact');


    $this->group('/tenders', function () use ($app) {
        $this->get('',                      \Controller\Tenders\Tenders::class.':index')->setName('tenders');
        $this->map(['GET', 'POST'], '/new', \Controller\Tenders\Tenders::class.':create')->setName('tenders_create');

        $this->group('/{id:[0-9]+}', function () {
            $this->get('',              \Controller\Tenders\Tenders::class.':get')->setName('tenders_get');
            $this->put('',              \Controller\Tenders\Tenders::class.':update')->setName('tenders_update');

            $this->get('/suppliers',    \Controller\Tenders\Tenders::class.':suppliers')->setName('tenders_suppliers');

            $this->get('/buy-access',   \Controller\Tenders\Tenders::class.':buyAccess')->setName('tenders_buy_access');
            $this->get('/access',       \Controller\Tenders\Tenders::class.':access')->setName('tenders_access');
            $this->post('/participate', \Controller\Tenders\Tenders::class.':participate')->setName('tenders_participate');
            $this->get('/finish',       \Controller\Tenders\Tenders::class.':finish')->setName('tenders_finish');

            $this->map(['GET', 'POST'], '/messages[/{accessId:[0-9]+}]', \Controller\Tenders\Tenders::class.':messages')->setName('tenders_msgs');
        });

        $this->post('/upload-file', \Controller\Tenders\Tenders::class.':uploadFile')->setName('tenders_upload_file');
        $this->post('/delete-file', \Controller\Tenders\Tenders::class.':deleteFile')->setName('tenders_delete_file');
    })
    ->add(\Controller\Auth::class.':checkAuth');

    $this->group('/chat', function () use ($app) {
        $this->post('/save',   \Controller\Tenders\Chat::class.':save')->setName('chat_save');
        $this->post('/update', \Controller\Tenders\Chat::class.':getUnreaded')->setName('chat_update');

        $this->post('/vote', \Controller\Tenders\Chat::class.':vote')->setName('chat_vote');
    })
    ->add(\Middleware\XhrMiddleware::class)
    ->add(\Controller\Auth::class.':checkAuth');


    $this->group('/user', function () use ($app) {
        $this->map(['GET', 'PUT'],  '',         \Controller\User::class.':profile')->setName('profile');
        $this->map(['GET', 'POST'], '/support', \Controller\User::class.':support')->setName('support');
        $this->get('/help',                     \Controller\User::class.':help')->setName('help');
    })
    ->add(\Controller\Auth::class.':checkAuth');


    $this->group('/admin', function () use ($app) {
        $this->group('/tenders',    \Controller\Admin\Tenders::class.'::registerRoutes');
        $this->group('/users',      \Controller\Admin\Users::class.'::registerRoutes');
        $this->group('/industries', \Controller\Admin\Industries::class.'::registerRoutes');
        $this->group('/blog',       \Controller\Admin\Blog::class.'::registerRoutes');
        $this->group('/pages',      \Controller\Admin\Pages::class.'::registerRoutes');
        $this->group('/help',       \Controller\Admin\Help::class.'::registerRoutes');
        $this->group('/reports',    \Controller\Reports::class.'::registerRoutes');

        $this->group('/test',       \Controller\RESTController::class.'::registerRoutes');
    })
    ->add(\Controller\Auth::class.':checkIsAdmin')
    ->add(\Controller\Auth::class.':checkAuth');


    $this->get('/why-reg',                          \Controller\Auth::class.':whyReg')->setName('why_reg');
    $this->map(['GET', 'POST'], '/login',           \Controller\Auth::class.':login')->setName('login');
    $this->map(['GET', 'POST'], '/register',        \Controller\Auth::class.':Register')->setName('register');
    $this->map(['GET', 'POST'], '/forgot-password', \Controller\Auth::class.':forgotPassword')->setName('forgotPassword');
    $this->get('/check-login',                      \Controller\Auth::class.':checkLogin')->setName('checkLogin');
    $this->get('/check-email',                      \Controller\Auth::class.':checkEmail')->setName('checkEmail');
    $this->get('/confirm-mail/{code:.+}',           \Controller\Auth::class.':confirmMail')->setName('confirmMail');
    $this->any('/logout',                           \Controller\Auth::class.':logout')->setName('logout');

});


