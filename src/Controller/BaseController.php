<?php
/**
 * Created by PhpStorm.
 * Author: Konstantin Kaluzhnikov k.kaluzhnikov@gmail.com
 * Date: 22.08.2017
 */

namespace Controller;

use \Psr\Container\ContainerInterface;
use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

abstract class BaseController
{
    /**
     * @var array Settings.
     */
    protected $settings;

    /**
     * @var \Slim\Interfaces\RouterInterface.
     */
    protected $router;

    /**
     * @var \Slim\Views\Twig Renderer.
     */
    protected $renderer;

    /**
     * @var \Symfony\Component\Translation\LoggingTranslator Translator.
     */
    protected $i18n;

    /**
     * @var \Doctrine\DBAL\Connection DataBase.
     */
    protected $db;

    /**
     * @var \Slim\Flash\Messages Flash messafes.
     */
    protected $flash;

    /**
     * @var \Swift_Mailer Swift Mailer.
     */
    protected $mailer;

    /**
     * @var string Language.
     */
    protected $lang;

    //Constructor
    public function __construct(ContainerInterface $ci) {
        $this->settings   = $ci->get('settings');
        $this->router     = $ci->get('router');
        $this->renderer   = $ci->get('renderer');
        $this->i18n       = $ci->get('i18n');
        $this->db         = $ci->get('db');
        $this->flash      = $ci->get('flash');
        $this->mailer     = $ci->get('mailer');

        $this->lang       = $ci->lang;
    }

    public function trans($id, array $parameters = array(), $domain = null, $locale = null){
        return $this->i18n->trans($id, $parameters, $domain, $locale);
    }

    protected function render(Response $response, $template, Array $data = []){
        return $this->renderer->render($response, $template, $data);
    }

    public static function getNamespace() {
        return implode('\\', array_slice(explode('\\', get_called_class()), 0, -1));
    }

    public static function getBaseClassName() {
        return basename(str_replace('\\', '/', get_called_class()));
    }
}