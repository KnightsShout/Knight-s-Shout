<?php
if (!defined ('KS_VALID_KEY') || KS_VALID_KEY !== 'shared_version_on_snoxd')
        die ();

global $main;
$main->template->page = new RSRC ();
Template::$tpl_file = RSRC::$tpl_file;
Template::$title = RSRC::$title;
?>