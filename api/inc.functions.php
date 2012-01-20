<?php
/**
 * @name PHP-Non-standard functions
 */

if (!defined ('KS_VALID_KEY') || KS_VALID_KEY !== 'shared_version_on_snoxd')
        die ();

//used for getting the microtime
//primarily useful for evaluating the pageload.
function rtime ()
{
        $time = explode (" ", microtime ());
        return (double) ((double) $time[0] + (double) $time[1]);
}

//used inside tpl files for printing the tpl quickly
function t ()
{
        echo TPL;
}

//used inside php files for getting the tpl quickly
function tp ()
{
        return TPL;
}

//used inside tpl files for printing a language var!
function __ ($var, $rpl = null)
{
        global $main;
        if (array_key_exists ($var, $main->template->vars_l))
        {
                if (is_array ($rpl))
                        $cnt = vsprintf ($main->template->vars_l[$var], $rpl);
                else
                        $cnt = $main->template->vars_l[$var];
                echo $cnt;
        }
}

//used inside php files for getting a language var!
function ___ ($var, $rpl = null)
{
        global $main;
        if (array_key_exists ($var, $main->template->vars_l))
        {
                if (is_array ($rpl))
                        $cnt = vsprintf ($main->template->vars_l[$var], $rpl);
                else
                        $cnt = $main->template->vars_l[$var];
                return $cnt;
        }
}

//used to sanitize accounts
function doMkAccount ($string)
{
        return preg_replace ('/[^a-z0-9\-_:\.]/i', '', trim (substr ($string, 0, 21)));
}

//used to verify emails
function isValidEMail ($string)
{
        return (preg_match ('/^([a-z0-9])(([-a-z0-9._])*([a-z0-9]))*\@([a-z0-9])(([a-z0-9-])*([a-z0-9]))+(\.([a-z0-9])([-a-z0-9_-])?([a-z0-9])+)+$/i', $string) ? 1 : 0);
}

//used to verify servers
function isValidServer ($string)
{
        return (preg_match ('/[^a-z0-9\-_]/i', $string) ? 0 : 1);
}

//used to sanitize servers
function doMkServer ($string)
{
        return preg_replace ('/[^a-z0-9\-_]/i', '', trim (substr ($string, 0, 21)));
}

//used to verify chars
function isValidCharacter ($string)
{
        return (preg_match ('/[^a-z0-9\-_:\.=;]/i', $string) ? 0 : 1);
}

//used to sanitize chars
function doMkCharacter ($string)
{
        return preg_replace ('/[^a-zA-Z0-9\-_:\.=;]/i', '', trim (substr ($string, 0, 35)));
}

//used to sanitize alpha-only text
function doMkAlpha ($string)
{
        return preg_replace ('/[^a-z0-9]/i', '', $string);
}

//used to make the passwords
function doMkPassword ($string)
{
        global $main;
        
        return ($main->conf['account']['hashing']['type'] == 'md5' ? md5 (sprintf ($main->conf['account']['hashing']['seed'], $string)) : sha1 (sprintf ($main->conf['account']['hashing']['seed'], $string)));
}


//@deprecated 29/05/11 1.0
//use getSN('facebook') instead.
function getFB ()
{
        global $main;
        
        return $main->conf['social_net']['facebook'];
}


//@deprecated 29/05/11 1.0
//use getSN('twitter') instead.
function getTwtr ()
{
        global $main;
        
        return $main->conf['social_net']['twitter'];
}

function getSN ($sn)
{
        global $main;
        
        return $main->conf['social_net'][$sn];
}

function blog_title_to_url ($title)
{
        return str_replace (array ('!', "'", '.', ' ', ':'), array ('', '', '', '-', ''), strtolower ($title));
}

function url_make_suitable ($url)
{
        if (!preg_match ('/https?:\/\/[a-z0-9\-\._]+[a-z]{2,5}.*/i', $url))
                return urlencode ('http://' . $_SERVER['SERVER_NAME']);
        return urlencode ($url);
}

function url_make_suitable_dec ($url)
{
        if (!preg_match ('/https?:\/\/[a-z0-9\-\._]+[a-z]{2,5}.*/i', urldecode ($url)))
                return 'http://' . $_SERVER['SERVER_NAME'];
        return urldecode ($url);
}

function url_get ()
{
        return 'http' . ($_SERVER['HTTPS'] == 'on' ? 's' : '') . '://' . $_SERVER['SERVER_NAME'] . ($_SERVER['SERVER_PORT'] != 80 ? ':' . $_SERVER['SERVER_PORT'] : '') . $_SERVER['REQUEST_URI'];
}

function url_continue ()
{
        return url_make_suitable (url_get ());
}

function doMkRString ($length)
{
        $string = '';
        $char = array ('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0');
        for ($i = 0; $i < $length; $i++)
                $string.= !rand (0, 1) ? $char[rand(0, (count ($char) - 1))] : strtoupper ($char[rand(0, (count ($char) - 1))]);
        return $string;
}

function KSArrayToString ($ksarray)
{
        $string = '';
        $array = explode (',', $ksarray);
        
        foreach ($array as $k)
                $string.= ',' . substr ($k, 1, -1);
        
        return substr ($string, 1);
}

function ArrayToKSArray ($array)
{
        $ksarray = '';
        
        foreach ($array as $k)
                $string.= ",[$k]";
        
        return substr ($string, 1);
}

function StringToKSArray ($string)
{
        return ArrayToKSArray (explode (',', $string));
}
?>