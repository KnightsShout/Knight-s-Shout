<?php
if (!defined ('KS_VALID_KEY') || KS_VALID_KEY !== 'shared_version_on_snoxd')
        die ();

global $main;
$main->template->page = new Login ();
Template::$tpl_file = Login::$tpl_file;
Template::$title = Login::$title;
?>