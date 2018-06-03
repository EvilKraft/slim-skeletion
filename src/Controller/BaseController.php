<?php
/**
 * Created by PhpStorm.
 * Author: Konstantin Kaluzhnikov k.kaluzhnikov@gmail.com
 * Date: 22.08.2017
 */

namespace Controller;

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

abstract class BaseController
{
    protected $app;

    protected $settings;
    protected $router;
    protected $renderer;
    protected $i18n;
    protected $db;
    protected $flash;
    protected $mailer;

    protected $lang;

    //Constructor
    public function __construct(\Slim\Container $app) {
    //    $this->app = $app;

        $this->settings   = $app->settings;
        $this->router     = $app->router;
        $this->renderer   = $app->renderer;
        $this->i18n       = $app->i18n;
        $this->db         = $app->db;
        $this->flash      = $app->flash;
        $this->mailer     = $app->mailer;

        $this->lang       = $app->lang;
    }

    public function trans($id, array $parameters = array(), $domain = null, $locale = null){
        return $this->i18n->trans($id, $parameters, $domain, $locale);
    }

    protected function render(Response $response, $template, Array $data = null){
        return $this->renderer->render($response, $template, $data);
    }

    public static function getNamespace() {
        return implode('\\', array_slice(explode('\\', get_called_class()), 0, -1));
    }

    public static function getBaseClassName() {
        return basename(str_replace('\\', '/', get_called_class()));
    }
}