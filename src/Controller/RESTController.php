<?php
/**
 * Created by PhpStorm.
 * Author: Konstantin Kaluzhnikov k.kaluzhnikov@gmail.com
 * Date: 22.08.2017
 */

namespace Controller;

use \Interfaces\RESTInterface;
use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;


//abstract class RESTController extends BaseController implements RESTInterface
class RESTController extends BaseController implements RESTInterface
{
    protected $table       = null;  //table name
    protected $idxField    = null;  // Primary key
    protected $template    = null; //'Admin\Users.twig';

    protected $columns     = [];
    protected $actions     = ['create', 'update', 'delete', 'move'];
    protected $col_filters = [];

    // langs properties
    protected $idxFieldLang = null;

    protected $data = array();

    public function __construct(\Slim\Container $app)
    {
        parent::__construct($app);

        if(empty($this->table)){
            throw new \Exception('Table was not set');
        }

        if(empty($this->idxField)){
            $this->idxField = $this->db->getSchemaManager()->listTableDetails($this->table)->getPrimaryKeyColumns()[0];
        }

        if(empty($this->template)){
          $this->template = implode('/', array_slice(explode('\\', get_called_class()), 1)).'.twig';
        }
    }

    public static function registerRoutes($app){
        $class  = static::class;
        $prefix = self::routePrefix();

        $app->get('',                      $class.':index')->setName($prefix);
        $app->map(['GET', 'POST'], '/new', $class.':create')->setName($prefix.'_create');

        $app->group('/{id:[0-9]+}', function () use ($app, $class, $prefix) {
            $app->get('',    $class.':get')->setName($prefix.'_get');
            $app->put('',    $class.':update')->setName($prefix.'_update');
            $app->delete('', $class.':delete')->setName($prefix.'_delete');

            $app->get('/move',   $class.':move')->setName($prefix.'_move');
        });

        $app->delete('/{ids: .+}', $class.':deleteSelected')->setName($prefix.'_deleteSelected');

        $app->get('/getTable',    $class.':dtServerProcessing')->setName($prefix.'_getTable');
    }

    public static function routePrefix(){
        return strtolower(implode('_', array_slice(explode('\\', get_called_class()), 1)));
    }

    public function index(Request $request, Response $response, Array $args)
    {
        return $this->doList($request, $response);
    }

    public function get(Request $request, Response $response, Array $args)
    {
        $stmt = $this->db->query("SELECT * FROM ".$this->table." WHERE ".$this->idxField."=".(int) $args['id']);
        if (!$item = $stmt->fetch()) {
            $this->flash->addMessage('error', $this->trans('Item %item_id% not found', ['%item_id%' => $args['id']]));
            return $response->withStatus(302)->withHeader('Location', $this->getListUrl());
        }
        $this->data['item'] = $item;

        $this->extraFormData();

        return $this->renderPage($response, $this->template, 'Edit');
    }

    public function create(Request $request, Response $response, Array $args)
    {
        if($request->isPost()){
            return $this->doCreate($request, $response);
        }

        $this->extraFormData();

        return $this->renderPage($response, $this->template, 'New');
    }

    public function update(Request $request, Response $response, Array $args)
    {
        return $this->doUpdate($request, $response, $args);
    }

    public function delete(Request $request, Response $response, Array $args)
    {
        $data = array('status' => 0, 'data' => ['id' => $args['id']], 'errors' => []);

        $stmt = $this->db->query("SELECT * FROM ".$this->table." WHERE ".$this->idxField."=".(int) $args['id']);
        if (!$item = $stmt->fetch()) {
            $data['errors'][] = array('message' => $this->trans('Record not found'));
            return $response->withJson($data, 200);
        }

        try {
            $this->db->beginTransaction();
            
            $stmt = $this->db->prepare("DELETE FROM ".$this->table." WHERE ".$this->idxField." = ?");
            $stmt->execute(array($args['id']));

            $this->db->commit();
            $data['status'] = 1;
        } catch (\Exception $e) {
            $this->db->rollBack();
            $data['errors'][] = array('message' => ($this->settings['displayErrorDetails']) ? $e->getMessage() : $this->trans('Record not deleted'));
        }

        return $response->withJson($data, 200);
    }

