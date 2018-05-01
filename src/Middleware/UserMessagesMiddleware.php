<?php
/**
 * Created by PhpStorm.
 * User: Kraft
 * Date: 18.01.2018
 * Time: 11:05
 */

namespace Middleware;

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

class UserMessagesMiddleware
{
    protected $renderer;
    protected $db;

    public function __construct(\Slim\Container $container)
    {
        $this->renderer   = $container->renderer;
        $this->db         = $container->db;
    }

    public function __invoke(Request $request, Response $response, callable $next)
    {
        $new_tenders = 0;
        if($_SESSION['user']['groupId'] == 3){
            $sql = "SELECT COUNT(*) AS new_tenders
                FROM tenders T
                LEFT JOIN tenderAccess TA ON TA.tenderId = T.tenderId AND TA.userId = ?
                WHERE T.userId != ? AND T.status = 1 AND T.industry=? AND TA.id IS NULL";
            $stmt = $this->db->prepare($sql);
            $stmt->execute(array(
                $_SESSION['user']['userId'],
                $_SESSION['user']['userId'],
                $_SESSION['user']['industry'],
            ));
            $new_tenders = $stmt->fetch()['new_tenders'];
        }
        $this->renderer->getEnvironment()->addGlobal('newTenders', $new_tenders);


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
        $newMsgs = $stmt->fetchAll();
        $this->renderer->getEnvironment()->addGlobal('newMsgs',    $newMsgs);


        if($_SESSION['user']['groupId'] == 1){
            $sql = "SELECT COUNT(*) AS to_moderate FROM tenders T WHERE T.status = 0";
            $stmt = $this->db->prepare($sql);
            $stmt->execute();
            $toModerate = $stmt->fetch()['to_moderate'];
            $this->renderer->getEnvironment()->addGlobal('toModerate', $toModerate);
        }



        return $next($request, $response, $next);
    }
}