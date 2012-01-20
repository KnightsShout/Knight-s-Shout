<?php
if (!defined ('KS_VALID_KEY') || KS_VALID_KEY !== 'shared_version_on_snoxd')
        die ();

global $main;
$main->template->page = new COMET ('ajax', $main);
Template::$tpl_file = COMET::$tpl_file;
Template::$title = COMET::$title;
?>