<?php

$loader = require_once __DIR__ . '/../vendor/autoload.php';

$settings = require_once __DIR__ . '/../src/settings.php';
if(file_exists(__DIR__ . '/../src/settings.local.php')){
    $localSettings = require_once __DIR__ . '/../src/settings.local.php';
    $settings = array_replace_recursive($settings, $localSettings);
}
$settings = $settings['settings'];

function initDb($settings){
    $db = $settings['db'];

    $dbType = key($db);

    switch($dbType){
        case 'oracle': $connectionString = 'oci:dbname=//'.$db[$dbType]['host'].':'.$db[$dbType]['port'].'/'.$db[$dbType]['service_name'].';charset=UTF8'; break;
        default      : $connectionString = "mysql:host=" .$db[$dbType]['host'] . ";dbname=" . $db[$dbType]['dbname'].";charset=utf8";
    }

    $pdo = new PDO($connectionString, $db[$dbType]['user'], $db[$dbType]['pass']);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);

    $pdo->exec("SET NAMES 'utf8'");
    $pdo->exec("SET CHARACTER SET 'utf8'");
    $pdo->exec("SET SESSION collation_connection = 'utf8_general_ci'");

    return $pdo;
}

$db = initDb($settings);

$stmt = $db->prepare("UPDATE tenders SET status=-1 WHERE status!=-1 AND finishedAt < now()");
$stmt->execute();


