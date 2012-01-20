<?php
if (!defined ('KS_VALID_KEY') || KS_VALID_KEY !== 'shared_version_on_snoxd')
        die ();

class mpForum extends Main
{
        static $title;
        static $tpl_file;
        
        function mpForum () { self::$title = 'title_forum'; self::$tpl_file = $_GET['use_ajax'] ? 'json' : TPL_SUBFILE; }
        
        function doInitPage ($main)
        {
                require_once ('./conf/inc.forum.php');
                /**
                 * Load ksforum software.
                 */
                require_once ('./api/cgi-bin/forum/forum.php');
                new KSForum ($forum);
        }
}
?>