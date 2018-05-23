<?php
/**
 * Created by PhpStorm.
 * Author: Konstantin Kaluzhnikov k.kaluzhnikov@gmail.com
 * Date: 22.08.2017
 */

if (PHP_SAPI == 'cli-server') {
    // To help the built-in PHP dev server, check if the request was actually for
    // something which should probably be served as a static file
    $url  = parse_url($_SERVER['REQUEST_URI']);
    $file = __DIR__ . $url['path'];
    if (is_file($file)) {
        return false;
    }
}

session_start();

defined('DS') || define('DS', DIRECTORY_SEPARATOR);
define('DIR', realpath(__DIR__ . '/../') . DS);

/*
spl_autoload_register(function ($classname) {
    require ("../src/" . $classname . ".php");
});
*/

$loader = require_once DIR.'vendor'.DS.'autoload.php';
$loader->add('Controller', DIR.'src'.DS);
$loader->add('Handlers',   DIR.'src'.DS);
$loader->add('Helpers',    DIR.'src'.DS);
$loader->add('Interfaces', DIR.'src'.DS);
$loader->add('Middleware', DIR.'src'.DS);

RunTracy\Helpers\Profiler\Profiler::enable();
RunTracy\Helpers\Profiler\Profiler::start('App');

// Instantiate the app
RunTracy\Helpers\Profiler\Profiler::start('loadSettings');
$settings = require_once DIR.'src'.DS.'settings.php';
if(file_exists(DIR.'src'.DS.'settings.local.php')){
    $localSettings = require_once DIR.'src'.DS.'settings.local.php';
    $settings = array_replace_recursive($settings, $localSettings);
}
RunTracy\Helpers\Profiler\Profiler::finish('loadSettings');

date_default_timezone_set($settings['settings']['date_default_timezone']);

RunTracy\Helpers\Profiler\Profiler::start('initApp');
$app = new \Slim\App($settings);
RunTracy\Helpers\Profiler\Profiler::finish('initApp');


// Set up dependencies
RunTracy\Helpers\Profiler\Profiler::start('RegisterDependencies');
require_once DIR.'src/dependencies.php';
RunTracy\Helpers\Profiler\Profiler::finish('RegisterDependencies');


// Register middleware
RunTracy\Helpers\Profiler\Profiler::start('RegisterMiddlewares');
require_once DIR.'src/middleware.php';
RunTracy\Helpers\Profiler\Profiler::finish('RegisterMiddlewares');


// Register routes
RunTracy\Helpers\Profiler\Profiler::start('RegisterRoutes');
require_once DIR.'src/routes.php';
RunTracy\Helpers\Profiler\Profiler::finish('RegisterRoutes');


// Run app
RunTracy\Helpers\Profiler\Profiler::start('runApp, %s, line %s', basename(__FILE__), __LINE__);
$app->run();
RunTracy\Helpers\Profiler\Profiler::finish('runApp, %s, line %s', basename(__FILE__), __LINE__);

RunTracy\Helpers\Profiler\Profiler::finish('App');
