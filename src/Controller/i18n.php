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
        return $response->withJson($this->i18n->getCatalogue($args['lang'])->all('messages'), 200, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_NUMERIC_CHECK);
    }

    public function addMissingKey(Request $request, Response $response, Array $args) {
        $resource = $this->settings['i18n']['path'].$args['lang'].'.json';

        $messages = array('_t' => '');
        if ($data = @file_get_contents($resource)) {
            $messages = json_decode($data, true);

            if (0 < $errorCode = json_last_error()) {
                throw new \Exception(sprintf('Error parsing JSON - %s', $errorCode));
            }
        }

        foreach ($request->getParsedBody() as $key => $value){
            if($key == '_t'){
                $messages[$key] = $value;
            }else{
                $messages = array_add($messages, $value, $value);
            }
        }

        $data = json_encode($messages, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_NUMERIC_CHECK | JSON_PRETTY_PRINT);
        file_put_contents($resource, $data, LOCK_EX);

        return $response->withJson('', 200);
    }

}