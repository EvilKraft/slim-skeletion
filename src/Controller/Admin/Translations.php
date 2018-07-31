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
use \Symfony\Component\Translation\Dumper\PhpFileDumper;
use \Symfony\Component\Translation\Writer\TranslationWriter;


class Translations extends RESTController
{
    protected $table            = 'none';  //table name
    protected $idxField         = 'none';  // Primary key

    protected        $columns   = ['domain', 'key', 'value'];
    protected static $actions   = ['update'];

    public static function registerRoutes($app){
        $class  = static::class;
        $prefix = self::routePrefix();

        $app->get('',          $class.':index')->setName($prefix);
        $app->get('/getTable', $class.':dtServerProcessing')->setName($prefix.'_getTable');

        if(in_array('create', $class::$actions)){
            $app->map(['GET', 'POST'], '/new', $class.':create')->setName($prefix.'_create');
        }

        $app->group('/{id}', function () use ($app, $class, $prefix) {
            $app->get('',    $class.':get')->setName($prefix.'_get');

            if(in_array('update', $class::$actions)){
                $app->put('', $class.':update')->setName($prefix.'_update');
            }

            if(in_array('delete', $class::$actions)){
                $app->delete('', $class.':delete')->setName($prefix.'_delete');
            }

            if(in_array('move', $class::$actions)){
                $app->get('/move', $class.':move')->setName($prefix.'_move');
            }
        });

        if(in_array('delete', $class::$actions)){
            $app->delete('/{ids: .+}', $class.':deleteSelected')->setName($prefix.'_deleteSelected');
        }
    }

    public function get(Request $request, Response $response, Array $args)
    {
        list($domain, $key) = explode("_", $args['id']);
        $key = hex2bin($key);

        $this->data['item']    = ['domain' => $domain, 'key' => $key,];
        $this->data['actions'] = static::$actions;

        foreach ($this->settings['i18n']['langs'] as $lang){
            $value = $this->i18n->getCatalogue($lang)->get($key, $domain);
            $this->data['item_langs'][$lang] = ['value' => $value];
        }

        $this->extraFormData();

        return $this->renderPage($response, $this->template, 'Edit');
    }

    protected function doCreate(Request $request, Response $response)
    {
        $postedVars = $request->getParsedBody();

        $writer = new TranslationWriter();
        $writer->addDumper('php', new PhpFileDumper());

        try {
            foreach ($this->settings['i18n']['langs'] as $lang){
                $this->i18n->getCatalogue($lang)->set($postedVars['key'], $postedVars[$lang]['value'], $postedVars['domain']);
                $writer->write($this->i18n->getCatalogue($lang), 'php', array('path' => $this->settings['i18n']['path']));
            }

            $this->flash->addMessage('success', $this->trans('New item added'));
        } catch (\Exception $e) {
            $flashMsg = ($this->settings['displayErrorDetails']) ? $e->getMessage() : $this->trans('New item not added');
            $this->flash->addMessage('error', json_encode($flashMsg, JSON_PRETTY_PRINT));
        }

        return $response->withStatus(302)->withHeader('Location', $this->getListUrl());
    }

    protected function doUpdate(Request $request, Response $response, Array $args)
    {
        list($domain, $key) = explode("_", $args['id']);
        $key = hex2bin($key);

        $postedVars = $request->getParsedBody();

        $writer = new TranslationWriter();
        $writer->addDumper('php', new PhpFileDumper());

        try {
            foreach ($this->settings['i18n']['langs'] as $lang){
                $this->i18n->getCatalogue($lang)->set($key, $postedVars[$lang]['value'], $domain);

                $writer->write($this->i18n->getCatalogue($lang), 'php', array('path' => $this->settings['i18n']['path']));
            }

            $this->flash->addMessage('success', $this->trans('Item %item_id% updated', ['%item_id%' => $args['id']]));
        } catch (\Exception $e) {
            $flashMsg = ($this->settings['displayErrorDetails']) ? $e->getMessage() : $this->trans('Item %item_id% not updated', ['%item_id%' => $args['id']]);
            $this->flash->addMessage('error', json_encode($flashMsg, JSON_PRETTY_PRINT));
        }

        return $response->withStatus(302)->withHeader('Location', $this->getListUrl());
    }

