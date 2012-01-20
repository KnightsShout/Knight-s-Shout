<?php
if (!defined ('KS_VALID_KEY') || KS_VALID_KEY !== 'shared_version_on_snoxd')
        die ();

global $main;
$main->template->page = new Home ();
Template::$tpl_file = Home::$tpl_file;
Template::$title = Home::$title;
?>