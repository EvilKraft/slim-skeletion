/**
 * Created by PhpStorm.
 * Author: Konstantin Kaluzhnikov k.kaluzhnikov@gmail.com
 * Date: 22.08.2017
 */

function appendAlert(type, text) {
    $.toast({
        heading: toTitleCase(type)+'!',
        text: text,
    	icon: type,
        position: 'bottom-right',
        showHideTransition: 'slide',
        loader: false,
	});
}

var randomColorFactor = function() {
	return Math.round(Math.random() * 255);
};
var randomColor = function(opacity) {
	return 'rgba(' + randomColorFactor() + ',' + randomColorFactor() + ',' + randomColorFactor() + ',' + (opacity || '.3') + ')';
};

/**
 * Number.prototype.format(n, x, s, c)
 * 
 * 12345678.9.format(2, 3, '.', ',');  // "12.345.678,90"
 * 123456.789.format(4, 4, ' ', ':');  // "12 3456:7890"
 * 12345678.9.format(0, 3, '-');       // "12-345-679"
 *
 * @param integer n: length of decimal
 * @param integer x: length of whole part
 * @param mixed   s: sections delimiter
 * @param mixed   c: decimal delimiter
 */
Number.prototype.format = function(n, x, s, c) {
	var re = '\\d(?=(\\d{' + (x || 3) + '})+' + (n > 0 ? '\\D' : '$') + ')',
		num = this.toFixed(Math.max(0, ~~n));

	return (c ? num.replace('.', c) : num).replace(new RegExp(re, 'g'), '$&' + (s || ','));
};


function toTitleCase(str)
{
    return str.replace(/\w\S*/g, function(txt){return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();});
}