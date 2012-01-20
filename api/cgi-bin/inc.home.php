<?php
if (!defined ('KS_VALID_KEY') || KS_VALID_KEY !== 'shared_version_on_snoxd')
        die ();

class Home extends Main
{
        static $cache = 0;
        static $timer = 0;
        static $title;
        static $tpl_file;
        
        function Home ()
        {
                self::$title = LOGGED_IN ? 'title_welcome_logged_in' : 'title_welcome_logged_out';
                self::$tpl_file = LOGGED_IN ? TPL_SUBFILE : TPL_MAINFILE;
        }
        
        function doInitPage ($main)
        {
                if (!LOGGED_IN)
                {
                        Template::load ('home_logged_out');
                }
                else
                {
                        
                }
        }
}
?>