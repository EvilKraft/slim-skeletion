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

class Tenders extends \Controller\RESTController
{
    protected $table     = 'tenders';
    protected $idxField  = 'tenderId';
    protected $template  = 'Admin\Tenders.twig';

    protected $columns     = ['username', 'industryname', 'name', 'description', 'createdAt', 'status'];
    protected $actions     = ['create', 'update', 'delete'];        //['messages', 'view', 'edit', 'delete']
    protected $col_filters = ['voen', 'country', 'stars'];

    public static function registerRoutes($app){
        parent::registerRoutes($app);

        $class  = static::class;
        $prefix = self::routePrefix();

        $app->get('/to-moderate',        $class.':toModerate')->setName($prefix.'_moderate');
        $app->get('/getToModerateTable', $class.':toModerateServerProcessing')->setName($prefix.'_moderate_getTable');
    }

    public function dtServerProcessing(Request $request, Response $response, Array $args)
    {
        $table = "(
            SELECT 
                    T.*,
                    IL.name AS industryname,
                    U.name AS username
                    
                FROM ".$this->table." T
                LEFT JOIN industries I ON T.industryId = I.industryId
                LEFT JOIN industries_lang IL ON I.industryId = IL.industryId AND lang='".$this->lang."'
                LEFT JOIN users U ON T.userId = U.userId
                
                ORDER BY T.".$this->idxField." ASC
        ) temp";

