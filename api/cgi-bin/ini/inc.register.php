<?php
if (!defined ('KS_VALID_KEY') || KS_VALID_KEY !== 'shared_version_on_snoxd')
        die ();

global $main;
$main->template->page = new Registration ();
Template::$tpl_file = Registration::$tpl_file;
Template::$title = Registration::$title;
?>