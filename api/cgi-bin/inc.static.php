<?php
if (!defined ('KS_VALID_KEY') || KS_VALID_KEY !== 'shared_version_on_snoxd')
        die ();

class pStatic extends Main
{
        static $cache = 0;
        static $timer = 0;
        static $title = 'title_welcome_logged_in';
        static $tpl_file;
        
        function pStatic () { self::$tpl_file = LOGGED_IN ? TPL_SUBFILE : TPL_MAINFILE; }
        
        function doInitPage ($main)
        {
                $page = preg_replace ('/[^a-z0-9_\-]+/i', '', @$_GET[0]);
                
                if (!file_exists (PTPL . 'tpl/static/' . $page . '.tpl'))
                {
                        Template::load ('static_failure');
                        return;
                }
                
                Template::load ('static/' . $page);
        }
}
?>