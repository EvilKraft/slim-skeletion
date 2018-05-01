<?php
/**
 * Created by PhpStorm.
 * Author: Konstantin Kaluzhnikov k.kaluzhnikov@gmail.com
 * Date: 22.08.2017
 */

namespace Controller\Admin;

use Controller\RESTController;
use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;
use Symfony\Component\Config\Definition\Exception\Exception;

class BillingOptions extends \Controller\RESTController
{
    protected $table       = 'billingOptions';
    protected $idxField    = 'optionId';
    protected $template    = 'Admin\BillingOptions.twig';

    protected $columns     = ['groupId', 'fullAccessTrial', 'periodicPayment', 'aperiodicPayment'];
    protected $actions     = ['update'];

    public static function registerRoutes($app){
        $class  = static::class;
        $prefix = self::routePrefix();

        $app->get('',                      $class.':index')->setName($prefix);
        $app->map(['GET', 'POST'], '/new', $class.':create')->setName($prefix.'_create');

        $app->group('/{id:[0-9]+}', function () use ($app, $class, $prefix) {
            $app->get('',    $class.':get')->setName($prefix.'_get');
            $app->put('',    $class.':update')->setName($prefix.'_update');
        });

        $app->get('/getTable',    $class.':dtServerProcessing')->setName($prefix.'_getTable');
    }

    public function dtServerProcessing(Request $request, Response $response, Array $args)
    {
        $table = "(
            SELECT 
                BO.optionId, UG.name AS groupId, BO.fullAccessTrial, BO.periodicPayment, BO.aperiodicPayment
            FROM ".$this->table." BO
            INNER JOIN userGroups UG ON UG.userGroupId = BO.groupId
        ) temp";

        $data = \Helpers\dataTableSSP::simple($request->getQueryParams(), $this->db, $table, $this->idxField, $this->getDtColumns());

        return $response->withJson($data, 200);
    }

    protected function extraFormData(){
        $stmt = $this->db->prepare("SELECT * FROM userGroups WHERE userGroupId != 1");
        $stmt->execute();
        $this->data['groups'] = $stmt->fetchAll();
    }
}