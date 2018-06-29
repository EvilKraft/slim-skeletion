<?php
/**
 * Created by PhpStorm.
 * Author: Konstantin Kaluzhnikov k.kaluzhnikov@gmail.com
 * Date: 22.08.2017
 */

namespace Controller;

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

class i18n extends BaseController
{
    public function getResource(Request $request, Response $response, Array $args) {
        if($args['lang'] == 'dev'){
            $newResponse = $response->withStatus(200)
                                    ->withHeader('Content-Type', 'application/json;charset=utf-8');
            $newResponse->getBody()->write(@file_get_contents($this->settings['i18n']['path'].'dev.json'));
            return $newResponse;
        }

        return $response->withJson($this->i18n->getCatalogue($args['lang'])->all('messages'), 200, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_NUMERIC_CHECK);
    }

    public function addMissingKey(Request $request, Response $response, Array $args) {
        foreach ($request->getParsedBody() as $key => $value){
            if($key == '_t'){continue;}

            $this->trans($value);
        }
        return $response->withJson('', 200);
    }

}