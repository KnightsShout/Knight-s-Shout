<?php
if (!defined ('KS_VALID_KEY') || KS_VALID_KEY !== 'shared_version_on_snoxd')
        die ();

global $main;

if (!LOGGED_IN)
{
        header ('Location: /login?continue=' . url_continue () . '&mod=my_account');
        exit;
}

$main->template->page = new Account ();
Template::$tpl_file = Account::$tpl_file;
Template::$title = Account::$title;
?>