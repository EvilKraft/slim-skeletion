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
    protected $table = 'banners';
    protected $idxField = 'bannerId';
    protected $template = 'Admin\Banners.twig';

    protected $columns = ['name', 'type', 'title', 'start', 'stop'];
    protected static $actions = ['create', 'update', 'delete'];

    protected $bannersDir = UPLOAD_DIR.'banners'.DS;

    public function dtServerProcessing(Request $request, Response $response, Array $args)
    {
        $u_columns = 'U.' . implode(', U.', array_keys($this->getTableColumns('bannersClients', ['clientId', 'createdAt'])));

        $table = "(
            SELECT T.*, " . $u_columns . "
            FROM " . $this->table . " T
            INNER JOIN bannersClients U ON T.clientId = U.clientId
            ORDER BY T." . $this->idxField . " ASC
        ) temp";

        $dtColumns = $this->getDtColumns(array($this->table, 'bannersClients'));

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

    protected function doCreate(Request $request, Response $response)
    {
        try {
            $this->db->beginTransaction();

            $vars   = $this->getPostedVars($request);
            $files  = $request->getUploadedFiles();
            $myFile = reset($files['my_file']);

            if ($myFile->getError() === UPLOAD_ERR_OK) {
                throw new \Exception('File was not uploaded');
            }

            $uploadFileName = $myFile->getClientFilename();
            $ext = pathinfo($uploadFileName, PATHINFO_EXTENSION);

            $filename = null;
            while (true) {
                $filename = uniqid($this->table.'_', true) . '.'.$ext;
                if (!file_exists($this->bannersDir.$filename)) break;
            }
            $myFile->moveTo($this->bannersDir.$filename);
            $this->fitImage($filename, $vars['type']);

            $vars['file'] = $filename;

            $keys = array_keys($vars);
            $fields = '`'.implode('`, `',$keys).'`';
            $placeholder = implode(', ', array_map(function($n) {return(':'.$n);}, $keys));

            $stmt = $this->db->prepare("INSERT INTO ".$this->table." (".$fields.") VALUES (".$placeholder.")");
            foreach ($vars as $field => $value){
                if(in_array($field, ['start', 'stop'])){
                    $value = empty($value) ? null : date('Y-m-d', strtotime($value));
                }

                switch(true) {
                    case is_null($value)         : $type = \PDO::PARAM_NULL; break;
                    case is_numeric($value)      : $type = \PDO::PARAM_INT;  break;
                    default                      : $type = \PDO::PARAM_STR;
                }
                $stmt->bindValue(':'.$field, $value, $type);
            }
            $stmt->execute();


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

            $vars   = $this->getPostedVars($request);
            $files  = $request->getUploadedFiles();
            $myFile = reset($files['my_file']);

            if ($myFile->getError() === UPLOAD_ERR_OK) {
                $myFile->moveTo($this->bannersDir.$item['file']);
                $this->fitImage($item['file'], $vars['type']);
            }

            $colNames = implode(', ', array_map(function($n) {return('`'.$n.'` = :'.$n);}, array_keys($vars)));

            $vars[$this->idxField] = $args['id'];

            $stmt = $this->db->prepare("UPDATE ".$this->table." SET ".$colNames." WHERE ".$this->idxField." = :".$this->idxField." ");
            foreach ($vars as $field => $value){
                if(in_array($field, ['start', 'stop'])){
                    $value = empty($value) ? null : date('Y-m-d', strtotime($value));
                }

                switch(true) {
                    case is_null($value)         : $type = \PDO::PARAM_NULL; break;
                    case is_numeric($value)      : $type = \PDO::PARAM_INT;  break;
                    default                      : $type = \PDO::PARAM_STR;
                }
                $stmt->bindValue(':'.$field, $value, $type);
            }
            $stmt->execute();

            $this->db->commit();
            $this->flash->addMessage('success', $this->trans('Item %item_id% updated', ['%item_id%' => $args['id']]));
        } catch (\Exception $e) {
            $this->db->rollBack();

            $flashMsg = ($this->settings['displayErrorDetails']) ? $e->getMessage() : $this->trans('Item %item_id% not updated', ['%item_id%' => $args['id']]);
            $this->flash->addMessage('error', json_encode($flashMsg, JSON_PRETTY_PRINT));
        }

        return $response->withStatus(302)->withHeader('Location', $this->getListUrl());
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

            unlink($this->bannersDir.$item['file']);

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

        $stmt = $this->db->query("SELECT * FROM ".$this->table." WHERE ".$this->idxField." IN (".$args['ids'].")");
        $items = $stmt->fetchAll();

        if(count($items) != count($ids)){
            $data['errors'][] = array('message' => $this->trans('At least one record not found!'));
            return $response->withJson($data, 200);
        }

        $questionsStr = implode(',', array_fill(0, count($ids), '?'));

        try {
            $this->db->beginTransaction();

            $stmt = $this->db->prepare("DELETE FROM ".$this->table." WHERE ".$this->idxField." IN (".$questionsStr.")");
            $stmt->execute($ids);

            foreach ($items as $item){
                unlink($this->bannersDir.$item['file']);
            }

            $this->db->commit();
            $data['status'] = 1;
        } catch (\Exception $e) {
            $this->db->rollBack();
            $data['errors'][] = array('message' => $this->trans('Records not deleted'));
        }

        return $response->withJson($data, 200);
    }

    protected function fitImage($fileName, $type){
        switch ($type){
            case 'side_banner' : $width = 300; $height = 250; break;
            case 'head_banner' : $width = 728; $height =  90; break;
            case 'page_banner' : $width = 728; $height =  90; break;
            default            : $width = 728; $height =  90;
        }

        $manager = new \Intervention\Image\ImageManager();
        $img = $manager->make($this->bannersDir.$fileName)->fit($width, $height);
        $img->save($this->bannersDir.$fileName);
    }
}