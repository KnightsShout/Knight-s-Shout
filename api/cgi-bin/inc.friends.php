<?php
if (!defined ('KS_VALID_KEY') || KS_VALID_KEY !== 'shared_version_on_snoxd')
        die ();

class Friends extends Main
{
        static $cache = 0;
        static $timer = 0;
        static $title;
        static $tpl_file = TPL_SUBFILE;
        
        function Friends ($main)
        {
                if ($_GET['use_ajax'])
                {
                        $this->ajax ($main);
                }
        }
        
        function doInitPage ($main)
        {
                
        }
        
        function ajax ($m)
        {
                self::$tpl_file = 'json';
                
                if (!$m->isSecure ())
                {
                        header ('Location: /home?_re=invalid_secure_key');
                        exit;
                }
                
                if (!isset ($_POST['a']))
                {
                        header ('Location: /home?_re=friends_1');
                        exit;
                }
                
                if ($_POST['a'] == 'request')
                {
                        if (!isset ($_POST['target']) || !isset ($_POST['redirect']))
                        {
                                header ('Location: /home?_re=friends_2');
                                exit;
                        }
                        $target = doMkAccount ($_POST['target']);
                        $redirect = url_make_suitable_dec ($_POST['redirect']);
                        if ($target == $_SESSION['strAccount'])
                        {
                                header ('Location: /home?_re=friends_3');
                                exit;
                        }
                        if ($m->database->doQuery ("SELECT * FROM MEMBERS WHERE strAccountID = '%s'", $target))
                        {
                                $user = $m->database->doRead ();
                                if ($m->database->doQuery ("SELECT * FROM FRIENDSHIPS WHERE (strRequester = '%s' AND strAsked = '%s') OR (strRequester = '%s' AND strAsked = '%s')", $_SESSION['strAccount'], $target, $target, $_SESSION['strAccount']))
                                {
                                        header ('Location: /home?_re=friends_4');
                                        exit;
                                }
                                $m->database->doQuery ("INSERT INTO FRIENDSHIPS (nDate, nStatus, strRequester, strAsked) VALUES (%u, %u, '%s', '%s')", time (), 1, $_SESSION['strAccount'], $user['strAccountID']);
                                header ('Location: ' . $redirect);
                        }
                        else
                        {
                                header ('Location: /home?_re=friends_5');
                                exit;
                        }
                }
                elseif ($_POST['a'] == 'confirm')
                {
                        if (!isset ($_POST['target']) || !isset ($_POST['redirect']))
                        {
                                header ('Location: /home?_re=friends_6');
                                exit;
                        }
                        $target = doMkAccount ($_POST['target']);
                        $redirect = url_make_suitable_dec ($_POST['redirect']);
                        if ($target == $_SESSION['strAccount'])
                        {
                                header ('Location: /home?_re=friends_7');
                                exit;
                        }
                        
                        $m->database->doQuery ("UPDATE FRIENDSHIPS SET nStatus = 2 WHERE strRequester = '%s' AND strAsked = '%s' AND nStatus = 1", $target, $_SESSION['strAccount']);
                        $m->feeds->addFeed (FEED_T_FRIEND_REQUEST, $_SESSION['strAccount'] . ',' . $target, $_SESSION['strAccount'], null, null);
                        $m->feeds->addFeed (FEED_T_FRIEND_REQUEST, $target . ',' . $_SESSION['strAccount'], $target, null, null);
                        $m->notifications->addNotification (NOTIFICATION_T_MADE_FRIENDS, $_SESSION['strAccount'] . "," . $_SESSION['strAvatar'] . "," . time (), $target);
                        if ($redirect != 'simple_ajax_request')
                                header ('Location: ' . $redirect);
                        exit;
                }
                elseif ($_POST['a'] == 'decline')
                {
                        if (!isset ($_POST['target']) || !isset ($_POST['redirect']))
                        {
                                header ('Location: /home?_re=friends_10');
                                exit;
                        }
                        $target = doMkAccount ($_POST['target']);
                        $redirect = url_make_suitable_dec ($_POST['redirect']);
                        if ($target == $_SESSION['strAccount'])
                        {
                                header ('Location: /home?_re=friends_11');
                                exit;
                        }
                        
                        $m->database->doQuery ("DELETE FROM FRIENDSHIPS WHERE strRequester = '%s' AND strAsked = '%s' AND nStatus = 1", $target, $_SESSION['strAccount']);
                        header ('Location: ' . $redirect);
                }
                elseif ($_POST['a'] == 'disband')
                {
                        if (!isset ($_POST['target']) || !isset ($_POST['redirect']))
                        {
                                header ('Location: /home?_re=friends_8');
                                exit;
                        }
                        $target = doMkAccount ($_POST['target']);
                        $redirect = url_make_suitable_dec ($_POST['redirect']);
                        if ($target == $_SESSION['strAccount'])
                        {
                                header ('Location: /home?_re=friends_9');
                                exit;
                        }
                        
                        $m->database->doQuery ("DELETE FROM FRIENDSHIPS WHERE (strRequester = '%s' AND strAsked = '%s') OR (strRequester = '%s' AND strAsked = '%s')", $target, $_SESSION['strAccount'], $_SESSION['strAccount'], $target);
                        $m->feeds->_removeFeed (NOTIFICATION_T_MADE_FRIENDS, $_SESSION['strAccount'] . "," . $target, $_SESSION['strAccount'], null, null);
                        $m->feeds->_removeFeed (NOTIFICATION_T_MADE_FRIENDS, $target . "," . $_SESSION['strAccount'], $target, null, null);
                        header ('Location: '. $redirect);
                        exit;
                }
        }
}
?>