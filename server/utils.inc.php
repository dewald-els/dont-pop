<?php
/**
    * @file utils.inc.php
 * @package Dontpop
 * @category Utils
 * @author Dewald Els <dewaldifels@gmail.com>
 * Useful utils to keep the index clean.
 */

/**
 *
*/
function getRequestHeaders()
{
    $headers = array();
    foreach ($_SERVER as $key => $value) {
        if (substr($key, 0, 5) <> 'HTTP_') {
            continue;
        }
        $header = str_replace(' ', '-', ucwords(str_replace('_', ' ', strtolower(substr($key, 5)))));
        $headers[$header] = $value;
    }
    return $headers;
}
