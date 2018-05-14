<?php
/**
 * Created by PhpStorm.
 * Author: Konstantin Kaluzhnikov k.kaluzhnikov@gmail.com
 * Date: 22.08.2017
 */

namespace Controller;

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;


class Reports extends BaseController
{
    protected  $data = [];

    public static function registerRoutes($app){
        $class  = static::class;

        $app->map(['GET', 'POST'], '/users-list',           $class.':usersList')->setName('usersListReport');
        $app->map(['GET', 'POST'], '/users-by-industry',    $class.':usersByIndustry')->setName('usersByIndustryReport');
    }

    public function usersList(Request $request, Response $response, Array $args) {
        $this->data['pageTitle'] = 'All users report';

        $sql = "SET @rn=0;";
        $stmt = $this->db->prepare($sql);
        $stmt->execute();

        $sql = "SELECT @rn:=@rn+1 AS rank, T1.*
                FROM (
                    SELECT 
                        U.createdAt,
                        U.name,
                        G.name AS grp_name,
                        U.voen,
                        IFNULL(T.tenders, 0) AS tenders,
                        U.stars,
                        U.email,
                        0 AS paid,
                        U.status
                    FROM users U
                    INNER JOIN userGroups G ON U.groupId = G.userGroupId
                    LEFT JOIN (
                        SELECT userId, COUNT(*) AS tenders
                        FROM tenders
                        GROUP BY userId
                    ) T ON U.userId = T.userId
                    WHERE U.groupId != 1
                    ORDER BY U.name
                ) T1;";
        $stmt = $this->db->prepare($sql);
        $stmt->execute();
        $items = $stmt->fetchAll();


        $fieldsToDisplay = array(
            'rank'        => '#',
            'createdAt'   => 'Created AT',
            'name'        => 'Name',
            'grp_name'    => 'Group',
            'voen'        => 'VÖEN',
            'tenders'     => 'Tenders',
            'stars'       => 'Stars',
            'email'       => 'Email',
            'paid'        => 'Paid',
            'status'      => 'Status',
        );

        $this->data['items'] = $this->getTableData($items, $fieldsToDisplay);

        return $this->renderer->render($response, 'Reports/usersList.twig', $this->data);
    }

    public function usersByIndustry(Request $request, Response $response, Array $args) {
        $this->data['pageTitle'] = 'Active users by industry report';

        $sql = "SELECT IL.name, COUNT(*) AS users
                FROM userIndustries UI
                INNER JOIN industries I ON I.industryId = UI.industryId
                INNER JOIN industries_lang IL ON I.industryId = IL.industryId AND lang=?
                INNER JOIN users U ON U.userId = UI.userId AND U.status = 1
                GROUP BY IL.name
                ORDER BY 1";
        $stmt = $this->db->prepare($sql);
        $stmt->execute([$this->lang]);

        $this->data['items'] = $stmt->fetchAll();

        return $this->renderer->render($response, 'Reports/usersByIndustry.twig', $this->data);
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
                    /*
                    case 'status' :
                        $class = ''; $text = '';

                        switch ($row['status']){
                            case 1  : $class = 'label-success'; $text = 'Approved';      break;
                            case 0  : $class = 'label-warning'; $text = 'On moderation'; break;
                            case -1 : $class = 'label-danger';  $text = 'Deleted';       break;
                        }

                        $tableRow[] = '<div class="text-center"><span class="label '.$class.'">'.$this->trans($text).'</span></div>';

                        break;

                    case 'suppliers' :
                        $tableRow[] = '<div class="text-center"><a class="magnificPopup" href="'.$this->router->pathFor('tenders_suppliers', ['lang' => $this->lang, 'id' => $row['id']]).'"><span class="label label-primary">'.$row[$field].'</span></a></div>';
                        break;
*/
                    default : $tableRow[] = $row[$field];
                }
            }

            if(is_array($actionBtns)){
                $btns = '';

                if($row['status'] == 1 && ($user['userId'] == $row['userId'] || $row['participate'] == 1)) {
                    $newMsgsStr = $row['msgs'] > 0 ? '<span class="label label-warning" style="font-size: 10px; padding: 1px 4px 3px 4px; vertical-align: top; position: absolute;">' . $row['msgs'] . '</span>' : '';
                    $btns .= '<a href="'.$this->router->pathFor('tenders_msgs', ['lang' => $this->lang, 'id' => $row['id']]).'"><i class="fa fa-envelope-o fa-lg"></i>'.$newMsgsStr.'</a>';
                }else{
                    $btns .= '<span style="padding:0 10px 0 9px"></span>';
                }


                if($user['userId'] == $row['userId']){
                    $icon = $row['status'] == 0 ? 'fa fa-edit fa-lg' : 'fa fa-info-circle fa-lg';
                    $btns .= '<a href="'.$this->router->pathFor('tenders_get', ['lang' => $this->lang, 'id' => $row['id']]).'"><i class="'.$icon.'"></i></a>';
                }elseif(!is_null($row['TA_Id'])){
                    $btns .= '<a href="'.$this->router->pathFor('tenders_get', ['lang' => $this->lang, 'id' => $row['id']]).'"><i class="fa fa-info-circle fa-lg"></i></a>';
                }else{
                    $fullAccessTo = new \DateTime($user['fullAccessTo']);
                    $today        = (new \DateTime())->setTime(23, 59, 59);

                    if($fullAccessTo > $today){
                        $btns .= '<a href="'.$this->router->pathFor('tenders_access', ['lang' => $this->lang, 'id' => $row['id']]).'"><i class="fa fa-unlock fa-lg"></i></a>';
                    }else{
                        $btns .= '<a href="'.$this->router->pathFor('tenders_buy_access', ['lang' => $this->lang, 'id' => $row['id']]).'" class="magnificPopup"><i class="fa fa-lock fa-lg"></i></a>';
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


}