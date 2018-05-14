<?php
/**
 * Created by PhpStorm.
 * Author: Konstantin Kaluzhnikov k.kaluzhnikov@gmail.com
 * Date: 22.08.2017
 */

namespace Controller\Tenders;

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;


class Chat extends \Controller\BaseController
{

    public function save(Request $request, Response $response, Array $args){

        $data = $request->getParsedBody();


        $sql = "SELECT * FROM tenderAccess WHERE id = ?";
        $stmt = $this->db->prepare($sql);
        $stmt->execute(array($data['chatId']));
        if(!$tenderAccess = $stmt->fetch()){
            return $response->withJson(['status' => 'error', 'data' => $data, 'message' => 'Wrong data'], 400);
        }


        try {
            $this->db->beginTransaction();

            $stmt = $this->db->prepare("INSERT INTO tenderMsgs SET tenderAccessId=?, userId=?, tenderId=?, text=?");
            $stmt->execute(array(
                $tenderAccess['id'],
                $_SESSION['user']['userId'],
                $tenderAccess['tenderId'],
                $data['text'],
            ));

            $this->db->commit();
            return $response->withJson(['status' => 'OK', 'data' => $data, 'message' => 'OK'], 201);
        } catch (\Exception $e) {
            $this->db->rollBack();
            return $response->withJson(['status' => 'error', 'data' => $data, 'message' => $e->getMessage()], 400);
        }
    }

    public function getUnreaded(Request $request, Response $response, Array $args)
    {
        $requestData = $request->getParsedBody();
        $data = array(
            'items' => []
        );

        $sql = "SELECT
                    TM.*,
                    U.name
                FROM tenderMsgs TM
                LEFT JOIN users U ON U.userId = TM.userId
                WHERE
                    TM.tenderAccessId = ?
                AND TM.tenderMsgId > ?
                ORDER BY TM.createdAt";
        $stmt = $this->db->prepare($sql);
        $stmt->execute(array(
            $requestData['chatId'],
            $requestData['lastId']
        ));
        while ($row = $stmt->fetch()) {
            $row['isMe'] = $row['userId'] == $_SESSION['user']['userId'] ? 1 : 0;
            $data['items'][] = $row;
        }

        if ($requestData['isOpen'] == 'true') {
            try {
                $this->db->beginTransaction();

                $stmt = $this->db->prepare("UPDATE tenderMsgs SET readedAt = ? WHERE tenderAccessId=? AND userId != ? AND readedAt IS NULL");
                $stmt->execute(array(
                    date("Y-m-d H:i:s"),
                    $requestData['chatId'],
                    $_SESSION['user']['userId']
                ));

                $this->db->commit();
            }catch(\Exception $e) {
                $this->db->rollBack();
                return $response->withJson(['status' => 'error', 'data' => [], 'message' => $e->getMessage()], 400);
            }
        }


        $data['newMsgs'] = $this->getAllNewMessages();

        return $response->withJson(['status' => 'OK', 'data' => $data, 'message' => 'OK'], 201);
    }

    public function vote(Request $request, Response $response, Array $args)
    {

        $data = $request->getParsedBody();


        try {
            $this->db->beginTransaction();

            $stmt = $this->db->prepare("INSERT INTO `votes` (`voter`, `votedFor`, `stars`) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE `stars`=VALUES(`stars`)");
            $stmt->execute(array(
                $_SESSION['user']['userId'],
                $data['voteFor'],
                $data['stars'],
            ));

            $stmt = $this->db->prepare("SELECT IFNULL(ROUND(avg(stars)), 0) AS stars FROM votes WHERE votedFor = ?");
            $stmt->execute([$data['voteFor']]);
            $votes = $stmt->fetch();

       //     echo '<pre>'.print_r($votes, true).'</pre>'; return $response;

            $stmt = $this->db->prepare("UPDATE users SET stars=? WHERE id=?");
            $stmt->execute([$votes['stars'], $data['voteFor']]);

            $this->db->commit();
            return $response->withJson(['status' => 'OK', 'data' => $data, 'message' => 'OK'], 201);
        } catch (\Exception $e) {
            $this->db->rollBack();
            return $response->withJson(['status' => 'error', 'data' => $data, 'message' => $e->getMessage()], 400);
        }
    }

    private function getAllNewMessages(){
        switch ($_SESSION['user']['groupId']){

            case 2 :    //if buyer
                $sql = "SELECT TM.*, U.name AS user_name
                    FROM tenderMsgs TM
                    INNER JOIN tenders T ON T.tenderId = TM.tenderId AND T.userId = ?
                    INNER JOIN users U ON TM.userId = U.userId
                    WHERE TM.userId != T.userId AND TM.readedAt IS NULL";
                break;

            case 1 :    // if admin
            case 3 :    // if supplier

                $sql = "SELECT TM.*, U.name AS user_name
                    FROM tenderMsgs TM
                    INNER JOIN tenderAccess TA ON TM.tenderAccessId = TA.tenderAccessId AND TA.userId = ?
                    INNER JOIN users U ON TM.userId = U.userId
                    WHERE TM.userId != TA.userId AND TM.readedAt IS NULL";
                break;
        }
        $stmt = $this->db->prepare($sql);
        $stmt->execute(array($_SESSION['user']['userId']));

        $newMsgs = array();
        while($msg = $stmt->fetch()){
            $newMsgs[] = '<li>
                              <a href="'.$this->router->pathFor('tenders_msgs', ['lang' => $this->lang, 'id' => $msg['tenderId'], 'accessId' => $msg['tenderAccessId']]).'">
                                  <div class="pull-left">
                                      <i class="fa fa-user-circle-o fa-3x direct-chat-img"></i>
                                  </div>
                                  <h4>
                                      '.$msg['user_name'].'
                                      <small><i class="fa fa-clock-o"></i>'.$msg['createdAt'].'</small>
                                  </h4>
                                  <p>'.$msg['text'].'</p>
                              </a>
                          </li>';
        }


        return $newMsgs;
    }
}