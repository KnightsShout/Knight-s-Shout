<?php
if (!defined ('KS_VALID_KEY') || KS_VALID_KEY !== 'shared_version_on_snoxd')
        die ();

global $main;
$main->template->page = new Server_Preview ();
Template::$tpl_file = Server_Preview::$tpl_file;
Template::$title = Server_Preview::$title;
?>