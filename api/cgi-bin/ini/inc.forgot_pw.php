<?php
if (!defined ('KS_VALID_KEY') || KS_VALID_KEY !== 'shared_version_on_snoxd')
        die ();

global $main;
$main->template->page = new ForgotPW ();
Template::$tpl_file = ForgotPW::$tpl_file;
Template::$title = ForgotPW::$title;
?>