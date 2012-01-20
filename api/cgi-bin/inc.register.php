<?php
if (!defined ('KS_VALID_KEY') || KS_VALID_KEY !== 'shared_version_on_snoxd')
        die ();

class Registration extends Main
{
        static $cache = 0;
        static $timer = 0;
        static $title = 'title_register';
        static $tpl_file = TPL_MAINFILE;
        
        function Registration () { if (LOGGED_IN) { header ('Location: /home'); exit; } }
        
        function doInitPage ($main)
        {
                if ($_GET['use_ajax'])
                {
                        if ($_GET[0] == 'snd_mail')
                        {
                                $account = @doMkAccount ($_POST['account-id']);
                                $password = @doMkPassword ($_POST['account-pw']);
                                $password_c = @doMkPassword ($_POST['account-pw-c']);
                                $email = @$_POST['account-em'];
                                $email_c = @$_POST['account-em-c'];
                                $secret_q = intval ($_POST['account-secret-q']);
                                $secret_a = @doMkAlpha ($_POST['account-secret-a']);
                                $class_fav = intval ($_POST['account-fav-class']);
                                $servers = @$_POST['account-servers'];
                                
                                if (strlen ($account) < 4 ||
                                    strlen ($account) > 21 ||
                                    $password !== $password_c ||
                                    !isValidEMail ($email) ||
                                    $email !== $email_c ||
                                    strlen ($secret_a) < 4 ||
                                    strlen ($secret_a) > 55)
                                {
                                        //echo "$account\n$password\n$password_c\n$email\n$email_c\n$secret_q\n$secret_a\n$class_fav\n";
                                        return 0;
                                }
                                
                                if (is_array ($servers))
                                {
                                        foreach ($servers as $server)
                                        {
                                                if (!is_array ($server))
                                                        break;
                                                $server_name = $server[0];
                                                $server_char = $server[1];
                                                $server_nati = intval ($server[2]);
                                                $server_clas = intval ($server[3]);
                                                
                                                if (preg_match ('/[^a-z0-9\-_]+/i', $server_name) ||
                                                    preg_match ('/[^a-z0-9\-_:\.=;]+/i', $server_char) ||
                                                    strlen ($server_name) < 4 ||
                                                    strlen ($server_name) > 21 ||
                                                    strlen ($server_char) < 1 ||
                                                    strlen ($server_char) > 35 ||
                                                    !in_array ($server_nati, array (1, 2)) ||
                                                    !in_array ($server_clas, array (1, 2, 3, 4)))
                                                {
                                                        //echo "bleh";
                                                        return 0;
                                                }
                                        }
                                }
                                
                                $json = array (
                                        "account" => $account,
                                        "passwd" => $password,
                                        "email" => $email,
                                        "secret_q" => $secret_q,
                                        "secret_a" => $secret_a,
                                        "class_fav" => $class_fav,
                                        "servers" => $servers
                                );
                                
                                $cnt = json_encode ($json);
                                file_put_contents ('./api/cgi-bin/tmp_register/' . md5 ($account) . '.acc', $cnt);
                                mail ($email, ___('register_mail_title'), ___('register_mail_content', array ((string) $account, (string) md5 ($account), (string) $account)), "MIME-Version: 1.0\r\nContent-type: text/html; charset=iso-8859-1\r\nFrom: KNIGHT'S SHOUT <noreply@knightsshout.com>");
                                
                                echo json_encode (array ("response" => "valid"));
                        }
                        elseif ($_GET[0] == 'chk_usr_mail')
                        {
                                $account = @doMkAccount ($_POST['account']);
                                $email = @$_POST['email'];
                                
                                if (!isValidEMail ($email) || strlen ($account) < 4 || strlen ($email) > 55) return 0;
                                
                                $rsp = array("response" => "valid");
                                
                                if (file_exists ('./api/cgi-bin/tmp_register/' . md5 ($account) . '.acc'))
                                        $rsp["response"] = "error_1";
                                else
                                {
                                        $main->database->doQuery ("SELECT COUNT(*) AS nAmount FROM MEMBERS WHERE strAccountID = '%s';", $account);
                                        $result = $main->database->doRead ();
                                        if (intval ($result["nAmount"]) > 0)
                                                $rsp["response"] = "error_1";
                                        else
                                        {
                                                $main->database->doQuery ("SELECT COUNT(*) AS nAmount FROM MEMBERS WHERE strEMail = '%s';", $email);
                                                $result = $main->database->doRead ();
                                                if (intval ($result["nAmount"]) > 0)
                                                        $rsp["response"] = "error_2";
                                        }
                                }
                                
                                echo json_encode ($rsp);
                        }
                        elseif ($_GET[0] == 'chk_usr_serv')
                        {
                                $account = @doMkAccount ($_POST['account']);
                                $rsp = array("prstate" => "valid", "error_msg" => null);
                                
                                if (empty ($_POST['s1_name'])) return 0;
                                if (strlen ($account) < 4) return 0;
                                
                                for ($n = 1; $n <= 5; $n++)
                                {
                                        @$name = doMkServer ($_POST['s' . $n . '_name']);
                                        @$char = doMkCharacter ($_POST['s' . $n . '_char']);
                                        @$nation = intval ($_POST['s' . $n . '_nation']);
                                        @$class = intval ($_POST['s' . $n . '_class']);
                                        
                                        if (strlen ($name) < 4 ||
                                            strlen ($char) < 1 ||
                                            strlen ($name) > 21 ||
                                            strlen ($char) > 35)
                                                break;
                                        
                                        @$main->database->doQuery ("SELECT COUNT(*) AS nAmount FROM MEMBERS_SERVERS WHERE strServerID = '%s' AND strCharID = '%s';", (string) $name, (string) $char);
                                        $result = $main->database->doRead ();
                                        if (intval ($result["nAmount"]) > 0)
                                        {
                                                $rsp = array("prstate" => "invalid", "error_msg" => __('register_server_combin_taken', array ((string) $char), (string) $name));
                                                break;
                                        }
                                }
                                
                                echo json_encode ($rsp);
                        }
                }
                elseif (@$_GET[0] == 'validate')
                {
                        $key = doMkAlpha (@$_GET['key']);
                        
                        if (!file_exists ('./api/cgi-bin/tmp_register/' . $key . '.acc'))
                        {
                                Template::load ('register_validate_failure');
                                return;
                        }
                        
                        $cnt_json = file_get_contents ('./api/cgi-bin/tmp_register/' . $key . '.acc');
                        $acc = json_decode ($cnt_json, true);
                        $servers = $acc['servers'];
                        
                        $main->database->doQuery ("INSERT INTO MEMBERS (strAccountID, strPasswd, strEMail, nSecretQuestion, strSecretAnswer, strClientIP, nJoined, nLastSeen, nFavoriteClass) VALUES ('%s', '%s', '%s', %u, '%s', '%s', %u, %u, %u);", $acc['account'], $acc['passwd'], $acc['email'], $acc['secret_q'], $acc['secret_a'], $_SERVER['REMOTE_ADDR'], time (), time (), $acc['class_fav']);
                        if (is_array ($servers))
                        {
                                foreach ($servers as $no => $server)
                                        $main->database->doQuery ("INSERT INTO MEMBERS_SERVERS (strAccountID, strServerID, strCharID, nCharNation, nCharClass) VALUES ('%s', '%s', '%s', %u, %u);", $acc['account'], $server[0], $server[1], $server[2], $server[3]);
                        }
                        
                        unlink ('./api/cgi-bin/tmp_register/' . $key . '.acc');
                        
                        $main->feeds->addFeed (FEED_T_JOINED, null, $acc['account'], null, null);
                        $main->notifications->addNotification (NOTIFICATION_T_WELCOME, null, $acc['account']);
                        
                        Template::load ('register_validate_success');
                }
                else
                {
                        Template::load ($main->conf['account']['register'] ? 'register' : 'register_disabled');
                }
        }
}
?>