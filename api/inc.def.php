<?php
/**
 * @todo Add billing constants (requires the config's settings to be finished firstly).
 */

if (!defined ('KS_VALID_KEY') || KS_VALID_KEY !== 'shared_version_on_snoxd')
        die ();

//php constants
define ('API', './api/');
define ('CONF', './conf/');
define ('PLUGINS', './plugins/');

//Template constants
define ('TPL', '/themes/' . $conf['template']['theme'] . '/');
define ('PTPL', './themes/' . $conf['template']['theme'] . '/');
define ('TPL_TITLE', $conf['template']['title']);
define ('TPL_THEME', $conf['template']['theme']);
define ('TPL_MAINFILE', $conf['template']['main_file']);
define ('TPL_SUBFILE', $conf['template']['sub_file']);

//MYSQL constants
define ('MYSQL_HOST', $conf['database']['host']);
define ('MYSQL_DB', $conf['database']['db']);
define ('MYSQL_USER', $conf['database']['user']);
define ('MYSQL_PASS', $conf['database']['pass']);

//Account constants
define ('ACC_REGISTER', $conf['account']['register']);
define ('ACC_HASHTYPE', $conf['account']['hashing']['type']);
define ('ACC_SEED', $conf['account']['hashing']['seed']);

//Billing constants

?>