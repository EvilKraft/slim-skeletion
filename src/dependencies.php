<?php
/**
 * Created by PhpStorm.
 * Author: Konstantin Kaluzhnikov k.kaluzhnikov@gmail.com
 * Date: 22.08.2017
 */

use Symfony\Bridge\Twig\Extension\TranslationExtension;
use Symfony\Component\Translation\Loader\PhpFileLoader;
use Symfony\Component\Translation\MessageSelector;
use Symfony\Component\Translation\Translator;
use Symfony\Component\Translation\LoggingTranslator;

// DIC configuration
$container = $app->getContainer();

$container['environment'] = function () {

    $server = $_SERVER;

    // fix the secure environment detection if behind an AWS ELB
    if (isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] == 'https') {
        $server['HTTPS'] = 'on';
        $server['SERVER_PORT'] = 443;
    }

    return new Slim\Http\Environment($server);
};

// i18n
$container['i18n_logger'] = function ($c) {
    return new \Helpers\i18nLogger($c->get('settings')['i18n']['path'].DS.'dev.php');
};
$container['i18n'] = function ($c) {
    $settings = $c->get('settings')['i18n'];

    // First param is the "default language" to use.
    $translator = new Translator($settings['default_lang'], new MessageSelector());
    // Set a fallback language incase you don't have a translation in the default language
    $translator->setFallbackLocales($settings['fallback_langs']);
    // Add a loader that will get the php files we are going to store our translations in
    $translator->addLoader('php', new PhpFileLoader());
    // Add language files here
    foreach ($settings['langs'] as $lang){
        $domain = 'messages';
        $translator->addResource('php', $settings['path'].$domain.'.'.$lang.'.php', $lang, $domain);
    }

    return new LoggingTranslator($translator, $c->get('i18n_logger'));
};

$container['twig_profile'] = function () {
    return new \Twig_Profiler_Profile();
};

// view renderer
$container['renderer'] = function ($c) {
    $settings = $c->get('settings')['renderer'];

    $rType = key($settings);
    switch($rType){
        case 'twig' :
            $renderer = new \Slim\Views\Twig($settings[$rType]['template_path'], [
                'cache' => isset($settings[$rType]['cache_path']) ? $settings[$rType]['cache_path'] :false,
                'strict_variables' => true,
                'debug' => ($c->get('settings')['displayErrorDetails']) ? true : false,
            ]);
            $renderer->addExtension(new \Slim\Views\TwigExtension($c['router'], $c['request']->getUri()));
            $renderer->addExtension(new \Twig_Extension_Profiler($c['twig_profile']));
            $renderer->addExtension(new \Twig_Extension_Debug());
            $renderer->addExtension(new TranslationExtension($c->get('i18n')));
            $renderer->addExtension(new Twig_Extensions_Extension_Text());
            $renderer->addExtension(new Knlv\Slim\Views\TwigMessages(new Slim\Flash\Messages()));

            $renderer->getEnvironment()->addFilter(new \Twig_Filter('timeago',      \Helpers\Helpers::class.'::timeago'));
            $renderer->getEnvironment()->addFilter(new \Twig_Filter('phone_format', \Helpers\Helpers::class.'::phoneFormat' ));

            break;
        default :
            $renderer = new Slim\Views\PhpRenderer($settings[$rType]['template_path']); break;
    }

    return $renderer;
};

// monolog
//$container['logger'] = function ($c) {
//    $settings = $c->get('settings')['logger'];
//    $logger = new Monolog\Logger($settings['name']);
//    $logger->pushProcessor(new Monolog\Processor\UidProcessor());
//    $logger->pushHandler(new Monolog\Handler\StreamHandler($settings['path'], $settings['level']));
//    return $logger;
//};

$container['logger'] = function($c) {
    $settings = $c->get('settings')['logger'];

    $logger = new \Monolog\Logger($settings['name']);
    $stream = new \Monolog\Handler\StreamHandler($settings['path'], \Monolog\Logger::DEBUG);

    $stream->setFormatter(new \Monolog\Formatter\LineFormatter(
        "%datetime% > %level_name% > %message% %context% %extra%\n\n", // default format "[%datetime%] %channel%.%level_name%: %message% %context% %extra%\n"
        "Y-m-d H:i:s",
        true
    ));

    $logger->pushHandler(new \Monolog\Handler\FingersCrossedHandler(
        $stream, \Monolog\Logger::ERROR
    ));

    return $logger;
};


$container['errorHandler'] = function ($c) {
    return new \Handlers\ErrorHandler($c->settings['displayErrorDetails'], $c['logger'], $c['renderer']);
};
$container['phpErrorHandler'] = function ($c) {
    return new \Handlers\PhpErrorHandler($c->settings['displayErrorDetails'], $c['logger'], $c['renderer']);
};
//Override the default Not Found Handler
$container['notFoundHandler'] = function ($c) {
    return function ($request, $response) use ($c) {
        return $c->renderer->render($response, 'Errors/404.twig')
                    ->withStatus(404)
                    ->withHeader('Content-Type', 'text/html');
    };
};
$container['notAllowedHandler'] = function ($c) {
    return function ($request, $response, $methods) use ($c) {
        return $c->renderer->render($response, 'Errors/405.twig', ['methods' => $methods])
                    ->withStatus(405)
                    ->withHeader('Allow', implode(', ', $methods))
                    ->withHeader('Content-Type', 'text/html');
    };
};

// Doctrine DBAL
$container['db'] = function ($c) {
    $settings = $c['settings']['db'];

    $params = $settings['connections'][$settings['default']];

    $conn = \Doctrine\DBAL\DriverManager::getConnection(
        $params,
        new \Doctrine\DBAL\Configuration
    );
    // possible return or DBAL\Query\QueryBuilder or DBAL\Connection
    return $conn;
    //return $conn->createQueryBuilder();
};



$container['flash'] = function () {
    return new \Slim\Flash\Messages();
};


// Mail sender
$container['mailer'] = function ($container) {
    $config = $container->settings['SwiftMailer'];
    $transport = false;
    if ('smtp' === $config['transport']) {
        $transport = new \Swift_SmtpTransport();
        $options = [
            'host', 'port', 'encryption',
            'auth_mode', 'username', 'password'
        ];
    } elseif ('sendmail' === $config['transport']) {
        $transport = new \Swift_SendmailTransport();
        $options = ['command'];
    }

    if (!$transport) {
        return false;
    }

    if (isset($options) && is_array($options) && !empty($options)) {
        foreach ($options as $option) {
            if (isset($config[$option]) && $config[$option]) {
                $methodName = str_replace('_', ' ', $option);
                $methodName = ucwords($methodName);
                $methodName = str_replace(' ', '', $methodName);
                $methodName = 'set' . $methodName;
                $transport->{$methodName}($config[$option]);
            }
        }
    }
    return new \Swift_Mailer($transport);
};

if($container->get('settings')['displayErrorDetails'] === true){


    //http://discourse.slimframework.com/t/debugbar-for-slim3/158/7
    unset($container['errorHandler']);
    Tracy\Debugger::enable(  Tracy\Debugger::DEVELOPMENT, DIR.'logs');
    //Tracy\Debugger::enable(  Tracy\Debugger::PRODUCTION, DIR.'logs');
    //https://github.com/nette/tracy/issues/154#issuecomment-219694817
    Tracy\Debugger::dispatch();// from ver 2.4
    Tracy\Debugger::timer();

    Tracy\Debugger::$maxDepth = 5; // default: 3
    Tracy\Debugger::$maxLength = 200; // default: 150

  //  Tracy\Debugger::getBar()->addPanel(new ExamplePanel);

}

