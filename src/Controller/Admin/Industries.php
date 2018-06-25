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

class Industries extends \Controller\RESTController
{
    protected $table     = 'industries';
    protected $idxField  = 'industryId';
    protected $template  = 'Admin\Industries.twig';

    protected        $columns   = ['title', 'onMain'];
    protected static $actions   = ['create', 'update', 'delete'];

    protected $idxFieldLang = 'langId';


    public function dtServerProcessing(Request $request, Response $response, Array $args)
    {
        $table = $this->table;
        if(!empty($this->idxFieldLang)){
            $l_columns = 'L.'.implode(', L.', array_keys($this->getTableColumns($this->table.'_lang', [$this->idxField, $this->idxFieldLang])));

            $table = "(
                SELECT T.*, ".$l_columns."
                FROM ".$this->table." T
                INNER JOIN ".$this->table."_lang L ON L.".$this->idxField." = T.".$this->idxField." AND L.lang = '".$this->lang."'
            ) temp";
        }

        $dtColumns = $this->getDtColumns();

        $this->setFormatter($dtColumns, 'onMain', function( $d, $row ) {
            switch ($d){
                case 1  : $class = 'fa-eye text-light-blue';  $text = 'Show'; break;
                case 0  : $class = 'fa-eye-slash text-muted'; $text = 'Hide'; break;
            }

            return '<div class="text-center"><i class="fa '.$class.' fa-lg" title="'.$this->trans($text).'"></i></div>';
        });

        $data = \Helpers\dataTableSSP::simple($request->getQueryParams(), $this->db, $table, $this->idxField, $dtColumns);

        return $response->withJson($data, 200);
    }
}