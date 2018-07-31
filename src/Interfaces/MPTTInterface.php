<?php
namespace Interfaces;

interface MPTTInterface
{
    public function getNode(int $id): array;
    public function deleteNode(int $id): bool;
    public function setData(int $id, array $data): bool;
    public function addChild(int $parentId, array $childData): bool;
    public function getChildren(int $id): array;
    public function getAllChildren(int $id): array;
    public function createTree(array $data): array;
    public function getTree(int $treeId): array;
    public function moveNode(int $nodeId, int $targetParent): bool;
}