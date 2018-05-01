<?php
/**
 * Created by PhpStorm.
 * Author: Konstantin Kaluzhnikov k.kaluzhnikov@gmail.com
 * Date: 22.08.2017
 */


date_default_timezone_set('GMT+4');

return [
    'settings' => [
        'version'   => '1.0.0.1',

        'displayErrorDetails'               => true,   // set to false in production
        'addContentLengthHeader'            => false,   // Allow the web server to send the content-length header
        'determineRouteBeforeAppMiddleware' => true,    // Only set this if you need access to route within middleware

        // Renderer settings
        'renderer' => [
            'twig' => [
                'template_path' => DIR.'templates'.DS,
                //'cache_path'    => DIR.'cache'.DS,
            ],
            'php' => [
                'template_path' => DIR.'templates'.DS,
            ],
        ],

        // Monolog settings
        'logger' => [
            'name' => 'slim-app',
            'path' => DIR.'logs'.DS.'app.log',
            'level' => \Monolog\Logger::DEBUG,
            'maxFiles' => 15,
        ],

        // DB settings
        'db' => [// multi database configuration
            'default' => 'mysql',
            'connections' => [
                'sqlite' => [
                    'driver'   => 'pdo_sqlite',
                    'user'     => 'user',
                    'password' => 'password',
                    'path'     => DIR.'database/database.sqlite',
                    'memory'   => false,
                ],
                'mysql' => [
                    'driver'   => 'pdo_mysql',
                    'host'     => 'localhost',
                    'port'     => '3306',
                    'dbname'   => 'slimDB',
                    'user'     => 'root',
                    'password' => '',
                    'charset'  => 'utf8',
                //    'unix_socket'   => 'unix_socket',
                    'driverOptions' => [
                        PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES 'utf8', CHARACTER SET 'utf8', SESSION collation_connection = 'utf8_general_ci'",
                    ]
                ],
                'pgsql' => [
                    'driver'   => 'pdo_pgsql',
                    'host'     => 'localhost',
                    'dbname'   => 'run',
                    'user'     => 'dbuser',
                    'password' => '123',
                    'charset'  => 'utf8',
                ],
                'mssql' => [
                    'driver'   => 'sqlsrv',
                    'host'     => 'localhost',
                    'dbname'   => 'database',
                    'user'     => 'root',
                    'password' => '',
                ],
                'oci8' => [
                    'driver'      => 'oci8',
                    'host'        => 'localhost',
                    'port'        => '1521',
                    'dbname'      => 'myDB',
                    'servicename' => 'servicename',
                    'user'        => 'zzzzz',
                    'password'    => 'xxxxx',
                    'charset'     => 'utf8',
                ],
            ],
        ],


        // i18n settings
        'i18n' => [
            'langs'         => ['en', 'ru', 'az'],
            'default_lang'  => 'az',
            'path'          => DIR.'langs'.DS,
        ],

        // Mailer settings
        'SwiftMailer' => [
            'transport'  => 'smtp',   						  // smtp, sendmail, false
            'auth_mode'  => 'login', 						    // plain, login, cram-md5, or null
            'username'   =>	'noreply@mysite.com',
            'password'   => '123456',
            'host'       => 'mail.mysite.com',
            'port'       => '25', 								//'587',
            //'encryption' => 'none',    							 // tls, ssl, or null
            'command'    => null,  								 // for sendmail
        ],
        'info_mail'          => ['noreply@mysite.com' => 'mysite.com'],
        'mailer_queue_limit' => 10,


        'tracy' => [
            'showPhpInfoPanel' => 1,
            'showSlimRouterPanel' => 0,
            'showSlimEnvironmentPanel' => 0,
            'showSlimRequestPanel' => 1,
            'showSlimResponsePanel' => 1,
            'showSlimContainer' => 0,
            'showEloquentORMPanel' => 0,
            'showTwigPanel' => 0,
            'showIdiormPanel' => 0,// > 0 mean you enable logging
            // but show or not panel you decide in browser in panel selector
            'showDoctrinePanel' => 'db',// here also enable logging and you must enter your Doctrine container name
            // and also as above show or not panel you decide in browser in panel selector
            'showProfilerPanel' => 0,
            'showVendorVersionsPanel' => 0,
            'showXDebugHelper' => 0,
            'showIncludedFiles' => 0,
            'showConsolePanel' => 0,
            'configs' => [
                // XDebugger IDE key
                'XDebugHelperIDEKey' => 'PHPSTORM',
                // Disable login (don't ask for credentials, be careful) values( 1 || 0 )
                'ConsoleNoLogin' => 0,
                // Multi-user credentials values( ['user1' => 'password1', 'user2' => 'password2'] )
                'ConsoleAccounts' => [
                    'dev' => '34c6fceca75e456f25e7e99531e2425c6c1de443'// = sha1('dev')
                ],
                // Password hash algorithm (password must be hashed) values('md5', 'sha256' ...)
                'ConsoleHashAlgorithm' => 'sha1',
                // Home directory (multi-user mode supported) values ( var || array )
                // '' || '/tmp' || ['user1' => '/home/user1', 'user2' => '/home/user2']
                'ConsoleHomeDirectory' => DIR,
                // terminal.js full URI
                'ConsoleTerminalJs' => '/assets/js/jquery.terminal.min.js',
                // terminal.css full URI
                'ConsoleTerminalCss' => '/assets/css/jquery.terminal.min.css',
                'ProfilerPanel' => [
                    // Memory usage 'primaryValue' set as Profiler::enable() or Profiler::enable(1)
//                    'primaryValue' =>                   'effective',    // or 'absolute'
                    'show' => [
                        'memoryUsageChart' => 1, // or false
                        'shortProfiles' => true, // or false
                        'timeLines' => true // or false
                    ]
                ]
            ]
        ],
    ],
];

