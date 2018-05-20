<?php
/**
 * Created by PhpStorm.
 * Author: Konstantin Kaluzhnikov k.kaluzhnikov@gmail.com
 * Date: 22.08.2017
 */

namespace Controller\Tenders;

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;


class Tenders extends \Controller\BaseController
{
    public function index(Request $request, Response $response, Array $args) {

        $user = $_SESSION['user'];

        $data = array(
            'pageTitle' => $this->trans('Tenders')
        );

        // if buyer
        if($user['groupId'] == 2){
            $bindVals = [$this->lang, $user['userId']];

            $sql = "SELECT 
                        T.tenderId, T.userId, IL.name AS industry, T.name, T.description, T.createdAt, 
                        T.status
                    FROM tenders T
                    INNER JOIN industries I ON I.industryId = T.industryId
                    INNER JOIN industries_lang IL ON I.industryId = IL.industryId AND lang=?
                    
                    WHERE T.userId = ?
                    ORDER BY T.status DESC, T.createdAt DESC";

            $stmt = $this->db->prepare($sql);
            $stmt->execute($bindVals);

            $rows = array();
            while ($row = $stmt->fetch()) {
                $rows[] = $row;
            }

            $fieldsToDisplay = array(
                'industry'      => 'Industry',
                'T.name'        => 'Tender',
                'T.description' => 'Description',
                'T.createdAt'   => 'Created AT',
                'status'        => 'Status',
            );

            $data['myTenders'] = $this->getTableData($rows, $fieldsToDisplay, array('edit'));
        }

        // if supplier
        if($user['groupId'] == 3){
            $bindVals = [$user['userId'], $this->lang, $user['userId'], $user['userId'], $user['userId']];

            $sql = "SELECT 
                        T.tenderId, T.userId, IL.name AS industry, T.name, T.description, T.createdAt, T.status, 
                        TA.tenderAccessId AS TA_Id, TA.participate
                    FROM tenders T
                    
                    INNER JOIN userIndustries UI ON T.industryId = UI.industryId AND UI.userId = ?
                    
                    LEFT JOIN industries I ON I.industryId = T.industryId
                    LEFT JOIN industries_lang IL ON I.industryId = IL.industryId AND lang=?
                    LEFT JOIN tenderAccess TA ON TA.tenderId = T.tenderId AND TA.userId = ?
    
                    WHERE 
                        T.userId != ? 
                    AND T.status = 1
                    GROUP BY T.tenderId, T.userId, IL.name, T.name, T.createdAt, T.status, TA.tenderAccessId
                    ORDER BY T.createdAt DESC";

            $stmt = $this->db->prepare($sql);
            $stmt->execute($bindVals);


            $rows = array();
            while ($row = $stmt->fetch()) {
                $rows[] = $row;
            }

            $fieldsToDisplay = array(
                'industry'      => 'Industry',
                'T.name'        => 'Tender',
                'T.description' => 'Description',
                'T.createdAt'   => 'Created AT',
            );

            $data['activeTenders'] = $this->getTableData($rows, $fieldsToDisplay, array('edit'));
        }

        return $this->renderer->render($response, 'Tenders/index.twig', $data);
    }

