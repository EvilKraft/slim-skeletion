<?php
/**
 * Created by PhpStorm.
 * Author: Konstantin Kaluzhnikov k.kaluzhnikov@gmail.com
 * Date: 22.08.2017
 */

namespace Controller\Admin;

use \Controller\RESTController;
use phpDocumentor\Reflection\Types\Array_;
use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;
use Symfony\Component\Config\Definition\Exception\Exception;

class Posts extends RESTController
{
    protected $table        = 'posts';
    protected $idxField     = 'postId';
  //  protected $template    = 'Admin\Posts.twig';

    protected $columns      = ['name', 'title', 'createdAt', 'status'];
    protected $actions      = ['create', 'update', 'delete'];

    protected $idxFieldLang = 'langId';

    public static function registerRoutes($app){
        parent::registerRoutes($app);

        $class  = static::class;
        $prefix = self::routePrefix();

        $app->get('/moderate',                               $class.':toModerate')->setName($prefix.'_moderate');
        $app->map(['GET', 'PUT'], '/moderate/{id:[0-9]+}',   $class.':doModerate')->setName($prefix.'_domoderate');
        $app->get('/getToModerateTable', $class.':toModerateServerProcessing')->setName($prefix.'_moderate_getTable');


        $app->get('/{id:[0-9]+}/finish', $class.':finish')->setName($prefix.'_finish');

        $app->post('/upload-file', $class.':uploadFile')->setName($prefix.'_upload_file');
        $app->post('/delete-file', $class.':deleteFile')->setName($prefix.'_delete_file');
    }

    public function dtServerProcessing(Request $request, Response $response, Array $args)
    {
        $l_columns = 'L.'.implode(', L.', array_keys($this->getTableColumns($this->table.'_lang', [$this->idxField, $this->idxFieldLang])));
        $u_columns = 'U.'.implode(', U.', array_keys($this->getTableColumns('users', ['userId', 'createdAt', 'site', 'status', 'cityId'])));

        $table = "(
            SELECT T.*, ".$l_columns.", ".$u_columns."
            FROM ".$this->table." T
            INNER JOIN ".$this->table."_lang L ON L.".$this->idxField." = T.".$this->idxField." AND L.lang = '".$this->lang."'
            INNER JOIN users U ON T.userId = U.userId
            ORDER BY T.".$this->idxField." ASC
        ) temp";

        $dtColumns = $this->getDtColumns(array($this->table, $this->table.'_lang', 'users'));
        $this->setFormatter($dtColumns, 'status', function( $d, $row ) {
            switch ($d){
                case 1  : $class = 'label-success'; $text = 'Approved';      break;
                case 0  : $class = 'label-warning'; $text = 'On moderation'; break;
                case -1 : $class = 'label-danger';  $text = 'Finished';      break;
            }

            return '<div class="text-center"><span class="label '.$class.'">'.$this->trans($text).'</span></div>';
        });

        $data = \Helpers\dataTableSSP::simple($request->getQueryParams(), $this->db, $table, $this->idxField, $dtColumns);

