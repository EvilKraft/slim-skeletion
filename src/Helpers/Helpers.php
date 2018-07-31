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

    public static function isImageMIME($mimeType){
        return in_array($mimeType, ['image/gif', 'image/jpeg', 'image/png']);
    }

    public static function array_diff_keys(Array $array1, Array $array2){
        $keys1 = array_keys(reset($array1));
        $keys2 = array_keys(reset($array2));

        $diff1 = array_diff_key($array1, $array2);
        $diff2 = array_diff_key($array2, $array1);

        $items = array();
        foreach ($diff1 as $item){
            $items[] = array_merge($item, array_fill_keys($keys2, ''));
        }

        foreach ($diff2 as $item){
            $items[] = array_merge(array_fill_keys($keys1, ''), $item);
        }

        return $items;
    }
}