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

class Banners extends \Controller\RESTController
{
    protected $table     = 'banners';
    protected $idxField  = 'bannerId';
    protected $template  = 'Admin\Banners.twig';

    protected        $columns   = ['clientId', 'type', 'title', 'start', 'stop'];
    protected static $actions   = ['create', 'update', 'delete'];

    public function dtServerProcessing(Request $request, Response $response, Array $args)
    {
        $u_columns = 'U.'.implode(', U.', array_keys($this->getTableColumns('bannersClients', ['clientId'])));

        $table = "(
            SELECT T.*, ".$u_columns."
            FROM ".$this->table." T
            INNER JOIN bannersClients U ON T.clientId = U.clientId
            ORDER BY T.".$this->idxField." ASC
        ) temp";

        $dtColumns = $this->getDtColumns(array($this->table, $this->table.'_lang', 'users'));

        $data = \Helpers\dataTableSSP::simple($request->getQueryParams(), $this->db, $table, $this->idxField, $dtColumns);

        return $response->withJson($data, 200);
    }

    protected function extraFormData()
    {
        parent::extraFormData();

        $stmt = $this->db->prepare("SELECT * FROM bannersClients");
        $stmt->execute();
        $this->data['bannersClients'] = $stmt->fetchAll();

        $this->data['types'] = array(
            'head_banner' => 'Header banner',
            'side_banner' => 'Sidebar banner',
            'page_banner' => 'Page banner'
        );
    }
}