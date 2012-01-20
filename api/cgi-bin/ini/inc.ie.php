<?php
if (!defined ('KS_VALID_KEY') || KS_VALID_KEY !== 'shared_version_on_snoxd')
        die ();

global $main;
$main->template->page = new IE ();
Template::$tpl_file = IE::$tpl_file;
Template::$title = IE::$title;
?>