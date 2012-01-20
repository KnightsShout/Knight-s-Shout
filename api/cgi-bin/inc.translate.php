<?php
if (!defined ('KS_VALID_KEY') || KS_VALID_KEY !== 'shared_version_on_snoxd')
        die ();

class Translate extends Main
{
        static $cache = 0;
        static $timer = 0;
        static $title = 'title_translate';
        static $tpl_file = 'json';
        
        function Translate () { if (!$_GET['use_ajax']) { header ('Location: /'); return; } }
        
        function doInitPage ($main)
        {
                if (@isset ($_GET['overview']))
                {
                        Template::load ('translate');
                }
                elseif (@isset ($_GET['to']))
                {
                        if (array_key_exists ($_GET['to'], $main->conf['translation']['languages']))
                        {
                                $_SESSION['strLang'] = $_GET['to'];
                                /*echo "o.o";
                                exit;*/
                        }
                        
                        #header ('Location: /');
                        echo "<script type='text/javascript'>location.reload(true);</script>";
                        return;
                }
                elseif (@isset ($_GET['act']))
                {
                        if ($_GET['act'] == 'info')
                        {
                                Template::load ('translate_info');
                        }
                        else
                        {
                                
                        }
                }
        }
}
?>