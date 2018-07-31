<?php
/**
 * Created by PhpStorm.
 * User: Kraft
 * Date: 05.07.2018
 * Time: 16:49
 */

namespace Controller;

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

abstract class MPTTController extends RESTController implements \Interfaces\MPTTInterface
{
    const INITIAL_LEFT  = 0;
    const INITIAL_RIGHT = 1;
    const INITIAL_LEVEL = 0;

    /**
     * @var integer Parent ID that refer to the ID column.
     */
    protected $parentId = 'parentId';
    /**
     * @var string Left column name in the table.
     */
    protected $lft = 'lft';
    /**
     * @var string Right column name in the table.
     */
    protected $rgt = 'rgt';
    /**
     * @var string Level column name in the table. The root item will be start at level 1, the sub items of the root will be increase their level.
     */
    protected $lvl = 'lvl';

    /**
     * @var string Tree ID column name in the table.
     */
    protected $treeId = 'treeId';

    /**
     * @var string Position column name in the table. The position will be start at 1 for each level, it means the different level always start at 1.
     */
    private $position_column_name = 'position';

    public function dtServerProcessing(Request $request, Response $response, Array $args)
    {
        $table = $this->table;
        if(!empty($this->idxFieldLang)){
            $l_columns = 'L.'.implode(', L.', array_keys($this->getTableColumns($this->table.'_lang', [$this->idxField, $this->idxFieldLang])));

            $table = "(
                SELECT 
                    T.*, ".$l_columns.",
                    CASE WHEN T.".$this->idxField." = Z.minId THEN 1 ELSE 0 END AS isFirst,
	                CASE WHEN T.".$this->idxField." = Z.maxId THEN 1 ELSE 0 END AS isLast
                FROM ".$this->table." T
                INNER JOIN ".$this->table."_lang L ON L.".$this->idxField." = T.".$this->idxField." AND L.lang = '".$this->lang."'
                
                INNER JOIN (
                    SELECT ".$this->parentId.", MIN(".$this->idxField.") AS minId, MAX(".$this->idxField.") AS maxId
                    FROM ".$this->table."
                    GROUP BY ".$this->parentId."
                ) Z ON T.".$this->parentId." = Z.".$this->parentId."
                
                ORDER BY T.".$this->treeId.", T.".$this->lft."
            ) temp";
        }

        $dtColumns = $this->getDtColumns();
        $dtColumns[] = array('db' => 'isFirst', 'dt' => 'isFirst');
        $dtColumns[] = array('db' => 'isLast',  'dt' => 'isLast');

        $this->setFormatter($dtColumns, 'title', function( $d, $row ) {
            return str_repeat('<i class="fa fa-long-arrow-right fa-lg text-gray" aria-hidden="true" style="padding-right: 5px" ></i>', $row['lvl']).$d;
        });

        $data = \Helpers\dataTableSSP::simple($request->getQueryParams(), $this->db, $table, $this->idxField, $dtColumns);