    public function delete(Request $request, Response $response, Array $args)
    {
        $data = array('status' => 0, 'data' => ['id' => $args['id']], 'errors' => []);


      //  $data['status'] = 1;
      //  return $response->withJson($data, 200);


        list($domain, $key) = explode("_", $args['id']);
        $key = hex2bin($key);

        if(!$this->i18n->getCatalogue()->has($key, $domain)){
            $data['errors'][] = array('message' => $this->trans('Item %item_id% not found', ['%item_id%' => $args['id']]));
            return $response->withJson($data, 200);
        }

        $writer = new TranslationWriter();
        $writer->addDumper('php', new PhpFileDumper());

        try {
            foreach ($this->settings['i18n']['langs'] as $lang){
                $items = $this->i18n->getCatalogue($lang)->all($domain);
                unset($items[$key]);
                $this->i18n->getCatalogue($lang)->replace($items, $domain);
                $writer->write($this->i18n->getCatalogue($lang), 'php', array('path' => $this->settings['i18n']['path']));
            }

            $data['status'] = 1;
        } catch (\Exception $e) {
            $data['errors'][] = array('message' => ($this->settings['displayErrorDetails']) ? $e->getMessage() : $this->trans('Record not deleted'));
        }

        return $response->withJson($data, 200);
    }

    public function deleteSelected(Request $request, Response $response, Array $args)
    {
        $args_ids = explode(',', $args['ids']);

        $ids = array();
        foreach ($ids as $id) {
            list($domain, $key) = explode("_", $args['id']);
            $key = hex2bin($key);

            $ids[$domain][] = $key;
        }


        $data = array('status' => 0, 'data' => ['ids' => $ids], 'errors' => []);

        $writer = new TranslationWriter();
        $writer->addDumper('php', new PhpFileDumper());

        try {
            foreach ($this->settings['i18n']['langs'] as $lang){

                foreach ($ids as $domain => $keys){
                    $items = $this->i18n->getCatalogue($lang)->all($domain);

                    foreach ($keys as $key){
                        unset($items[$key]);
                    }

                    $this->i18n->getCatalogue($lang)->replace($items, $domain);
                }

                $writer->write($this->i18n->getCatalogue($lang), 'php', array('path' => $this->settings['i18n']['path']));
            }

            $data['status'] = 1;
        } catch (\Exception $e) {
            $data['errors'][] = array('message' => $this->trans('Records not deleted'));
        }

        return $response->withJson($data, 200);
    }

    protected function extraFormData(){
        $this->data['domains'] = $this->i18n->getCatalogue($this->lang)->getDomains();
    }

    public function dtServerProcessing(Request $request, Response $response, Array $args)
    {
        $dev       = include $this->settings['i18n']['path'].DS.'dev.php';
        $catalogue = array_merge_recursive($dev, $this->i18n->getCatalogue()->all());

        $search = $request->getQueryParam('search');
        $pattern = '/'.preg_quote($search['value'], '/').'/i';

        $data = array();
        foreach ($catalogue as $domain => $items){
            foreach ($items as $key => $value){
                if($pattern != '//'){
                    if(!(preg_match($pattern, $key) || preg_match($pattern, $value))){
                        continue;
                    }
                }

                $data[] = array(
                    'DT_RowId' => 'row_'.$domain.'_'.bin2hex($key),
                    'domain'   => $domain,
                    'key'      => $key,
                    'value'    => str_limit($value, 40),
                );
            }
        }

        $data = array(
            'draw'            => $request->getQueryParam('draw', 0),
            'recordsTotal'    => count($data),
            'recordsFiltered' => count($data),
            'data'            => $data,
        );

        return $response->withJson($data, 200);
    }

    // Datatable columns property value
    protected function dtColumns(){
        $out = array();
        $catalogue = $this->i18n->getCatalogue($this->lang);

        foreach ($this->columns as $column){
            $trans_id  = 'REST.'.self::getBaseClassName().'.fields.'.$column;
            $title     = ($catalogue->defines($trans_id)) ? $this->trans($trans_id) : $column;
            $className = in_array($column, $this->col_filters) ? 'select-filter' : '';

            $out[] = array(
                'data'      => $column,
                'title'     => $title,
                'className' => $className
            );
        }

        $func = '';
        if(!empty(static::$actions)){
            $actionsStr = implode(',', array_map(function($value) { return '"'.$value.'"'; }, static::$actions));
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
}