<?php
if (!defined ('KS_VALID_KEY') || KS_VALID_KEY !== 'shared_version_on_snoxd')
        die ();

global $main;
$main->template->page = new Blog ();
Template::$tpl_file = Blog::$tpl_file;
Template::$title = Blog::$title;
?>