<?php
if (!defined ('KS_VALID_KEY') || KS_VALID_KEY !== 'shared_version_on_snoxd')
        die ();

class Account extends Main
{
        static $cache = 0;
        static $timer = 0;
        static $title = 'title_welcome_logged_in';
        static $tpl_file = TPL_SUBFILE;
        static $count = 0;
        private $main;
        
        function Account ()
        {
                self::$tpl_file = !$_GET['use_ajax'] ? TPL_SUBFILE : 'json';
        }
        
        function doInitPage ($main)
        {
                $this->main = $main;
                
                if ($_GET['use_ajax'])
                {
                        $this->ajax ($main);
                        return;
                }
                
                $section = @isset ($_GET[0]) ? $_GET[0] : 'overview';
                
                if ($section == 'game')
                {
                        Template::load ('account_game');
                }
                elseif ($section == 'server')
                {
                        self::$count = $main->database->doQuery ("SELECT * FROM SERVERS WHERE tOwners LIKE '%%%s%%'", '[' . $_SESSION['strAccount'] . ']');
                        
                        if (@$_GET[1] == 'create')
                        {
                                Template::load ('account_server_create');
                        }
                        else
                        {
                                Template::load ('account_server');
                        }
                }
                elseif ($section == 'personality')
                {
                        Template::load ('account_personality');
                }
                elseif ($section == 'settings')
                {
                        Template::load ('account_settings');
                }
                else
                {
                        Template::load ('account');
                }
        }
        
        private function ajax ($main)
        {
                if (@$_GET[0] == 'server' && @$_GET[1] == 'create' && @$_GET[2] == 'process')
                {
                        $strName = preg_replace ('/[^a-z0-9\-_:\.]/i', '', urldecode (@$_GET['strName']));
                        $tAliases = preg_replace ('/[^a-z0-9_\-\.]/i', '', urldecode (@$_GET['tAliases']));
                        $nType = intval (urldecode (@$_GET['nType']));
                        $strDesc = urldecode (@$_GET['strDesc']);
                        $strKeywords = preg_replace ('/[^a-z0-9\-_:\.]/i', '', urldecode (@$_GET['tKeywords']));
                        
                        $rsp = array (
                                      'status' => true,
                                      'nameInUse' => false,
                                      'tagInUse' => false,
                                      'tag' => null
                                     );
                        
                        if (strlen ($strName) < 3 || strlen ($strName) > 20)
                        {
                                $rsp['status'] = false;
                        }
                        if (strlen ($tAliases) < 1 || strlen ($tAliases) > 83 || substr_count ($tAliases, ',') > 3)
                        {
                                $rsp['status'] = false;
                        }
                        if (!in_array ($nType, array (1, 2)))
                        {
                                $rsp['status'] = false;
                        }
                        if (strlen ($strDesc) < 10 || strlen ($strDesc) > 250)
                        {
                                $rsp['status'] = false;
                        }
                        if (strlen ($strKeywords) < 1 || strlen ($strKeywords) > 50 || substr_count ($strKeywords, ',') > 4)
                        {
                                $rsp['status'] = false;
                        }
                        
                        if ($rsp['status'] === true)
                        {
                                if ($main->database->doQuery ("SELECT * FROM SERVERS WHERE tName = '%s'", $strName))
                                {
                                        $rsp['status'] = false;
                                        $rsp['nameInUse'] = true;
                                }
                                else
                                {
                                        $aliases = explode (',', $tAliases);
                                        $aliases_valid = '';
                                        
                                        foreach ($aliases as $k)
                                        {
                                                if ($main->database->doQuery ("SELECT * FROM SERVERS WHERE tAliases LIKE '%%[%s]%%'", $k))
                                                {
                                                        $rsp['status'] = false;
                                                        $rsp['tagInUse'] = true;
                                                        $rsp['tag'] = $k;
                                                }
                                                else
                                                {
                                                        $k = '[' . $k . ']';
                                                        if (strlen ($aliases_valid) > 1)
                                                                $aliases_valid.= ',';
                                                        $aliases_valid.= $k;
                                                }
                                        }
                                        
                                        if ($rsp['status'] == true)
                                        {
                                                $owner = '[' . $_SESSION['strAccount'] . ']';
                                                $keywords = explode (',', $strKeywords);
                                                $keywords_valid = '';
                                                
                                                foreach ($keywords as $k)
                                                {
                                                        if (strlen ($keywords_valid) > 1)
                                                                $keywords_valid.= ',';
                                                        $keywords_valid.= '[' . $k . ']';
                                                }
                                                
                                                $main->database->doQuery ("INSERT INTO SERVERS (tName, tAliases, tOwners, nType, tDescription, tKeywords) VALUES ('%s', '%s', '%s', %u, '%s', '%s')", $strName, $aliases_valid, $owner, $nType, $strDesc, $keywords_valid);
                                                $main->feeds->addFeed (FEED_T_CREATED_SERVER, $strName);
                                        }
                                }
                        }
                        
                        echo json_encode ($rsp);
                }
        }
}
?>