    protected function getTableData(Array $rows = null, Array $fieldsToDisplay = [], Array $actionBtns = null){

        $user = $_SESSION['user'];

        if(is_null($rows) || count($rows) == 0){
            return array(
                'columns' => '',
                'data'    => '',
            );
        }

        $fieldsToDisplayList = array();
        foreach ($fieldsToDisplay as $key => $val){
            $key = explode('.', $key);
            $fieldsToDisplayList[end($key)] = $val;
        }

        $cols = array();
        foreach (current($rows) as $col => $val){
            if(array_key_exists($col, $fieldsToDisplayList)){
                $className = (is_numeric($val)) ? 'dt-body-right' : 'dt-body-left';
                $title     = $fieldsToDisplayList[$col];

                $cols[] = array('title' => $this->trans($title), 'className' => $className);
            }
        }

        if(is_array($actionBtns)){
            $cols[] = array('title' => $this->trans(''), 'className' => 'dt-body-left');
        }

        $vals = array();
        foreach ($rows as $row){

            $tableRow = array();
            foreach ($fieldsToDisplayList as $field => $title){

                switch ($field){
                    case 'status' :
                        $class = ''; $text = '';

                        switch ($row['status']){
                            case 1  : $class = 'label-success'; $text = 'Approved';      break;
                            case 0  : $class = 'label-warning'; $text = 'On moderation'; break;
                            case -1 : $class = 'label-danger';  $text = 'Finished';      break;
                        }

                        $tableRow[] = '<div class="text-center"><span class="label '.$class.'">'.$this->trans($text).'</span></div>';

                        break;

                    default : $tableRow[] = $row[$field];
                }
            }

            if(is_array($actionBtns)){
                $btns = '';

                $btns .= '<span style="padding:0 10px 0 9px"></span>';

                if($user['userId'] == $row['userId']){
                    $icon = $row['status'] == 0 ? 'fa fa-edit fa-lg' : 'fa fa-info-circle fa-lg';
                    $btns .= '<a href="'.$this->router->pathFor('tenders_get', ['lang' => $this->lang, 'id' => $row['tenderId']]).'"><i class="'.$icon.'"></i></a>';
                }elseif(!is_null($row['TA_Id'])){
                    $btns .= '<a href="'.$this->router->pathFor('tenders_get', ['lang' => $this->lang, 'id' => $row['tenderId']]).'"><i class="fa fa-info-circle fa-lg"></i></a>';
                }else{
                    $fullAccessTo = new \DateTime($user['fullAccessTo']);
                    $today        = (new \DateTime())->setTime(23, 59, 59);

                    if($fullAccessTo > $today){
                        $btns .= '<a href="'.$this->router->pathFor('tenders_access', ['lang' => $this->lang, 'id' => $row['tenderId']]).'"><i class="fa fa-unlock fa-lg"></i></a>';
                    }else{

                        $title = $this->trans('Buy access to this tender').'<br>'.$this->trans('The cost of participation in a tender: %money% AZN', ['%money%' => 0]).$this->trans('promo action');

                        $btns .= '<a href="'.$this->router->pathFor('tenders_buy_access', ['lang' => $this->lang, 'id' => $row['tenderId']]).'" class="magnificPopup" data-toggle="tooltip" title="" data-html="true" data-original-title="'.$title.'"><i class="fa fa-lock fa-lg"></i></a>';
                    }
                }

                $tableRow[] = '<div class="text-left action_btns_container">'.$btns.'</div>';
            }

            $vals[] = array_values($tableRow);
        }

        $tableData = array(
            'columns' => json_encode($cols),
            'data'    => json_encode(array_values($vals)),
        );

        return $tableData;
    }

    public function suppliers(Request $request, Response $response, Array $args) {

        $data = array();

        $sql = "SELECT 
                    TA.*,
                    U.name,
                    U.description,
                    U.phone,
                    U.email
                FROM tenderAccess TA
                INNER JOIN users U ON U.userId = TA.userId AND U.groupId = 3
                WHERE TA.participate = 1 AND TA.tenderId = ?";
        $stmt = $this->db->prepare($sql);
        $stmt->execute(array($args['id']));
        $data['suppliers'] = $stmt->fetchAll();

        return $this->renderer->render($response, 'Tenders/suppliers.twig', $data);
    }

