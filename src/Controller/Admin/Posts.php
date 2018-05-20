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
/*
    public function create(Request $request, Response $response, Array $args) {

        $data = $request->getParsedBody();
        $files = $request->getUploadedFiles();

        $data['finishedAt'] = (new \DateTime($data['finishedAt']))->format('Y-m-d H:i:s');

        try {
            $this->db->beginTransaction();

            $sql = "INSERT INTO tenders SET userId=?, name=?, industry=?, description=?, description_full=?, contact=?, finishedAt=?";
            $stmt = $this->db->prepare($sql);
            $stmt->execute(array(
                $_SESSION['user']['userId'],
                $data['name'],
                $data['industry'],
                $data['description'],
                $data['description_full'],
                $data['contact'],
                $data['finishedAt'],
            ));

            $tenderId = $this->db->lastInsertId();

            $stmt = $this->db->prepare("UPDATE tenderFiles SET tenderId=? WHERE userId=? AND tenderId IS NULL AND secret=?");
            $stmt->execute(array($tenderId, $_SESSION['user']['userId'], $data['secret']));

            $this->db->commit();
            $this->flash->addMessage('success', $this->trans('Tender created'));
        } catch (\Exception $e) {
            $this->db->rollBack();

            $flashMsg = ($this->settings['displayErrorDetails']) ? $e->getMessage() : $this->trans('Tender was not created');
            $this->flash->addMessage('error', $flashMsg);
        }
        return $response->withStatus(302)->withHeader('Location', $this->router->pathFor('tenders', ['lang' => $this->lang]));
    }
*/
    protected function doCreate(Request $request, Response $response)
    {
        $vars = $request->getParsedBody();
        $files = $request->getUploadedFiles();


        echo '<pre>'.print_r($vars, true).'</pre>';
     //   echo '<pre>'.print_r($files, true).'</pre>';
        echo '<pre>'.print_r($this->getPostedVars($request), true).'</pre>';
        echo '<pre>'.print_r($this->getPostedVars($request, $this->table.'_lang'), true).'</pre>';
        echo '<pre>'.print_r(array_keys($this->getPostedVars($request, $this->table.'_lang') + array('lang'=>'')), true).'</pre>';

        return;

        try {
            $this->db->beginTransaction();

            $vars      = $this->getPostedVars($request);
            $colNames  = implode(',', array_keys($vars));
            $questions = '?'.str_repeat(',?', (count($vars)-1));

            $stmt = $this->db->prepare("INSERT INTO ".$this->table." (".$colNames.") VALUES (".$questions.")");
            $stmt->execute(array_values($vars));

            $lastId = $this->db->lastInsertId();

            if(!empty($this->idxFieldLang)){
                $vars_lang = $this->getPostedVars($request, $this->table.'_lang');
                $vars_lang[$this->idxField] = $lastId;

                $colNames  = implode(',', array_merge(array_keys($vars_lang) + ['lang']));
                $questions = '?'.str_repeat(',?', (count($vars_lang)));

                $stmt = $this->db->prepare("INSERT INTO ".$this->table."_lang (".$colNames.") VALUES (".$questions.")");

                foreach ($this->settings['i18n']['langs'] as $lang){
                    $stmt->execute(array_merge(array_values($vars_lang) + [$lang]));
                }
            }

            $stmt = $this->db->prepare("UPDATE ".$this->table."Files SET $this->idxField=? WHERE userId=? AND $this->idxField IS NULL AND secret=?");
            $stmt->execute(array($lastId, $_SESSION['user']['userId'], $data['secret']));

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

        $vars = $request->getParsedBody();

        try {
            $this->db->beginTransaction();

            $stmt = $this->db->prepare("UPDATE ".$this->table."_lang SET title=?, text=? WHERE id=?");

            foreach ($vars['lang'] as $lang => $lang_id){
                $stmt->execute(array(
                    $vars['title'][$lang],
                    $vars['text'][$lang],
                    $lang_id
                ));
            }

            $this->db->commit();
            $this->flash->addMessage('success', $this->trans('Item %item_id% updated', ['%item_id%' => $args['id']]));
        } catch (\Exception $e) {
            $this->db->rollBack();

            $flashMsg = ($this->settings['displayErrorDetails']) ? $e->getMessage() : $this->trans('Item %item_id% not updated', ['%item_id%' => $args['id']]);
            $this->flash->addMessage('error', $flashMsg);
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

            $sql = "INSERT INTO ".$this->table."Files SET userId=?, ".$this->idxField."=?, file=?, caption=?, `type`=?, `size`=?, secret=?";
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

            $sql = "DELETE FROM ".$this->table."Files WHERE id=?";
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