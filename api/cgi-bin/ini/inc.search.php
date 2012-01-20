<?php
if (!defined ('KS_VALID_KEY') || KS_VALID_KEY !== 'shared_version_on_snoxd')
        die ();

global $main;
$main->template->page = new Search ();
Template::$tpl_file = Search::$tpl_file;
Template::$title = Search::$title;
?>