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
abstract class RESTController extends BaseController implements RESTInterface
{
    /**
     * @var string Table name.
     */
    protected $table            = null;

    /**
     * @var integer Identity column name in the table. This column should be primary key.
     */
    protected $idxField         = null;

    /**
     * @var string Form template name.
     */
    protected $template         = null;

    /**
     * @var string Table template name.
     */
    protected $table_template   = 'table.twig';

    /**
     * @var array Columns to display in table.
     */
    protected        $columns     = [];

    /**
     * @var array Actions.
     */
    protected static $actions     = ['create', 'update', 'delete', 'move'];

    /**
     * @var array Filters.
     */
    protected        $col_filters = [];

    /**
     * @var integer Identity column name in the lang table. This column should be primary key in lang table.
     */
    protected $idxFieldLang = null;

    /**
     * @var array Associative array of template variables.
     */
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

        $this->renderer->getEnvironment()->addGlobal('indexRoute', self::routePrefix());
    }

    public static function registerRoutes($app){
        $class  = static::class;
        $prefix = self::routePrefix();

        $app->get('',          $class.':index')->setName($prefix);
        $app->get('/getTable', $class.':dtServerProcessing')->setName($prefix.'_getTable');

        if(in_array('create', $class::$actions)){
            $app->map(['GET', 'POST'], '/new', $class.':create')->setName($prefix.'_create');
        }

        $app->group('/{id:[0-9]+}', function () use ($app, $class, $prefix) {
            $app->get('',    $class.':get')->setName($prefix.'_get');

            if(in_array('update', $class::$actions)){
                $app->put('', $class.':update')->setName($prefix.'_update');
            }

            if(in_array('delete', $class::$actions)){
                $app->delete('', $class.':delete')->setName($prefix.'_delete');
            }

            if(in_array('addChild', $class::$actions)){
                $app->map(['GET', 'POST'], '/new', $class.':create')->setName($prefix.'_addChild');
            }

            if(in_array('move', $class::$actions)){
                $app->get('/move', $class.':move')->setName($prefix.'_move');
            }
        });

        if(in_array('delete', $class::$actions)){
            $app->delete('/{ids: .+}', $class.':deleteSelected')->setName($prefix.'_deleteSelected');
        }
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
        $this->data['item']    = $item;
        $this->data['actions'] = static::$actions;

        $this->extraFormData();

        return $this->renderPage($response, $this->template, 'Edit');
    }

    public function create(Request $request, Response $response, Array $args)
    {
        if($request->isPost()){
            return $this->doCreate($request, $response);
        }

        $this->data['actions'] = static::$actions;
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
            $data['errors'][] = array('message' => $this->trans('Item %item_id% not found', ['%item_id%' => $args['id']]));
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
            $this->flash->addMessage('error', json_encode($flashMsg, JSON_PRETTY_PRINT));
        }

        return $response->withStatus(302)->withHeader('Location', $this->getListUrl());
    }

    protected function doList(Request $request, Response $response)
    {
        $this->data['actions']    = array_values(array_intersect(static::$actions, ['create', 'delete']));
        $this->data['dtColumns']  = $this->dtColumns();
        $this->data['dtLanguage'] = $this->dtLanguage();

        return $this->renderPage($response, $this->table_template);
    }

    protected function doCreate(Request $request, Response $response)
    {
        try {
            $this->db->beginTransaction();

            $vars      = $this->getPostedVars($request);
            $colNames  = implode(', ', array_keys($vars));
            $questions = implode(',', array_fill(0, count($vars), '?'));
            
            $stmt = $this->db->prepare("INSERT INTO ".$this->table." (".$colNames.") VALUES (".$questions.")");
            $stmt->execute(array_values($vars));

            $lastId = $this->db->lastInsertId();

            if(!empty($this->idxFieldLang)){
                $tableColumns = $this->getTableColumns($this->table.'_lang');

                $vars_lang = array();
                foreach ($this->settings['i18n']['langs'] as $lang){
                    $vars = array_intersect_key($request->getParsedBody()[$lang], $tableColumns);
                    $vars_lang[$lang] = array_merge_recursive( [$this->idxField => $lastId, 'lang' => $lang ], $vars);
                }
                $colNames  = implode(', ', array_keys(reset($vars_lang)));
                $questions = implode(',', array_fill(0, count(reset($vars_lang)), '?'));

                $stmt = $this->db->prepare("INSERT INTO ".$this->table."_lang (".$colNames.") VALUES (".$questions.")");

                foreach ($vars_lang as $lang => $vars){
                    $stmt->execute(array_values($vars));
                }
            }

            $this->db->commit();
            $this->flash->addMessage('success', $this->trans('New item added'));
        } catch (\Exception $e) {
            $this->db->rollBack();

            $flashMsg = ($this->settings['displayErrorDetails']) ? $e->getMessage() : $this->trans('New item not added');
            $this->flash->addMessage('error', json_encode($flashMsg, JSON_PRETTY_PRINT));
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

        try {
            $this->db->beginTransaction();

            $vars     = $this->getPostedVars($request);
            if(count($vars) > 0){
                $colNames = implode(', ', array_map(function($n) {return($n.'=?');}, array_keys($vars)));

                $stmt = $this->db->prepare("UPDATE ".$this->table." SET ".$colNames." WHERE ".$this->idxField." = ?");
                $stmt->execute(array_merge_recursive(array_values($vars), [$args['id']]));
            }

            if(!empty($this->idxFieldLang)){
                $tableColumns = $this->getTableColumns($this->table.'_lang');

                $vars_lang = array();
                foreach ($this->settings['i18n']['langs'] as $lang){
                    $vars_lang[$lang] = array_intersect_key($request->getParsedBody()[$lang], $tableColumns);
                }
                $colNames  = implode(', ', array_map(function($n) {return($n.'=?');}, array_keys(reset($vars_lang))));

                $stmt = $this->db->prepare("UPDATE ".$this->table."_lang SET ".$colNames." WHERE ".$this->idxFieldLang." = ?");

                foreach ($vars_lang as $lang => $vars){
                    $stmt->execute(array_merge(array_values($vars), [$request->getParsedBody()[$lang][$this->idxFieldLang]]));
                }
            }

            $this->db->commit();
            $this->flash->addMessage('success', $this->trans('Item %item_id% updated', ['%item_id%' => $args['id']]));
        } catch (\Exception $e) {
            $this->db->rollBack();

            $flashMsg = ($this->settings['displayErrorDetails']) ? $e->getMessage() : $this->trans('Item %item_id% not updated', ['%item_id%' => $args['id']]);
            $this->flash->addMessage('error', json_encode($flashMsg, JSON_PRETTY_PRINT));
        }

        return $response->withStatus(302)->withHeader('Location', $this->getListUrl());
    }

    protected function renderPage(Response $response, $template, $pageTitle = null){
        $this->data['page']['title'] = $this->trans('REST.'.self::getBaseClassName().'.page.title');
        if(!is_null($pageTitle)){
            $this->data['page']['title'] .= ' / '.$this->trans($pageTitle);
        }

        return $this->render($response, $template, $this->data);
    }

    protected function getListUrl(){
        return $this->router->pathFor(self::routePrefix(), ['lang' => $this->lang]);
    }

    protected function getPostedVars(Request $request, $table = null, Array $ids = null){
        return array_intersect_key($request->getParsedBody(), $this->getTableColumns($table, $ids));
    }

    protected function getTableColumns($table = null, Array $ids = null){
        $columns = array();
        $sm      = $this->db->getSchemaManager();

        $table = ($table) ?? $this->table;
        $ids =   ($ids)   ?? array($this->idxField, $this->idxFieldLang);

        foreach ($sm->listTableColumns($table) as $column) {
            $colName = $column->getName();

            if(!in_array($colName, $ids)){
                $columns[$colName] = [
                    'COLUMN_NAME' => $colName,
                    'DATA_TYPE'   => $column->getType(),
                ];
            }
        }

        return $columns;
    }

    // Override to add additional form. Ex. $this->data['zzz'] = 'zzz';
    protected function extraFormData(){

        // Add langs data to form
        if(!empty($this->idxFieldLang) && isset($this->data['item'])){
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
            $l_columns = 'L.'.implode(', L.', array_keys($this->getTableColumns($this->table.'_lang', [$this->idxField, $this->idxFieldLang])));

            $table = "(
                SELECT T.*, ".$l_columns."
                FROM ".$this->table." T
                INNER JOIN ".$this->table."_lang L ON L.".$this->idxField." = T.".$this->idxField." AND L.lang = '".$this->lang."'
            ) temp";
        }

        $data = \Helpers\dataTableSSP::simple($request->getQueryParams(), $this->db, $table, $this->idxField, $this->getDtColumns());

        return $response->withJson($data, 200);
    }

    // Generate columns for DataTables Server Side Processing class
    protected function getDtColumns(Array $table_names = null){
        $table_names = $table_names ?? array($this->table, $this->table.'_lang');

        $tableColumns = array();
        foreach ($table_names as $table_name){
            $tableColumns = array_merge($tableColumns, $this->getTableColumns($table_name));
        }

     //   echo '<pre>'.print_r($tableColumns, true).'</pre>';
    //    exit;

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
                        return str_limit($d, 40);
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

        $tableColumns = array_merge($this->getTableColumns(), $this->getTableColumns($this->table.'_lang'));


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

        $actionsFunc = '';
        if(!empty(static::$actions)){

            $actionsStr = implode(',', array_map(function($value) { return '"'.$value.'"'; }, static::$actions));
            $actionsFunc = '$.fn.dataTable.render.dataTableActionBtns(['.$actionsStr.'])';

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
        $out = str_replace('"#!!actionBtns!!#"', $actionsFunc, $out);

        return $out;
    }

    // Datatable language property value
    protected function dtLanguage(){
        $langNames = array(
            'az' => 'Azerbaijan',
            'en' => 'English',
            'ru' => 'Russian',
        );
        $json = file_get_contents(PUBLIC_DIR.'libs/DataTables/Plugins-1.10.16/i18n/'.$langNames[$this->lang].'.lang');

        $json = preg_replace('!/\*.*?\*/!s', '', $json); // remove comments
        $json = preg_replace('/\n\s*\n/', "\n", $json); // remove empty lines that can create errors

        $array = json_decode($json, true);

        $myTrans = [
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
                'addChild'      => $this->trans('Add child'),
                'moveUp'        => $this->trans('Move up'),
                'moveDown'      => $this->trans('Move down'),

                'rowDeleteConfirm'  => $this->trans('Are you sure you wont to delete this item?'),
                'rowsDeleteConfirm' => $this->trans('Are you sure you wont to delete selected items?'),
                'itemDeleted'       => $this->trans('Item deleted'),
                'itemsDeleted'      => $this->trans('Items deleted'),
            ]
        ];

        $array = array_merge_recursive($array, $myTrans);


        return json_encode($array);
    }
}