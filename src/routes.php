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
    $this->get('/sitemap',                  \Controller\Frontend::class.':sitemap')->setName('sitemap');
    $this->map(['GET', 'POST'], '/contact', \Controller\Frontend::class.':contact')->setName('contact');

    $this->get('/industries/',                            \Controller\Frontend::class.':blogss')->setName('blogs');
    $this->get('/industry/{id:[0-9]+}[/page/{page:\d+}]', \Controller\Frontend::class.':blog')->setName('blog');

    $this->get('/post/{id:[0-9]+}',                       \Controller\Frontend::class.':post')->setName('post');

    $this->group('/tenders', function () use ($app) {
        $this->get('',                      \Controller\Tenders\Tenders::class.':index')->setName('tenders');
        $this->map(['GET', 'POST'], '/new', \Controller\Tenders\Tenders::class.':create')->setName('tenders_create');

        $this->group('/{id:[0-9]+}', function () {
            $this->get('',              \Controller\Tenders\Tenders::class.':get')->setName('tenders_get');
            $this->put('',              \Controller\Tenders\Tenders::class.':update')->setName('tenders_update');
        });

        $this->post('/upload-file', \Controller\Tenders\Tenders::class.':uploadFile')->setName('tenders_upload_file');
        $this->post('/delete-file', \Controller\Tenders\Tenders::class.':deleteFile')->setName('tenders_delete_file');
    })
    ->add(\Controller\Auth::class.':checkAuth');


    $this->group('/members', function () use ($app) {


    })->add(\Controller\Auth::class.':checkAuth');

    $this->group('/user', function () use ($app) {
        $this->get('',                          \Controller\User::class.':dashboard')->setName('dashboard');

        $this->map(['GET', 'PUT'],  '/profile', \Controller\User::class.':profile')->setName('profile');
        $this->map(['GET', 'POST'], '/support', \Controller\User::class.':support')->setName('support');
        $this->get('/help',                     \Controller\User::class.':help')->setName('help');

        $this->group('/posts', function () use ($app) {
            $this->get('',                      \Controller\Posts::class.':index')->setName('posts');
            $this->map(['GET', 'POST'], '/new', \Controller\Posts::class.':create')->setName('posts_create');

            $this->group('/{id:[0-9]+}', function () {
                $this->get('', \Controller\Posts::class.':get')->setName('posts_get');
                $this->put('', \Controller\Posts::class.':update')->setName('posts_update');
            });

            $this->post('/upload-file', \Controller\Posts::class.':uploadFile')->setName('posts_upload_file');
            $this->post('/delete-file', \Controller\Posts::class.':deleteFile')->setName('posts_delete_file');
        });
    })
    ->add(\Controller\Auth::class.':checkAuth');


    $this->group('/admin', function () use ($app) {
        $this->get('',              \Controller\Admin\Dashboard::class.':index')->setName('admin_dashboard');

        $this->group('/tenders',    \Controller\Admin\Tenders::class.'::registerRoutes');

        $this->group('/posts',      \Controller\Admin\Posts::class.'::registerRoutes');

        $this->group('/users',      \Controller\Admin\Users::class.'::registerRoutes');
        $this->group('/industries', \Controller\Admin\Industries::class.'::registerRoutes');
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

$app->get('/img[/{image_name:.*}]', function (Request $request, Response $response, Array $args) {

    $server = \League\Glide\ServerFactory::create([
        'source' => DIR.'public/uploads',
        'cache' => DIR.'public/cache',
        'response' => new \League\Glide\Responses\SlimResponseFactory(),
    ]);

    return $server->getImageResponse($args['image_name'], $request->getQueryParams());

})->setName('image');