        return $response->withJson($data, 200);
    }

    public function toModerateServerProcessing(Request $request, Response $response, Array $args)
    {
        $l_columns = 'L.'.implode(', L.', array_keys($this->getTableColumns($this->table.'_lang', [$this->idxField, $this->idxFieldLang])));
        $u_columns = 'U.'.implode(', U.', array_keys($this->getTableColumns('users', ['userId', 'createdAt', 'site', 'status', 'cityId'])));

        $table = "(
            SELECT T.*, ".$l_columns.", ".$u_columns."
            FROM ".$this->table." T
            INNER JOIN ".$this->table."_lang L ON L.".$this->idxField." = T.".$this->idxField." AND L.lang = '".$this->lang."'
            INNER JOIN users U ON T.userId = U.userId
            WHERE T.status = 0
            ORDER BY T.".$this->idxField." ASC
        ) temp";

        $dtColumns = $this->getDtColumns(array($this->table, $this->table.'_lang', 'users'));
        $this->setFormatter($dtColumns, 'status', function( $d, $row ) {
            switch ($d){
                case 1  : $class = 'label-success'; $text = 'Approved';      break;
                case 0  : $class = 'label-warning'; $text = 'On moderation'; break;
                case -1 : $class = 'label-danger';  $text = 'Finished';      break;
            }

            return '<div class="text-center"><span class="label '.$class.'">'.$this->trans($text).'</span></div>';
        });

        $data = \Helpers\dataTableSSP::simple($request->getQueryParams(), $this->db, $table, $this->idxField, $dtColumns);

        return $response->withJson($data, 200);
    }

    public function toModerate(Request $request, Response $response, Array $args)
    {
        return $this->doList($request, $response);
    }

    public function doModerate(Request $request, Response $response, Array $args)
    {
        if($request->isPut()){
            return $this->doUpdate($request, $response, $args);
        }

        return $this->get($request, $response, $args);
    }

    public function finish(Request $request, Response $response, Array $args)
    {
        $stmt = $this->db->query("SELECT * FROM ".$this->table." WHERE ".$this->idxField." = ".(int) $args['id']);
        if (!$item = $stmt->fetch()) {
            $this->flash->addMessage('error', $this->trans('Item %item_id% not found', ['%item_id%' => $args['id']]));
            return $response->withStatus(302)->withHeader('Location', $this->getListUrl());
        }
        try {
            $this->db->beginTransaction();

            $stmt = $this->db->prepare("UPDATE ".$this->table." SET status = -1 WHERE ".$this->idxField." = ?");
            $stmt->execute([$args['id']]);

            $this->db->commit();
            $this->flash->addMessage('success', $this->trans('Item %item_id% updated', ['%item_id%' => $args['id']]));
        } catch (\Exception $e) {
            $this->db->rollBack();

            $flashMsg = ($this->settings['displayErrorDetails']) ? $e->getMessage() : $this->trans('Item %item_id% not updated', ['%item_id%' => $args['id']]);
            $this->flash->addMessage('error', json_encode($flashMsg, JSON_PRETTY_PRINT));
        }

        return $response->withStatus(302)->withHeader('Location', $this->getListUrl());
    }


    protected function extraFormData()
    {
        parent::extraFormData();

      //  $stmt = $this->db->prepare("SELECT I.industryId, IL.name FROM industries I INNER JOIN industries_lang IL ON I.industryId = IL.industryId AND lang=?");
     //   $stmt->execute([$this->lang]);
     //   $this->data['industries'] = $stmt->fetchAll();

        $sql = "SELECT I.industryId, IL.name, PI.id AS PI_Id, PI.".$this->idxField."
                FROM industries I
                INNER JOIN industries_lang IL ON I.industryId = IL.industryId AND lang=?
                LEFT JOIN ".$this->table."_industries PI ON PI.industryId = I.industryId AND ".$this->idxField."=?";
        $stmt = $this->db->prepare($sql);
        $stmt->execute([$this->lang, @$this->data['item'][$this->idxField]]);
        $this->data['industries'] = $stmt->fetchAll();


        $stmt = $this->db->prepare("SELECT * FROM cities");
        $stmt->execute();
        $this->data['cities'] = $stmt->fetchAll();

        $this->data['secret']= uniqid('', true);
        $this->data['files'] = array();
        if(isset($this->data['item'])){
            $stmt = $this->db->prepare("SELECT * FROM ".$this->table."_files WHERE ".$this->idxField." = ?");
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

        try {
            $this->db->beginTransaction();

            $vars           = $this->getPostedVars($request);
            $vars['userId'] = $_SESSION['user']['userId'];

            $keys = array_keys($vars);
            $fields = '`'.implode('`, `',$keys).'`';
            $placeholder = implode(', ', array_map(function($n) {return(':'.$n);}, $keys));

            $stmt = $this->db->prepare("INSERT INTO ".$this->table." (".$fields.") VALUES (".$placeholder.")");
            foreach ($vars as $field => $value){
                if($field == 'buildedAt'){
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

            $lastId = $this->db->lastInsertId();

            if(!empty($this->idxFieldLang)){
                $tableColumns = $this->getTableColumns($this->table.'_lang');

                $vars_lang = array();
                foreach ($this->settings['i18n']['langs'] as $lang){
                    $vars = array_intersect_key($request->getParsedBody()[$lang], $tableColumns);
                    $vars_lang[$lang] = array_merge_recursive( [$this->idxField => $lastId, 'lang' => $lang ], $vars);

                    $vars_lang[$lang]['text_search'] = strip_tags($vars_lang[$lang]['text']);
                }


                $colNames  = implode(', ', array_keys(reset($vars_lang)));
                $questions = '?'.str_repeat(', ?', (count(reset($vars_lang))-1));

                $stmt = $this->db->prepare("INSERT INTO ".$this->table."_lang (".$colNames.") VALUES (".$questions.")");

                foreach ($vars_lang as $lang => $vars){
                    $stmt->execute(array_values($vars));
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

        $sql = "SELECT I.industryId, PI.id AS PI_Id, PI.".$this->idxField."
                FROM industries I
                LEFT JOIN ".$this->table."_industries PI ON PI.industryId = I.industryId AND ".$this->idxField."=?";
        $stmt = $this->db->prepare($sql);
        $stmt->execute([$args['id']]);
        $industries = $stmt->fetchAll();

        try {
            $this->db->beginTransaction();

            $vars     = $this->getPostedVars($request);
            $colNames = implode(', ', array_map(function($n) {return('`'.$n.'` = :'.$n);}, array_keys($vars)));

            $vars[$this->idxField] = $args['id'];

            $stmt = $this->db->prepare("UPDATE ".$this->table." SET ".$colNames." WHERE ".$this->idxField." = :".$this->idxField." ");
            foreach ($vars as $field => $value){
                if($field == 'buildedAt'){
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

            if(!empty($this->idxFieldLang)){
                $tableColumns = $this->getTableColumns($this->table.'_lang');

                $vars_lang = array();
                foreach ($this->settings['i18n']['langs'] as $lang){
                    $vars_lang[$lang] = array_intersect_key($request->getParsedBody()[$lang], $tableColumns);

                    $vars_lang[$lang]['text_search'] = strip_tags($vars_lang[$lang]['text']);
                }

                $colNames  = implode(', ', array_map(function($n) {return($n.'=?');}, array_keys(reset($vars_lang))));

                $stmt = $this->db->prepare("UPDATE ".$this->table."_lang SET ".$colNames." WHERE ".$this->idxFieldLang." = ?");

                foreach ($vars_lang as $lang => $vars){
                    $stmt->execute(array_merge(array_values($vars), [$request->getParsedBody()[$lang][$this->idxFieldLang]]));
                }
            }

            $insert_stmt = $this->db->prepare("INSERT INTO ".$this->table."_industries SET ".$this->idxField."=?, industryId=?");
            $delete_stmt = $this->db->prepare("DELETE FROM ".$this->table."_industries WHERE id=?");

            foreach ($industries as $industry){
                if(!empty($industry['PI_Id']) && !in_array($industry['industryId'], $request->getParsedBody()['industryId'])){
                    $delete_stmt->execute([$industry['PI_Id']]);
                }elseif(empty($industry['PI_Id']) && in_array($industry['industryId'], $request->getParsedBody()['industryId'])){
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