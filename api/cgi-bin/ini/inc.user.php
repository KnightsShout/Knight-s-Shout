<?php
if (!defined ('KS_VALID_KEY') || KS_VALID_KEY !== 'shared_version_on_snoxd')
        die ();

global $main;
$main->template->page = new pUser ();
Template::$tpl_file = pUser::$tpl_file;
Template::$title = pUser::$title;
?>