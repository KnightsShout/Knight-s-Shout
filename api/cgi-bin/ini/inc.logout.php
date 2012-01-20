<?php
if (!defined ('KS_VALID_KEY') || KS_VALID_KEY !== 'shared_version_on_snoxd')
        die ();

global $main;
$main->template->page = new Logout ();
Template::$tpl_file = Logout::$tpl_file;
Template::$title = Logout::$title;
?>