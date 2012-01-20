<?php
if (!defined ('KS_VALID_KEY') || KS_VALID_KEY !== 'shared_version_on_snoxd')
        die ();

global $main;
$main->template->page = new pNotifications ();
Template::$tpl_file = pNotifications::$tpl_file;
Template::$title = pNotifications::$title;
?>