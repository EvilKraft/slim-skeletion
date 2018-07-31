<?php
/**
 * Created by PhpStorm.
 * User: Kraft
 * Date: 04.06.2018
 * Time: 20:01
 */

namespace Controller;

use \Psr\Container\ContainerInterface;
use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

class Image
{
    protected $container;

    public function __construct(ContainerInterface $container) {
        $this->container = $container;
    }

    public function __invoke(Request $request, Response $response, $args) {
        // your code
        // to access items in the container... $this->container->get('');

        $server = self::initServer();

        $image_name = $request->getAttribute('image_name');

        if(empty($image_name)){
            $image_name = 'none';
        }gi

        if(!$server->sourceFileExists($image_name)){
            $image_name = '../resources/img/default-placeholder.png';
        }

        $mimeType = $server->getSource()->getMimetype($server->getSourcePath($image_name));
        if(!in_array($mimeType, ['image/gif', 'image/jpeg', 'image/png'])){
            $image_name = '../resources/img/default-placeholder.png';
        }

        return $server->getImageResponse($image_name, $request->getQueryParams());
    }

    public static function initServer(){
        return \League\Glide\ServerFactory::create([
            'source' => PUBLIC_DIR,
            'cache'  => CACHE_DIR,
            'source_path_prefix' => 'uploads',
            'cache_path_prefix'  => 'thumbnails',
            'response' => new \League\Glide\Responses\SlimResponseFactory(),

            'max_image_size' => 2000*2000,

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
    }
}