    public function create(Request $request, Response $response, Array $args) {

        if($request->isPost()) {
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

                $stmt = $this->db->prepare("INSERT INTO tenderAccess SET userId=1, tenderId=?, participate=1");
                $stmt->execute(array($tenderId));

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

        $data = array(
            'pageTitle' => $this->trans('Tenders').' / '.$this->trans('New'),
            'files'     => [],
            'secret'    => uniqid('', true),
        );

        $stmt = $this->db->prepare("SELECT I.industryId, IL.name FROM industries I INNER JOIN industries_lang IL ON I.industryId = IL.industryId AND lang=?");
        $stmt->execute([$this->lang]);
        $data['industries'] = $stmt->fetchAll();

        $stmt = $this->db->prepare("SELECT * FROM userContacts WHERE userId = ? AND status = 1");
        $stmt->execute(array($_SESSION['user']['userId']));
        $data['contacts'] = $stmt->fetchAll();

        return $this->renderer->render($response, 'Tenders/Tenders.twig', $data);
    }

    public function get(Request $request, Response $response, Array $args) {

        $data = array(
            'pageTitle' => $this->trans('Tenders'),
            'secret'    => uniqid('', true),
        );

        $sql = "SELECT
                    T.*,
                    IL.name AS industry_name,

                    U.userId      AS user_id,
                    U.groupId     AS user_group,
                    U.name        AS user_name,
                    U.voen        AS user_voen,
                    U.phone       AS user_phone,
                    U.email       AS user_email,
                    U.site        AS user_site,
                    U.address     AS user_address,
                    U.facebook    AS user_facebook,
                    U.description AS user_description,
                    U.stars       AS user_stars,
                    (CASE WHEN V.stars IS NULL THEN 0 ELSE 1 END) AS voted,

                    UC.name       AS contact_name,
                    UC.email      AS contact_email,
                    UC.phone      AS contact_phone,
                    UC.position   AS contact_position

                FROM tenders T
                INNER JOIN users U ON U.userId = T.userId
                INNER JOIN industries I ON I.industryId = T.industryId
                INNER JOIN industries_lang IL ON I.industryId = IL.industryId AND lang=?
                INNER JOIN userContacts UC ON UC.userContactId = T.contact
                
                LEFT JOIN votes V ON V.votedFor = U.userId AND voter = ?
                
                WHERE T.tenderId = ?";
        $stmt = $this->db->prepare($sql);
        $stmt->execute(array($this->lang, $_SESSION['user']['userId'], $args['id']));

        if(!$data['item'] = $stmt->fetch()){
            $this->flash->addMessage('error', $this->trans('Tender do not exist'));
            return $response->withStatus(302)->withHeader('Location', $this->router->pathFor('tenders', ['lang' => $this->lang]));
        }

        if($_SESSION['user']['groupId'] == 2 ){
            if($_SESSION['user']['userId'] != $data['item']['userId']){
                $this->flash->addMessage('error', $this->trans('Tender do not exist'));
                return $response->withStatus(302)->withHeader('Location', $this->router->pathFor('tenders', ['lang' => $this->lang]));
            }
        }elseif($_SESSION['user']['groupId'] == 3){
            $stmt = $this->db->prepare("SELECT * FROM tenderAccess WHERE userId=? AND tenderId=?");
            $stmt->execute(array($_SESSION['user']['userId'], $args['id']));
            if (!$item = $stmt->fetch()) {
                $this->flash->addMessage('error', $this->trans('You have no access'));
                return $response->withStatus(302)->withHeader('Location', $this->router->pathFor('tenders', ['lang' => $this->lang]));
            }
        }

        $stmt = $this->db->prepare("SELECT * FROM tenderFiles WHERE tenderId = ?");
        $stmt->execute(array($args['id']));
        $data['files'] = $stmt->fetchAll();


        if($data['item']['status'] == 0){

            $stmt = $this->db->prepare("SELECT I.industryId, IL.name FROM industries I INNER JOIN industries_lang IL ON I.industryId = IL.industryId AND lang=?");
            $stmt->execute([$this->lang]);
            $data['industries'] = $stmt->fetchAll();

            $stmt = $this->db->prepare("SELECT * FROM userContacts WHERE userId = ? AND status = 1");
            $stmt->execute(array($_SESSION['user']['userId']));
            $data['contacts'] = $stmt->fetchAll();

            foreach($data['files'] as $key => $file){

                switch ($file['type']) {
                    case (preg_match('/image.*/',                   $file['type']) ? true : false) : $data['files'][$key]['type'] = 'image'; break;
                    case 'text/html'                                                               : $data['files'][$key]['type'] = 'html'; break;
                    case (preg_match('/text.*/',                    $file['type']) ? true : false) : $data['files'][$key]['type'] = 'text'; break;
                    case (preg_match('/\.video\/(ogg|mp4|webm)$/i', $file['type']) ? true : false) : $data['files'][$key]['type'] = 'video'; break;
                    case (preg_match('/\.audio\/(ogg|mp3|wav)$/i',  $file['type']) ? true : false) : $data['files'][$key]['type'] = 'audio'; break;
                    case 'application/x-shockwave-flash'                                           : $data['files'][$key]['type'] = 'flash'; break;
                    default                                                                        : $data['files'][$key]['type'] = 'object'; break;
                }
            }
            $data['pageTitle'] = $this->trans('Tenders').' / '.$this->trans('Update');

            $template = 'Tenders/Tenders.twig';
        }
        else{

            $template = 'Tenders/get.twig';
        }

        return $this->renderer->render($response, $template, $data);
    }

    public function update(Request $request, Response $response, Array $args) {
        $stmt = $this->db->prepare('SELECT * FROM tenders WHERE id=? AND status=0 AND userId=?');
        $stmt->execute(array($args['id'], $_SESSION['user']['userId']));

        if(!$data['item'] = $stmt->fetch()){
            $this->flash->addMessage('error', $this->trans('Tender do not exist'));
            return $response->withStatus(302)->withHeader('Location', $this->router->pathFor('tenders', ['lang' => $this->lang]));
        }

        $data = $request->getParsedBody();
        $files = $request->getUploadedFiles();

        $data['finishedAt'] = (new \DateTime($data['finishedAt']))->format('Y-m-d H:i:s');

        try {
            $this->db->beginTransaction();

            $stmt = $this->db->prepare("UPDATE tenderFiles SET tenderId=? WHERE userId=? AND tenderId IS NULL AND secret=?");
            $stmt->execute(array($args['id'], $_SESSION['user']['userId'], $data['secret']));


            $sql = "UPDATE tenders
                    SET name=?, industry=?, description=?, description_full=?, contact=?, finishedAt=?
                    WHERE id=? AND status=0";
            $stmt = $this->db->prepare($sql);
            $stmt->execute(array(
                $data['name'], $data['industry'], $data['description'], $data['description_full'], $data['contact'], $data['finishedAt'], $args['id']
            ));

            $this->db->commit();
            $this->flash->addMessage('success', $this->trans('Tender updated'));
        } catch (\Exception $e) {
            $this->db->rollBack();

            $flashMsg = ($this->settings['displayErrorDetails']) ? $e->getMessage() : $this->trans('Tender was not updated');
            $this->flash->addMessage('error', $flashMsg);
        }
        return $response->withStatus(302)->withHeader('Location', $this->router->pathFor('tenders', ['lang' => $this->lang]));
    }



    public function uploadFile(Request $request, Response $response, Array $args) {

        $data  = $request->getParsedBody();
        $files = $request->getUploadedFiles();

        if(!isset($files['my_file']) || !isset($data['secret'])) {
            return $response->withJson('File was not uploaded', 400);
        }

        try {
            $this->db->beginTransaction();

            $sql = "INSERT INTO tenderFiles SET userId=?, tenderId=?, file=?, caption=?, `type`=?, `size`=?, secret=?";
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

            $sql = "DELETE FROM tenderFiles WHERE id=?";
            $stmt = $this->db->prepare($sql);
            $stmt->execute(array($data['key']));

            $this->db->commit();
            return $response->withJson('File deleted', 200);
        } catch (\Exception $e) {
            $this->db->rollBack();
            return $response->withJson('File was not deleted', 400);
        }
    }



    public function participate(Request $request, Response $response, Array $args) {

        $data  = $request->getParsedBody();
        $files = $request->getUploadedFiles();

        if(!isset($files['my_file']) || !isset($data['secret'])) {
            return $response->withJson('File was not uploaded', 400);
        }

        if(!in_array($_SESSION['user']['groupId'], [1,3])){
            return $response->withJson($this->trans('You have no access'), 400);
        }

        $stmt = $this->db->prepare("SELECT * FROM tenderAccess WHERE userId=? AND tenderId=?");
        $stmt->execute(array($_SESSION['user']['userId'], $args['id']));
        if (!$item = $stmt->fetch()) {
            return $response->withJson($this->trans('You have no access'), 400);
        }

        $sql = "SELECT 
                    T.*,
                    U.name  AS user_name,
                    U.email AS user_email
                FROM tenders T
                INNER JOIN users U ON T.userId = U.userId
                WHERE T.tenderId=?";
        $stmt = $this->db->prepare($sql);
        $stmt->execute(array($args['id']));
        if (!$tender = $stmt->fetch()) {
            return $response->withJson($this->trans('Tender %item_id% not found', ['%item_id%' => $args['id']]), 400);
        }

        try {

            $emailFrom = $this->settings['info_mail'];
            $emailTo   = array($tender['user_email'] => $tender['user_name']);
            $emailBody = $this->renderer->fetch('Emails/NewSupplier.twig', array(
                'id'               => $tender['id'],
                'name'             => $tender['name'],
                'description'      => $tender['description'],
                'user_name'        => $_SESSION['user']['name'],
                'user_description' => $_SESSION['user']['description'],
                'user_phone'       => $_SESSION['user']['phone'],
                'user_email'       => $_SESSION['user']['email'],
                'text'             => $data['my_text'],
            ));

            // Setting all needed info and passing in my email template.
            $message = (new \Swift_Message($this->trans('New supplier')))
                ->setFrom($emailFrom)
                ->setTo($emailTo)
                ->setBody($emailBody)
                ->setContentType("text/html");

            foreach($files['my_file'] as $myFile){
                if ($myFile->getError() === UPLOAD_ERR_OK) {
                    $uploadFileName = $myFile->getClientFilename();
                    $ext = pathinfo($uploadFileName, PATHINFO_EXTENSION);

                    $filename = null;
                    while (true) {
                        $filename = uniqid('resume_', true) . '.'.$ext;
                        if (!file_exists('uploads/resume/'.$filename)) break;
                    }

                    $myFile->moveTo('uploads/resume/' . $filename);

                    $message->attach(\Swift_Attachment::fromPath('uploads/resume/' . $filename));
                }
            }

            // Send the message
            $result = $this->mailer->send($message);

            $this->db->beginTransaction();

            $stmt = $this->db->prepare("UPDATE tenderAccess SET participate=1 WHERE tenderAccessId = ?");
            $stmt->execute([$item['tenderAccessId']]);

            if(strlen($data['my_text']) > 0){
                $stmt->execute(array(
                    $item['tenderAccessId'],
                    $_SESSION['user']['userId'],
                    $args['id'],
                    $data['my_text']
                ));
            }


            $this->db->commit();
            return $response->withJson('File uploaded', 200);
        } catch (\Exception $e) {
            $this->db->rollBack();
            $errMsg = ($this->settings['displayErrorDetails']) ? $e->getMessage() : $this->trans('File was not uploaded');
            return $response->withJson($errMsg, 400);
        }

    }

    public function buyAccess(Request $request, Response $response, Array $args){
        if(!in_array($_SESSION['user']['groupId'], [1,3])){
            $this->flash->addMessage('error', $this->trans('You have no access'));
            return $response->withStatus(302)->withHeader('Location', $this->router->pathFor('tenders', ['lang' => $this->lang]));
        }

        $stmt = $this->db->query("SELECT * FROM tenders WHERE tenderId = ".(int) $args['id']);
        if (!$item = $stmt->fetch()) {
            $this->flash->addMessage('error', $this->trans('Tender %item_id% not found', ['%item_id%' => $args['id']]));
            return $response->withStatus(302)->withHeader('Location', $this->router->pathFor('tenders', ['lang' => $this->lang]));
        }

        $data = array('id' => (int) $args['id']);
        return $this->renderer->render($response, 'Tenders/buyAccess.twig', $data);
    }

    public function access(Request $request, Response $response, Array $args) {
        if(!in_array($_SESSION['user']['groupId'], [1,3])){
            $this->flash->addMessage('error', $this->trans('You have no access'));
            return $response->withStatus(302)->withHeader('Location', $this->router->pathFor('tenders', ['lang' => $this->lang]));
        }

        $stmt = $this->db->query("SELECT * FROM tenders WHERE tenderId = ".(int) $args['id']);
        if (!$item = $stmt->fetch()) {
            $this->flash->addMessage('error', $this->trans('Tender %item_id% not found', ['%item_id%' => $args['id']]));
            return $response->withStatus(302)->withHeader('Location', $this->router->pathFor('tenders', ['lang' => $this->lang]));
        }

        $stmt = $this->db->prepare("INSERT INTO tenderAccess SET userId=?, tenderId=?");
        $stmt->execute(array($_SESSION['user']['userId'], $item['tenderId']));

        return $response->withStatus(302)->withHeader('Location', $this->router->pathFor('tenders', ['lang' => $this->lang]));
    }

    public function finish(Request $request, Response $response, Array $args) {
        $stmt = $this->db->query("SELECT * FROM tenders WHERE tenderId = ".(int) $args['id']);
        if (!$item = $stmt->fetch()) {
            $this->flash->addMessage('error', $this->trans('Tender %item_id% not found', ['%item_id%' => $args['id']]));
            return $response->withStatus(302)->withHeader('Location', $this->router->pathFor('tenders', ['lang' => $this->lang]));
        }

        if(!($_SESSION['user']['groupId'] == 1 || $_SESSION['user']['userId'] == $item['userId'])){
            $this->flash->addMessage('error', $this->trans('You have no access'));
            return $response->withStatus(302)->withHeader('Location', $this->router->pathFor('tenders', ['lang' => $this->lang]));
        }

        $stmt = $this->db->prepare("UPDATE tenders SET status=-1 WHERE tenderId=?");
        $stmt->execute(array($item['tenderId']));

        if($_SESSION['user']['groupId'] == 1){
            $path = $this->router->pathFor('admin_tenders', ['lang' => $this->lang]);
        }else{
            $path = $this->router->pathFor('tenders', ['lang' => $this->lang]);
        }

        return $response->withStatus(302)->withHeader('Location', $path);
    }

    public function messages(Request $request, Response $response, Array $args) {
        $data = array(
            'pageTitle' => $this->trans('Tenders').' / '.$this->trans('Messages'),
        );

        $stmt = $this->db->query("SELECT * FROM tenders WHERE tenderId = ".(int) $args['id']);
        if (!$item = $stmt->fetch()) {
            $this->flash->addMessage('error', $this->trans('Tender %item_id% not found', ['%item_id%' => $args['id']]));
            return $response->withStatus(302)->withHeader('Location', $this->router->pathFor('tenders', ['lang' => $this->lang]));
        }


        return $this->renderer->render($response, 'Tenders/get.twig', $data);
    }

}