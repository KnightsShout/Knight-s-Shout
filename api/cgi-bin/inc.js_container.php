<?php
if (!defined ('KS_VALID_KEY') || KS_VALID_KEY !== 'shared_version_on_snoxd')
        die ();

class JSContainer extends Main
{
        static $cache = 0;
        static $timer = 0;
        static $title = '';
        static $tpl_file = 'json';
        
        function JSContainer ()
        {
                header ('Content-type: text/javascript');
        }
        
        function doInitPage ($main)
        {
                if (!isset ($_GET['container']))
                {
                        ob_end_flush ();
                        exit;
                }
                
                $arg = $_GET['container'];
                $args = explode (',', $arg);
                foreach ($args as $key)
                {
                        if (preg_match ('/[^a-z0-9_\-\.]/i', $key) ^ strlen ($key) < 1)
                                continue;
                        echo @file_get_contents (PTPL . 'js/' . $key . '.js');
                        ob_flush ();
                }
                
                ob_end_flush ();
                exit;
        }
}
?>