<?php
if (!defined ('KS_VALID_KEY') || KS_VALID_KEY !== 'shared_version_on_snoxd')
        die ();

class Server_Preview extends Main
{
        static $cache = 0;
        static $timer = 0;
        static $title;
        static $tpl_file = 'json';
        
        function Server_Preview ()
        {
                
        }
        
        function doInitPage ($main)
        {
                $f = array ('isValid' => false);
                $server = @doMkAccount ($_GET[0]);
                if (strlen ($server) < 3)
                {
                        echo json_encode ($f);
                        return;
                }
                
                echo json_encode ($f);
                
                /**
                 * preparations
                if (!$main->database->doQuery (""))
                {
                        echo json_encode ($f);
                        return;
                }
                 */
        }
}
?>