    public function deleteSelected(Request $request, Response $response, Array $args)
    {
        $ids = explode(',', $args['ids']);

        // check if all params are numeric
        if(!ctype_digit(implode('', $ids)) || count(array_filter($ids)) != count($ids)){
            throw new \Slim\Exception\NotFoundException($request, $response);
        }

        $data = array('status' => 0, 'data' => ['ids' => $ids], 'errors' => []);

        $stmt = $this->db->query("SELECT COUNT(*) AS COUNT FROM ".$this->table." WHERE ".$this->idxField." IN (".$args['ids'].")");
        $row = $stmt->fetch();

        if($row['COUNT'] != count($ids)){
            $data['errors'][] = array('message' => $this->trans('At least one record not found!'));
            return $response->withJson($data, 200);
        }

        $questionsStr = implode(',', array_fill(0, count($ids), '?'));

        try {
            $this->db->beginTransaction();

            $stmt = $this->db->prepare("DELETE FROM ".$this->table." WHERE ".$this->idxField." IN (".$questionsStr.")");
            $stmt->execute($ids);

            $this->db->commit();
            $data['status'] = 1;
        } catch (\Exception $e) {
            $this->db->rollBack();
            $data['errors'][] = array('message' => $this->trans('Records not deleted'));
        }

        return $response->withJson($data, 200);
    }

    public function move(Request $request, Response $response, Array $args)
    {
        $stmt = $this->db->query("SELECT * FROM ".$this->table." WHERE ".$this->idxField."=".(int) $args['id']);
        if (!$item = $stmt->fetch()) {
            $data['errors'][] = array('message' => $this->trans('Record not found'));
            return $response->withJson($data, 200);
        }

        switch ($request->getParsedBody()['direction']){
            case 'up':   $operator = '<'; break;
            case 'down': $operator = '<'; break;
            default:
                $data['errors'][] = array('message' => $this->trans('Wrong direction'));
                return $response->withJson($data, 200);
        }

        $stmt = $this->db->prepare("SELECT * FROM ".$this->table." WHERE sort ".$operator." ? ORDER BY sort DESC LIMIT 1");
        $stmt->execute(array($item['sort']));
        if (!$targetItem = $stmt->fetch()) {
            $data['errors'][] = array('message' => $this->trans('Can not move the item'));
            return $response->withJson($data, 200);
        }

        try {
            $this->db->beginTransaction();

            $stmt = $this->db->prepare("UPDATE ".$this->table." SET sort=? WHERE id=?");

            $stmt->execute(array($item['sort'], $targetItem['id']));
            $stmt->execute(array($targetItem['sort'], $item['id']));

            $this->db->commit();
        } catch (\Exception $e) {
            $this->db->rollBack();

            $flashMsg = ($this->settings['displayErrorDetails']) ? $e->getMessage() : $this->trans('Can not move');
            $this->flash->addMessage('error', $flashMsg);
        }

        return $response->withStatus(302)->withHeader('Location', $this->getListUrl());
    }

    protected function doList(Request $request, Response $response)
    {
        $this->data['actions']    = array_values(array_intersect($this->actions, ['create', 'delete']));
        $this->data['dtColumns']  = $this->dtColumns();
        $this->data['dtLanguage'] = $this->dtLanguage();

        return $this->renderPage($response, 'table.twig');
    }

    protected function doCreate(Request $request, Response $response)
    {
        $vars = $this->getPostedVars($request);

        $colNames  = implode(',', array_keys($vars));
        $questions = '?'.str_repeat(',?', (count($vars)-1));

        try {
            $this->db->beginTransaction();
            
            $stmt = $this->db->prepare("INSERT INTO ".$this->table." (".$colNames.") VALUES (".$questions.")");
            $stmt->execute(array_values($vars));

            $this->db->commit();
            $this->flash->addMessage('success', $this->trans('New item added'));
        } catch (\Exception $e) {
            $this->db->rollBack();

            $flashMsg = ($this->settings['displayErrorDetails']) ? $e->getMessage() : $this->trans('New item not added');
            $this->flash->addMessage('error', $flashMsg);
        }

        return $response->withStatus(302)->withHeader('Location', $this->getListUrl());
    }

