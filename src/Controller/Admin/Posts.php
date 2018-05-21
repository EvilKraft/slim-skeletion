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

class Posts extends \Controller\RESTController
{
    protected $table        = 'posts';
    protected $idxField     = 'postId';
  //  protected $template    = 'Admin\Posts.twig';

    protected $columns      = ['title', 'createdAt'];
    protected $actions      = ['create', 'update', 'delete'];

    protected $idxFieldLang = 'langId';

    public static function registerRoutes($app){
        parent::registerRoutes($app);

        $class  = static::class;
        $prefix = self::routePrefix();

        $app->get('/to-moderate',        $class.':toModerate')->setName($prefix.'_moderate');
        $app->get('/getToModerateTable', $class.':toModerateServerProcessing')->setName($prefix.'_moderate_getTable');

        $app->post('/upload-file', $class.':uploadFile')->setName($prefix.'_upload_file');
        $app->post('/delete-file', $class.':deleteFile')->setName($prefix.'_delete_file');
    }

    protected function extraFormData()
    {
        parent::extraFormData();

        $stmt = $this->db->prepare("SELECT I.industryId, IL.name FROM industries I INNER JOIN industries_lang IL ON I.industryId = IL.industryId AND lang=?");
        $stmt->execute([$this->lang]);
        $this->data['industries'] = $stmt->fetchAll();

        $stmt = $this->db->prepare("SELECT * FROM cities");
        $stmt->execute();
        $this->data['cities'] = $stmt->fetchAll();

        $this->data['secret']= uniqid('', true);
        $this->data['files'] = array();
        if(isset($this->data['item'])){
            $stmt = $this->db->prepare("SELECT * FROM postFiles WHERE ".$this->idxField." = ?");
            $stmt->execute(array($this->data['item'][$this->idxField]));
            $this->data['files'] = $stmt->fetchAll();

            foreach($this->data['files'] as $key => $file){

                switch ($file['type']) {
                    case (preg_match('/image.*/',                   $file['type']) ? true : false) : $this->data['files'][$key]['type'] = 'image';  break;
                    case 'text/html'                                                                       : $this->data['files'][$key]['type'] = 'html';   break;
                    case (preg_match('/text.*/',                    $file['type']) ? true : false) : $this->data['files'][$key]['type'] = 'text';   break;
                    case (preg_match('/\.video\/(ogg|mp4|webm)$/i', $file['type']) ? true : false) : $this->data['files'][$key]['type'] = 'video';  break;
                    case (preg_match('/\.audio\/(ogg|mp3|wav)$/i',  $file['type']) ? true : false) : $this->data['files'][$key]['type'] = 'audio';  break;
                    case 'application/x-shockwave-flash'                                                   : $this->data['files'][$key]['type'] = 'flash';  break;
                    default                                                                                : $this->data['files'][$key]['type'] = 'object'; break;
                }
            }
        }
    }