        return $response->withJson($data, 200);
    }

    public function getNode(int $id): array
    {
        $stmt = $this->db->prepare("SELECT * FROM ".$this->table." WHERE ".$this->idxField." = ?");
        $stmt->execute([$id]);

        if(!$item = $stmt->fetch()){
            throw new \RuntimeException("Node with id {$id} not found");
        }

        return $item;
    }

    public function deleteNode(int $id): bool
    {
        $node = $this->getNode($id);

        $sql = "DELETE FROM ".$this->table." 
                WHERE 
                    ".$this->lft."   >= :left
                AND ".$this->rgt."   <= :right
                AND ".$this->treeId." = :treeId";

        $stmt = $this->db->prepare($sql);
        $r1 = $stmt->execute([
            ':left'   => $node[$this->lft],
            ':right'  => $node[$this->rgt],
            ':treeId' => $node[$this->treeId],
        ]);
        // since a node was deleted we must shrink the tree to remove the gap
        $r2 = $this->resizeAt($node[$this->rgt], $node[$this->treeId], -(2 + self::countChildren($node[$this->lft], $node[$this->rgt]) * 2));
        return $r1 && $r2;
    }

    public function setData(int $id, array $data): bool
    {
        if(count($data) == 0){ return true; }

        $colNames = implode(', ', array_map(function($n) {return($n.'=?');}, array_keys($data)));

        $stmt = $this->db->prepare("UPDATE ".$this->table." SET ".$colNames." WHERE ".$this->idxField." = ?");
        return $stmt->execute(array_merge_recursive(array_values($data), [$id]));
    }

    public function addChild(int $parentId, array $childData): bool
    {
        $parent = $this->getNode($parentId);

        $childData[$this->parentId] = $parent[$this->idxField];
        $childData[$this->lft]      = $parent[$this->rgt];
        $childData[$this->rgt]      = $childData[$this->lft] + 1;
        $childData[$this->lvl]      = $parent[$this->lvl] + 1;
        $childData[$this->treeId]   = $parent[$this->treeId];

        $r1 = $this->resizeAt($parent[$this->rgt] - 1, $parent[$this->treeId], 2);
        $r2 = $this->insertNode($childData);
        return $r1 && $r2;
    }

    public function getChildren(int $id): array
    {
        $parent = $this->getNode($id);

        $sql = "SELECT * FROM ".$this->table."
                WHERE
                    ".$this->lft."    > :lft
                AND ".$this->rgt."    < :rgt
                AND ".$this->lvl."    = :lvl   
                AND ".$this->treeId." = :treeId";

        $stmt = $this->db->prepare($sql);
        $stmt->execute([
            ':lft'    => $parent[$this->lft],
            ':rgt'    => $parent[$this->rgt],
            ':lvl'    => $parent[$this->lvl] + 1,
            ':treeId' => $parent[$this->treeId],
        ]);

        $items = $stmt->fetchAll();
        return $items;
    }

    public function getAllChildren(int $id): array
    {
        $parent = $this->getNode($id);

        $sql = "SELECT * FROM ".$this->table."
                WHERE
                    ".$this->lft."    > :lft
                AND ".$this->rgt."    < :rgt
                AND ".$this->treeId." = :treeId";

        $stmt = $this->db->prepare($sql);
        $stmt->execute([
            ':lft'    => $parent[$this->lft],
            ':rgt'    => $parent[$this->rgt],
            ':treeId' => $parent[$this->treeId],
        ]);

        $items = $stmt->fetchAll();
        return $items;
    }

    public function createTree(array $data): array
    {
        $stmt = $this->db->prepare("SELECT IFNULL(MAX(treeId), 0) FROM ".$this->table);
        $stmt->execute();
        $nextTreeId = $stmt->fetchColumn() + 1;

        $data[$this->lft]    = self::INITIAL_LEFT;
        $data[$this->rgt]    = self::INITIAL_RIGHT;
        $data[$this->lvl]    = self::INITIAL_LEVEL;
        $data[$this->treeId] = $nextTreeId;

        $this->insertNode($data);

        return $this->getTree($nextTreeId);
    }

    public function getTree(int $treeId): array
    {
        $sql = "SELECT * FROM ".$this->table." WHERE ".$this->lvl." = ? AND ".$this->treeId." = ?";
        $stmt = $this->db->prepare($sql);
        $stmt->execute([self::INITIAL_LEVEL, $treeId]);

        if(!$item = $stmt->fetch()){
            throw new \RuntimeException("Tree with treeId {$treeId} not found");
        }

        return $item;
    }

    public function moveNode(int $nodeId, int $targetParent): bool
    {
        $node = $this->getNode($nodeId);
        $target = $this->getNode($targetParent);

        // expand the target parent to fit the node and its children
        $growth = 2 + self::countChildren($node[$this->lft], $node[$this->rgt]) * 2;
        $r1 = $this->resizeAt($target[$this->rgt] - 1, $target[$this->treeId], $growth);
        $moveDelta = $target[$this->rgt] + $growth - $node[$this->rgt] - 1;
        $depthDelta = $target[$this->lvl] + 1 - $node[$this->lvl];
        // use the deltas to move the node and its children to the parent

        $sql = "UPDATE ".$this->table."
                SET
                    ".$this->lft." = ".$this->lft." + :move_delta_1,
                    ".$this->rgt." = ".$this->rgt." + :move_delta_2,
                    ".$this->lvl." = ".$this->lvl." + :depth_delta
                WHERE 
                    ".$this->lft."   >= :left
                AND ".$this->rgt."   <= :right
                AND ".$this->treeId." = :treeId";

        $stmt = $this->db->prepare($sql);
        $r2 = $stmt->execute([
            ':move_delta_1' => $moveDelta,
            ':move_delta_2' => $moveDelta,
            ':left'         => $node[$this->lft],
            ':right'        => $node[$this->rgt],
            ':treeId'       => $node[$this->treeId],
            ':depth_delta'  => $depthDelta,
        ]);
        // remove the leftover space after moving the node
        $r3 = $this->resizeAt($node[$this->rgt], $node[$this->treeId], -$growth);
        return $r1 && $r2 && $r3;
    }



    /**
     * Grow or shrink the tree from the specified position. If $value is positive, the tree grows from $position
     * to the right. If $value is negative, the tree shrinks from $position to the left.
     * @param int $position
     * @param int $treeId
     * @param int $value
     * @return bool
     */
    protected function resizeAt(int $position, int $treeId, int $value): bool
    {
        $sql = "UPDATE ".$this->table."
                SET
                    ".$this->lft." = (SELECT CASE WHEN ".$this->lft." > :position_1 THEN ".$this->lft." + :value_1 ELSE ".$this->lft." END),
                    ".$this->rgt." = (SELECT CASE WHEN ".$this->rgt." > :position_2 THEN ".$this->rgt." + :value_2 ELSE ".$this->rgt." END)
                WHERE ".$this->treeId." = :treeId";

        $stmt = $this->db->prepare($sql);
        return $stmt->execute([
            ':position_1' => $position,
            ':position_2' => $position,
            ':treeId'     => $treeId,
            ':value_1'    => $value,
            ':value_2'    => $value,
        ]);
    }

    /**
     * Write a node to the database.
     * @param array $data
     * @return bool
     */
    protected function insertNode(array $data): bool
    {
        $colNames  = implode(', ', array_keys($data));
        $questions = implode(',', array_fill(0, count($data), '?'));

        $stmt = $this->db->prepare("INSERT INTO ".$this->table." (".$colNames.") VALUES (".$questions.")");
        $res  = $stmt->execute(array_values($data));

        $lastId = $this->db->lastInsertId();

        return $res;
    }

    /**
     * @return int
     */
    public static function countChildren(int $lft, int $rgt): int
    {

        return (int) floor(($rgt - $lft) / 2);
    }
}