    protected function doUpdate(Request $request, Response $response, Array $args)
    {
        $stmt = $this->db->query("SELECT * FROM ".$this->table." WHERE ".$this->idxField." = ".(int) $args['id']);
        if (!$item = $stmt->fetch()) {
            $this->flash->addMessage('error', $this->trans('Item %item_id% not found', ['%item_id%' => $args['id']]));
            return $response->withStatus(302)->withHeader('Location', $this->getListUrl());
        }

        $vars = $this->getPostedVars($request);

        $sets = array();
        foreach($vars as $name => $val){
            $sets[] = $name.' = ?';
        }
        $colNames = implode(' , ', $sets);

        $vals = array_values($vars);
        $vals[] = $args['id'];

        try {
            $this->db->beginTransaction();
            
            $stmt = $this->db->prepare("UPDATE ".$this->table." SET ".$colNames." WHERE ".$this->idxField." = ?");
            $stmt->execute($vals);

            $this->db->commit();
            $this->flash->addMessage('success', $this->trans('Item %item_id% updated', ['%item_id%' => $args['id']]));
        } catch (\Exception $e) {
            $this->db->rollBack();

            $flashMsg = ($this->settings['displayErrorDetails']) ? $e->getMessage() : $this->trans('Item %item_id% not updated', ['%item_id%' => $args['id']]);
            $this->flash->addMessage('error', $flashMsg);
        }

        return $response->withStatus(302)->withHeader('Location', $this->getListUrl());
    }

    protected function renderPage(Response $response, $template, $pageTitle = null){
        $this->data['pageTitle'] = $this->trans('REST.'.self::getBaseClassName().'.pageTitle');
        if(!is_null($pageTitle)){
            $this->data['pageTitle'] .= ' / '.$this->trans($pageTitle);
        }

        return $this->renderer->render($response, $template, $this->data);
    }

    protected function getListUrl(){
        return $this->router->pathFor(self::routePrefix(), ['lang' => $this->lang]);
    }

    protected function getPostedVars(Request $request){
        return array_intersect_key($request->getParsedBody(), $this->getTableColumns());
    }

    protected function getTableColumns(){
        $columns = array();
        $sm      = $this->db->getSchemaManager();

        foreach ($sm->listTableColumns($this->table) as $column) {
            if($column->getName() != $this->idxField){
                $columns[$column->getName()] = [
                    'COLUMN_NAME' => $column->getName(),
                    'DATA_TYPE'   => $column->getType(),
                ];
            }
        }

        if(!empty($this->idxFieldLang)){
            foreach ($sm->listTableColumns($this->table.'_lang') as $column) {
                $colName = $column->getName();
               if($colName != $this->idxField && $colName != $this->idxFieldLang){
                    $columns[$colName] = [
                        'COLUMN_NAME' => $colName,
                        'DATA_TYPE'   => $column->getType(),
                    ];
                }
            }
        }

        return $columns;
    }

    // owerrade to add additional form. Ex. $this->data['zzz'] = 'zzz';
    protected function extraFormData(){

        // Add langs data to form
        if(!empty($this->idxFieldLang)){
            $this->data['langs'] = $this->settings['i18n']['langs'];

            $stmt = $this->db->prepare("SELECT * FROM ".$this->table."_lang WHERE ".$this->idxField." = ?");
            $stmt->execute(array($this->data['item'][$this->idxField]));
            while ($row = $stmt->fetch()){
                $this->data['item_langs'][$row['lang']] = $row;
            }
        }
    }

    public function dtServerProcessing(Request $request, Response $response, Array $args)
    {
        $table = $this->table;
        if(!empty($this->idxFieldLang)){
            $l_columns = '';
            $sm = $this->db->getSchemaManager();
            foreach ($sm->listTableColumns($this->table.'_lang') as $column) {
                $colName = $column->getName();
                if($colName != $this->idxField && $colName != $this->idxFieldLang){
                    $l_columns .= ', L.'.$colName;
                }
            }

            $table = "(
                SELECT T.*".$l_columns."
                FROM ".$this->table." T
                INNER JOIN ".$this->table."_lang L ON L.".$this->idxField." = T.".$this->idxField." AND L.lang = '".$this->lang."'
            ) temp";
        }

        $data = \Helpers\dataTableSSP::simple($request->getQueryParams(), $this->db, $table, $this->idxField, $this->getDtColumns());

