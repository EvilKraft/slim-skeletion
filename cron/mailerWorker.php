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

function initMailer($settings){
    $config = $settings['SwiftMailer'];
    $transport = false;
    if ('smtp' === $config['transport']) {
        $transport = new \Swift_SmtpTransport();
        $options = [
            'host', 'port', 'encryption',
            'auth_mode', 'username', 'password'
        ];
    } elseif ('sendmail' === $config['transport']) {
        $transport = new \Swift_SendmailTransport();
        $options = ['command'];
    }
    if ($transport) {
        if (isset($options) && is_array($options) && !empty($options)) {
            foreach ($options as $option) {
                if (isset($config[$option]) && $config[$option]) {
                    $methodName = str_replace('_', ' ', $option);
                    $methodName = ucwords($methodName);
                    $methodName = str_replace(' ', '', $methodName);
                    $methodName = 'set' . $methodName;
                    $transport->{$methodName}($config[$option]);
                }
            }
        }
        return new \Swift_Mailer($transport);
    }
    return false;
}


$db     = initDb($settings);
$mailer = initMailer($settings);

$limit = (int) $settings['mailer_queue_limit'];
if ($limit < 1) {$limit = 1;}

$stmt = $db->prepare("SELECT * FROM mailerQueue WHERE status = 0 ORDER BY createdAt LIMIT ".$limit);
$stmt->execute();
$items = $stmt->fetchAll();

$stmt = $db->prepare("UPDATE mailerQueue SET status=1, sendAt=? WHERE id=?");

foreach ($items as $item){
    $emailFrom = array($item['mail_from'] => $item['name_from']);
    $emailTo   = array($item['mail_to']   => $item['name_to']);

    $message = (new \Swift_Message($item['subject']))
        ->setFrom($emailFrom)
        ->setTo($emailTo)
        ->setBody($item['text'])
        ->setContentType("text/html");

    // Send the message
    $result = $mailer->send($message);

    if($result == 1){
        $stmt->execute([
            (new \DateTime())->format('Y-m-d H:i:s'),
            $item['id'],
        ]);
    }
}

