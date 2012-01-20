<?php
if (!defined ('KS_VALID_KEY') || KS_VALID_KEY !== 'shared_version_on_snoxd')
        die ();

class Search extends Main
{
        static $cache = 0;
        static $timer = 0;
        static $title = '';
        static $tpl_file = 'json';
        static $result = array();
        
        function Search ()
        {
                if (!$_GET['use_ajax'])
                {
                        self::$tpl_file = TPL_SUBFILE;
                }
        }
        
        function doInitPage ($main)
        {
                $q = @doMkAccount ($_GET['q']);
                if (strlen ($q) < 3)
                {
                        Template::load ('search_too_short');
                }
                else
                {
                        if ($count = $main->database->doQuery ("SELECT * FROM MEMBERS WHERE strAccountID LIKE '%%%s%%' LIMIT 5", $q))
                        {
                                if ($_GET['use_ajax'])
                                {
                                        while (self::$result = $main->database->doRead ())
                                        {
                                                Template::load ('search_result_ajax');
                                        }
                                }
                                else
                                {
                                        Template::load ('search_result');
                                }
                                
                        }
                        else
                        {
                                Template::load ($_GET['use_ajax'] ? 'search_no_result_ajax' : 'search_no_result');
                        }
                }
        }
}
?>