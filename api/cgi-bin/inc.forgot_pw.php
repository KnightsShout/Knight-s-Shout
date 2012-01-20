<?php
if (!defined ('KS_VALID_KEY') || KS_VALID_KEY !== 'shared_version_on_snoxd')
        die ();

class ForgotPW extends Main
{
        static $cache = 0;
        static $timer = 0;
        static $title = 'title_forgot_pw';
        static $tpl_file = TPL_MAINFILE;
        static $user = null;
        
        function ForgotPW ()
        {
                if (LOGGED_IN)
                {
                        if (!$_GET['use_ajax'])
                                header ('Location: /');
                        exit;
                }
                
                if ($_GET['use_ajax'])
                        self::$tpl_file = 'json';
        }
        
        function doInitPage ($main)
        {
                if ($_GET['use_ajax'] && @$_GET[0] == 'cast')
                {
                        $email = $_POST['account-id'];
                        
                        if (!isValidEMail ($email))
                        {
                                $rsp = array ('result' => 'email');
                                echo json_encode ($rsp);
                                exit;
                        }
                        
                        $c = $main->database->doQuery ("SELECT * FROM MEMBERS WHERE strEMail = '%s'", $email);
                        if (!$c)
                        {
                                $rsp = array ('result' => 'email');
                                echo json_encode ($rsp);
                                exit;
                        }
                        $row = $main->database->doRead ();
                        
                        require_once ('./plugins/inc.recaptchalib.php');
                        $resp = recaptcha_check_answer ($main->conf['reCAPTCHA']['privatekey'], $_SERVER["REMOTE_ADDR"], $_POST["recaptcha_challenge_field"], $_POST["recaptcha_response_field"]);
                        if (!$resp->is_valid)
                        {
                                $rsp = array ('result' => 'captcha');
                                echo json_encode ($rsp);
                                exit;
                        }
                        
                        $key = doMkRString (16) . md5 ($id) . $row['strPasswd'] . doMkRString (16);
                        $main->database->doQuery ("UPDATE MEMBERS SET strFPKey = '%s' WHERE strEMail = '%s'", $key, $email);
                        
                        $title = ___('forgot_pw_email_title');
                        $content = ___('forgot_pw_email', array ($row['strAccountID'], $row['strAccountID'], $key, $row['strAccountID']));
                        mail ($row['strEMail'], $title, $content, "MIME-Version: 1.0\r\nContent-type: text/html; charset=iso-8859-1\r\nFrom: KNIGHT'S SHOUT <noreply@knightsshout.com>");
                        
                        $rsp = array ('result' => 'success');
                        echo json_encode ($rsp);
                }
                elseif (@$_GET[0] == 'recover' && ((isset ($_GET['user']) && isset ($_GET['key']) || $_GET['use_ajax'])))
                {
                        if ($_GET['use_ajax'] && @$_GET[1] == 'cast')
                        {
                                $user = @doMkAccount ($_POST['account-id']);
                                $pw = @doMkPassword ($_POST['account-pw']);
                                $pwc = @doMkPassword ($_POST['account-pw-c']);
                                $key = preg_replace ('/[^a-z0-9]/i', '', $_POST['key']);
                                
                                if (strlen ($user) < 4 || strlen ($user) > 21 || strlen ($key) != 96 || strlen ($pw) < 4 || strlen ($pw) > 35 || $pw != $pwc)
                                        exit;
                                
                                $main->database->doQuery ("UPDATE MEMBERS SET strPasswd = '%s', strFPKey = null WHERE strAccountID = '%s' AND strFPKey = '%s'", $pw, $user, $key);
                                
                                $rsp = array ('result' => 'success');
                                echo json_encode ($rsp);
                        }
                        else
                        {
                                $user = @doMkAccount ($_GET['user']);
                                $key = preg_replace ('/[^a-z0-9]/i', '', $_GET['key']);
                                
                                if (strlen ($user) < 4 || strlen ($key) != 96 || strlen ($user) > 21)
                                {
                                        Template::load ('forgot_pw_recover_fail');
                                }
                                else
                                {
                                        $count = $main->database->doQuery ("SELECT * FROM MEMBERS WHERE strAccountID = '%s' AND strFPKey = '%s'", $user, $key);
                                        if ($count < 1 || $key === null)
                                        {
                                                Template::load ('forgot_pw_recover_fail');
                                        }
                                        else
                                        {
                                                self::$user = $main->database->doRead ();
                                                Template::load ('forgot_pw_recover');
                                        }
                                }
                        }
                }
                else
                {
                        Template::load ('forgot_pw');
                }
        }
}
?>