    protected function doCreate(Request $request, Response $response)
    {
        $vars_lang = $this->getPostedVars($request, $this->table.'_lang');

        $new = array();
        foreach ($vars_lang as $colName => $langs){
            foreach ($langs as $lang => $value){
                $new[$lang][$colName] = $value;
            }
        }

        $new = array_merge_recursive($new, array_fill_keys(array_keys($new), [$this->idxField => 123]));

        echo '<pre>'.print_r($vars_lang, true).'</pre>';
        echo '<pre>'.print_r($new, true).'</pre>';


        return;

        try {
            $this->db->beginTransaction();

            $vars      = $this->getPostedVars($request);
            $colNames  = implode(', ', array_merge(array_keys($vars), ['userId']));
            $questions = '?'.str_repeat(', ?', (count($vars)));

            $stmt = $this->db->prepare("INSERT INTO ".$this->table." (".$colNames.") VALUES (".$questions.")");
            $stmt->execute(array_merge(array_values($vars), [$_SESSION['user']['userId']]));

            $lastId = $this->db->lastInsertId();

            if(!empty($this->idxFieldLang)){
                $vars_lang = $this->getPostedVars($request, $this->table.'_lang');
                $vars_lang[$this->idxField] = $lastId;

                $colNames  = implode(', ', array_merge(array_keys($vars_lang), ['lang']));
                $questions = '?'.str_repeat(', ?', (count($vars_lang)));

                $stmt = $this->db->prepare("INSERT INTO ".$this->table."_lang (".$colNames.") VALUES (".$questions.")");

                foreach ($this->settings['i18n']['langs'] as $lang){
                    $stmt->execute(array_merge(array_values($vars_lang), [$lang]));
                }
            }

            $stmt = $this->db->prepare("INSERT INTO ".$this->table."_industries SET ".$this->idxField."=?, industryId=?");
            foreach($request->getParsedBody()['industryId'] as $industryId){
                $stmt->execute([$lastId, $industryId]);
            }

            $stmt = $this->db->prepare("UPDATE ".$this->table."_files SET $this->idxField=? WHERE userId=? AND $this->idxField IS NULL AND secret=?");
            $stmt->execute(array($lastId, $_SESSION['user']['userId'], $request->getParsedBody()['secret']));

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

        $sql = "SELECT I.industryId, UI.userIndustryId AS UI_Id, UI.".$this->idxField."
                FROM industries I
                LEFT JOIN ".$this->table."_industries UI ON UI.industryId = I.industryId AND ".$this->idxField."=?";
        $stmt = $this->db->prepare($sql);
        $stmt->execute([$item['id']]);
        $industries = $stmt->fetchAll();

        try {
            $this->db->beginTransaction();

            $vars     = $this->getPostedVars($request);
            $colNames = implode(', ', array_map(function($n) {return($n.'=?');}, array_keys($vars)));

            $stmt = $this->db->prepare("UPDATE ".$this->table." SET ".$colNames." WHERE ".$this->idxField." = ?");
            $stmt->execute(array_merge(array_values($vars) + [$args['id']]));

            if(!empty($this->idxFieldLang)){

                $vars_lang = $this->getPostedVars($request, $this->table.'_lang');
                $colNames  = implode(', ', array_map(function($n) {return($n.'=?');}, array_keys($vars_lang)));

                $stmt = $this->db->prepare("UPDATE ".$this->table."_lang SET ".$colNames." WHERE langId = ?");

                foreach ($request->getParsedBody()['langId'] as $lang){
                    $stmt->execute(array_merge(array_values($vars_lang) + [$lang]));
                }
            }

            $insert_stmt = $this->db->prepare("INSERT INTO ".$this->table."_industries SET ".$this->idxField."=?, industryId=?");
            $delete_stmt = $this->db->prepare("DELETE FROM ".$this->table."_industries WHERE id=?");

            foreach ($industries as $industry){
                if(!is_null($industry['UI_Id']) && !in_array($industry['industryId'], $request->getParsedBody()['industryId'])){
                    $delete_stmt->execute([$industry['UI_Id']]);
                }elseif(is_null($industry['UI_Id']) && in_array($industry['industryId'], $request->getParsedBody()['industryId'])){
                    $insert_stmt->execute([$args['id'], $industry['industryId']]);
                }
            }

            $stmt = $this->db->prepare("UPDATE ".$this->table."_files SET $this->idxField=? WHERE userId=? AND $this->idxField IS NULL AND secret=?");
            $stmt->execute(array($args['id'], $_SESSION['user']['userId'], $request->getParsedBody()['secret']));

            $this->db->commit();
            $this->flash->addMessage('success', $this->trans('Item %item_id% updated', ['%item_id%' => $args['id']]));
        } catch (\Exception $e) {
            $this->db->rollBack();

            $flashMsg = ($this->settings['displayErrorDetails']) ? $e->getMessage() : $this->trans('Item %item_id% not updated', ['%item_id%' => $args['id']]);
            $this->flash->addMessage('error', json_encode($flashMsg, JSON_PRETTY_PRINT));
        }

        return $response->withStatus(302)->withHeader('Location', $this->getListUrl());
    }


    public function uploadFile(Request $request, Response $response, Array $args) {

        $data  = $request->getParsedBody();
        $files = $request->getUploadedFiles();

        if(!isset($files['my_file']) || !isset($data['secret'])) {
            return $response->withJson('File was not uploaded', 400);
        }

        try {
            $this->db->beginTransaction();

            $sql = "INSERT INTO ".$this->table."_files SET userId=?, ".$this->idxField."=?, file=?, caption=?, `type`=?, `size`=?, secret=?";
            $stmt = $this->db->prepare($sql);

            foreach($files['my_file'] as $myFile){

                if ($myFile->getError() === UPLOAD_ERR_OK) {
                    $uploadFileName = $myFile->getClientFilename();
                    $ext = pathinfo($uploadFileName, PATHINFO_EXTENSION);

                    $filename = null;
                    while (true) {
                        $filename = uniqid($this->table.'_', true) . '.'.$ext;
                        if (!file_exists('uploads/'.$filename)) break;
                    }

                    $myFile->moveTo('uploads/' . $filename);

                    $stmt->execute(array(
                        $_SESSION['user']['userId'],
                        null,
                        $filename,
                        $myFile->getClientFilename(),
                        $myFile->getClientMediaType(),
                        $myFile->getSize(),
                        $data['secret']
                    ));
                }
            }

            $this->db->commit();
            return $response->withJson('File uploaded', 200);
        } catch (\Exception $e) {
            $this->db->rollBack();

            $errMsg = ($this->settings['displayErrorDetails']) ? $e->getMessage() : $this->trans('File was not uploaded');
            return $response->withJson($errMsg, 400);
        }
    }

    public function deleteFile(Request $request, Response $response, Array $args) {

        $data = $request->getParsedBody();

        try {
            $this->db->beginTransaction();

            unlink('uploads/'.$data['file']);

            $sql = "DELETE FROM ".$this->table."_files WHERE fileId=?";
            $stmt = $this->db->prepare($sql);
            $stmt->execute(array($data['key']));

            $this->db->commit();
            return $response->withJson('File deleted', 200);
        } catch (\Exception $e) {
            $this->db->rollBack();
            return $response->withJson('File was not deleted', 400);
        }
    }
}