        return $response->withJson($data, 200);
    }

    // Generate columns for DataTables Server Side Processing class
    protected function getDtColumns(){
        $tableColumns = $this->getTableColumns();

        $dtColumns[] = array(
            'db' => $this->idxField,
            'dt' => 'DT_RowId',

            'formatter' => function( $d, $row ) {
                // Technically a DOM id cannot start with an integer, so we prefix
                // a string. This can also be useful if you have multiple tables
                // to ensure that the id is unique with a different prefix
                return 'row_'.$d;
            }
        );

        foreach ($tableColumns as $column){

            $dtcolumn =  array(
                'db'    => $column['COLUMN_NAME'],
                'dt'    => $column['COLUMN_NAME'],
            );

            switch ($column['DATA_TYPE']){
                case 'timestamp' :
                    $dtcolumn['formatter'] = function( $d, $row ) {
                        return date( 'd M Y H:i:s', strtotime($d));
                    };
                    break;
                case 'date' :
                    $dtcolumn['formatter'] = function( $d, $row ) {
                        return date( 'd M Y', strtotime($d));
                    };
                    break;

                case 'text' :
                    $dtcolumn['formatter'] = function( $d, $row ) {
                        if(strlen($d) > 40){
                            return substr($d, 0, 38).'...';
                        }
                        return $d;
                    };
                    break;

                case 'MONEYxxxx' :
                    $dtcolumn['formatter'] = function( $d, $row ) {
                        return '$'.number_format($d);
                    };
                    break;
            }

            $dtColumns[] = $dtcolumn;
        }

        return $dtColumns;
    }

    protected function setFormatter(array &$columns, $columnName, callable $formatter){
        for($i=0, $ien=count($columns); $i<$ien; $i++ ) {
            if($columns[$i]['db'] == $columnName){
                $columns[$i]['formatter'] = $formatter;
                break;
            }
        }
    }

    // Datatable columns property value
    protected function dtColumns(){
        $out = array();
        $catalogue = $this->i18n->getCatalogue($this->lang);

        $tableColumns = $this->getTableColumns();

        foreach ($this->columns as $column){
            $trans_id  = 'REST.'.self::getBaseClassName().'.fields.'.$column;
            $title     = ($catalogue->defines($trans_id)) ? $this->trans($trans_id) : $column;
            $className = in_array($column, $this->col_filters) ? 'select-filter' : '';

            $out[] = array(
                'data'      => $column,
                'title'     => $title,
                'className' => $className
                //         'width' => "10%",
                //          'searchable' => false,
                //         'orderable' => false,
            );

            unset($tableColumns[$column]);
        }

        foreach ($tableColumns as $column){
            $trans_id = 'REST.'.self::getBaseClassName().'.fields.'.$column['COLUMN_NAME'];
            $title    = ($catalogue->defines($trans_id)) ? $this->trans($trans_id) : $column['COLUMN_NAME'];
            $className = in_array($column['COLUMN_NAME'], $this->col_filters) ? 'select-filter' : '';

            $out[] = array(
                'data'      => $column['COLUMN_NAME'],
                'title'     => $title,
                'className' => $className,
                'visible'   => false,
                //         'width' => "10%",
                //          'searchable' => false,
                //         'orderable' => false,
            );
        }

        if(!empty($this->actions)){

            $actionsStr = implode(',',
                array_map(function($value) { return '"'.$value.'"'; }, $this->actions) // add double quotes to each element
            );
            $func = '$.fn.dataTable.render.dataTableActionBtns(['.$actionsStr.'])';

            $out[] = array(
                'data'       => null,
                'title'      => $this->trans('Actions'),
                'visible'    => true,
                'className'  => 'action_btns_container',
                'width'      => "1%",
                'searchable' => false,
                'orderable'  => false,
                'render'     => '#!!actionBtns!!#',
            );
        }

        $out = json_encode($out);
        $out = str_replace('"#!!actionBtns!!#"',$func, $out);

        return $out;
    }

    // Datatable language property value
    protected function dtLanguage(){
        return json_encode([
         //   'url' => '/libs/DataTables/Plugins-1.10.16/i18n/Russian.lang',

            'select' => [
                'rows' => [
                    '_' => $this->trans('You have selected %d rows'),
                    0   => '',
                    1   => $this->trans('Only 1 row selected')
                ]
            ],

            'buttons' => [
                'selectAll'     => $this->trans('Select All'),
                'selectNone'    => $this->trans('Deselect all'),
                'colvisRestore' => $this->trans('Restore columns'),

                'Export'        => $this->trans('Export'),
                'create'        => $this->trans('Add new item'),
                'edit'          => $this->trans('Edit item'),
                'delete'        => $this->trans('Delete item'),
                'deleteItems'   => $this->trans('Delete items'),
                'moveUp'        => $this->trans('Move up'),
                'moveDown'      => $this->trans('Move down'),
            ]
        ]);
    }
}