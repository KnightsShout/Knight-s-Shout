<?php
if (!defined ('KS_VALID_KEY') || KS_VALID_KEY !== 'shared_version_on_snoxd')
        die ();

global $main;
$main->template->page = new JSContainer ();
Template::$tpl_file = JSContainer::$tpl_file;
Template::$title = JSContainer::$title;
?>