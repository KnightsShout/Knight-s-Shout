<?php
if (!defined ('KS_VALID_KEY') || KS_VALID_KEY !== 'shared_version_on_snoxd')
        die ();

class Logout extends Main
{
        static $cache = 0;
        static $timer = 0;
        static $title = '';
        static $tpl_file = 'json';
        
        function Logout () { }
        
        function doInitPage ($main)
        {
                //$main->session->doRestartSession ();
                session_destroy ();
                header ('Location: /static/farewell');
        }
}
?>