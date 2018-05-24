<?php
/**
 * Created by PhpStorm.
 * Author: Konstantin Kaluzhnikov k.kaluzhnikov@gmail.com
 * Date: 22.08.2017
 */

namespace Helpers;

class Helpers
{
    public static function floordec($zahl,$decimals=2){
        return floor($zahl*pow(10,$decimals))/pow(10,$decimals);
    }


    public static function timeago($datetime){
        $time = time() - strtotime($datetime);

        $units = array (
            31536000 => 'year',
            2592000 => 'month',
            604800 => 'week',
            86400 => 'day',
            3600 => 'hour',
            60 => 'minute',
            1 => 'second'
        );

        foreach ($units as $unit => $val) {
            if ($time < $unit) continue;
            $numberOfUnits = floor($time / $unit);
            return ($val == 'second')? 'a few seconds ago' :
                (($numberOfUnits>1) ? $numberOfUnits : 'a')
                .' '.$val.(($numberOfUnits>1) ? 's' : '').' ago';
        }

        return '';
    }

    public static function phoneFormat($num){
        return ($num)?'('.substr($num,0,3).') '.substr($num,3,3).'-'.substr($num,6,4):'';
    }
}