        $dtColumns = $this->getDtColumns();
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
        $table = "(
            SELECT 
                    T.*,
                    IL.name AS industryname,
                    U.name AS username
                FROM ".$this->table." T
                LEFT JOIN industries I ON T.industryId = I.industryId
                LEFT JOIN industries_lang IL ON I.industryId = IL.industryId AND lang='".$this->lang."'
                LEFT JOIN users U ON T.userId = U.userId
                WHERE T.status = 0
                ORDER BY T.".$this->idxField." ASC
        ) temp";

        $dtColumns = $this->getDtColumns();
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

    protected function getTableColumns($table = null, Array $ids = null){
        $columns = parent::getTableColumns($table, $ids);

        $columns['industryname'] = ['COLUMN_NAME' => 'industryname', 'DATA_TYPE' => 'string'];
        $columns['username']     = ['COLUMN_NAME' => 'username', 'DATA_TYPE' => 'string'];

        return $columns;
    }


    protected function prepareDataTable(Request $request){
        $first_row = reset($this->data['items']);

        $cols = array();
        foreach ($this->data['fields'] as $col => $val){
            $className = (is_numeric($first_row[$col])) ? 'text-right' : 'text-left';

            if($col == 'status'){
                $className = 'text-center';
            }

            $cols[] = array('title' => $this->trans($val), 'className' => $className);
        }
        $cols[] = array('title' => $this->trans('Actions'), 'className' => 'text-left action_btns_container');


        $vals = array();
        foreach ($this->data['items'] as $item){
            $vals_row = array();

            $actions = '';
            foreach ($this->data['actions'] as $action){
                switch ($action){
                    case 'messages' :
                                      $newMsgsStr = $item['msgs'] > 0 ? '<span class="label label-warning" style="font-size: 10px; padding: 1px 4px 3px 4px; vertical-align: top; position: absolute;">' . $item['msgs'] . '</span>' : '';
                                      $actions .= '<a href="'.$this->router->pathFor('tenders_msgs', ['lang' => $this->lang, 'id' => $item['id']]).'"><i class="fa fa-envelope-o fa-lg"></i>'.$newMsgsStr.'</a>';
                                      break;

                    case 'view'     : $actions .= '<a href="'.$this->router->pathFor('tenders_get', ['lang' => $this->lang, 'id' => $item[$this->idxField]]).'" title="'.$this->trans('View').'"><i class="fa fa-info-circle fa-lg"></i></a>'; break;
                    case 'edit'     : $actions .= '<a href="'.$this->router->pathFor('admin_tenders_get', ['lang' => $this->lang, 'id' => $item[$this->idxField]]).'" title="'.$this->trans('Edit').'"><i class="fa fa-edit fa-lg"></i></a>'; break;
                    case 'delete'   : $actions .= '<a href="javascript:void(0);" onclick="deleteItem(\''.$this->router->pathFor('admin_tenders_delete', ['lang' => $this->lang, 'id' => $item[$this->idxField]]).'\', this);" title="'.$this->trans('Delete').'"><i class="fa fa-remove fa-lg"></i></a>'; break;
                }
            }

            $vals_row[] = $actions;

            $vals[] = array_values($vals_row);
        }

        $this->data['tableData'] = array(
            'columns' => json_encode($cols),
            'data'    => json_encode($vals),
        );
    }

    public function toModerate(Request $request, Response $response, Array $args)
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

    protected function doUpdate(Request $request, Response $response, Array $args)
    {
        $stmt = $this->db->query("SELECT * FROM ".$this->table." WHERE ".$this->idxField." = ".(int) $args['id']);
        if (!$item = $stmt->fetch()) {
            $this->flash->addMessage('error', $this->trans('Item %item_id% not found', ['%item_id%' => $args['id']]));
            return $response->withStatus(302)->withHeader('Location', $this->getListUrl());
        }

        $vars = $this->getPostedVars($request);
        $files = $request->getUploadedFiles();

        $sets = array();
        foreach($vars as $name => $val){
            $sets[] = $name.' = ?';
        }

        $vars['finishedAt'] = (new \DateTime($vars['finishedAt']))->format('Y-m-d H:i:s');

        //make moderation complete
        $sendMail = false;
        if($item['status'] == 0){
            $sets[]   = 'status = 1';
            $sendMail = true;
        }

        $colNames = implode(' , ', $sets);

        $vals = array_values($vars);
        $vals[] = $args['id'];

        try {
            $this->db->beginTransaction();

            if(isset($files['my_file'])){
                $sql = "INSERT INTO tenderFiles SET userId=?, tenderId=?, file=?, caption=?, `type`=?, `size`=?";
                $stmt = $this->db->prepare($sql);

                foreach($files['my_file'] as $myFile){
                    if ($myFile->getError() === UPLOAD_ERR_OK) {
                        $uploadFileName = $myFile->getClientFilename();
                        $ext = pathinfo($uploadFileName, PATHINFO_EXTENSION);

                        $filename = null;
                        while (true) {
                            $filename = uniqid('tender_', true) . '.'.$ext;
                            if (!file_exists('uploads/'.$filename)) break;
                        }

                        $myFile->moveTo('uploads/' . $filename);

                        $stmt->execute(array(
                            $item['userId'],
                            $args['id'],
                            $filename,
                            $myFile->getClientFilename(),
                            $myFile->getClientMediaType(),
                            $myFile->getSize(),
                        ));
                    }
                }
            }

            $stmt = $this->db->prepare("UPDATE ".$this->table." SET ".$colNames." WHERE ".$this->idxField." = ?");
            $stmt->execute($vals);

            if($sendMail){
                $sql = "SELECT U.* 
                        FROM users U
                        INNER JOIN userIndustries UI ON U.userId = UI.userId AND UI.industryId=?
                        WHERE U.groupId = 3 AND U.status = 1";
                $stmt = $this->db->prepare($sql);
                $stmt->execute([$vars['industry']]);
                $suppliers = $stmt->fetchAll();

                $stmt = $this->db->prepare("INSERT INTO mailerQueue SET mail_from=?, name_from=?, mail_to=?, name_to=?, subject=?, text=?");
                foreach ($suppliers as $supplier){
                    $stmt->execute([
                        key($this->settings['info_mail']),
                        reset($this->settings['info_mail']),
                        $supplier['email'],
                        $supplier['name'],
                        $this->trans('New tenders'),
                        $this->renderer->fetch('Emails/NewTender.twig', $item),
                    ]);
                }
            }

            $this->db->commit();
            $this->flash->addMessage('success', $this->trans('Item %item_id% updated', ['%item_id%' => $args['id']]));
        } catch (\Exception $e) {
            $this->db->rollBack();

            $flashMsg = ($this->settings['displayErrorDetails']) ? $e->getMessage() : $this->trans('Item %item_id% not updated', ['%item_id%' => $args['id']]);
            $this->flash->addMessage('error', $flashMsg);
        }

        if($item['status'] == 0){
            return $response->withStatus(302)->withHeader('Location', $this->router->pathFor('admin_tenders_moderate', ['lang' => $this->lang]));
        }

        return $response->withStatus(302)->withHeader('Location', $this->getListUrl());
    }

    protected function extraFormData()
    {
        $stmt = $this->db->prepare("SELECT I.industryId, IL.name FROM industries I INNER JOIN industries_lang IL ON I.industryId = IL.industryId AND lang=?");
        $stmt->execute([$this->lang]);
        $this->data['industries'] = $stmt->fetchAll();

        $stmt = $this->db->prepare("SELECT * FROM userContacts WHERE userId = ? AND status = 1");
        $stmt->execute(array($this->data['item']['userId']));
        $this->data['contacts'] = $stmt->fetchAll();

        $stmt = $this->db->prepare("SELECT * FROM tenderFiles WHERE tenderId = ?");
        $stmt->execute(array($this->data['item']['id']));
        $this->data['files'] = $stmt->fetchAll();

        foreach($this->data['files'] as $key => $file){

            switch ($file['type']) {
                case (preg_match('/image.*/',                   $file['type']) ? true : false) : $this->data['files'][$key]['type'] = 'image'; break;
                case 'text/html'                                                                       : $this->data['files'][$key]['type'] = 'html'; break;
                case (preg_match('/text.*/',                    $file['type']) ? true : false) : $this->data['files'][$key]['type'] = 'text'; break;
                case (preg_match('/\.video\/(ogg|mp4|webm)$/i', $file['type']) ? true : false) : $this->data['files'][$key]['type'] = 'video'; break;
                case (preg_match('/\.audio\/(ogg|mp3|wav)$/i',  $file['type']) ? true : false) : $this->data['files'][$key]['type'] = 'audio'; break;
                case 'application/x-shockwave-flash'                                                   : $this->data['files'][$key]['type'] = 'flash'; break;
                default                                                                                : $this->data['files'][$key]['type'] = 'object'; break;
            }
        }
    }


}