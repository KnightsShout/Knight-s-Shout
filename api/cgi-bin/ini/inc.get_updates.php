<?php
if (!defined ('KS_VALID_KEY') || KS_VALID_KEY !== 'shared_version_on_snoxd')
        die ();

global $main;
$main->template->page = new Get_Updates ();
Template::$tpl_file = Get_Updates::$tpl_file;
Template::$title = Get_Updates::$title;
?>