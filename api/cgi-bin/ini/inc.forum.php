<?php
if (!defined ('KS_VALID_KEY') || KS_VALID_KEY !== 'shared_version_on_snoxd')
        die ();

global $main;
define ('FORUM', 'load-forum-zz345%');
$main->template->page = new mpForum ();
Template::$tpl_file = mpForum::$tpl_file;
Template::$title = mpForum::$title;
?>