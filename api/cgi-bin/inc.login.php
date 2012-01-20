<?php
if (!defined ('KS_VALID_KEY') || KS_VALID_KEY !== 'shared_version_on_snoxd')
        die ();

class Login extends Main
{
        static $cache = 0;
        static $timer = 0;
        static $title = 'title_login';
        static $tpl_file = 'json';
        static $continue = null;
        
        function Login ()
        {
                if (LOGGED_IN && !isset ($_GET['continue']))
                {
                        header ('Location: /home');
                        exit;
                }
                if (LOGGED_IN && isset ($_GET['continue']))
                {
                        header ('Location: ' . url_make_suitable_dec ($_GET['continue']));
                        exit;
                }
                self::$tpl_file = $_GET['use_ajax'] ? 'json' : TPL_SUBFILE;
        }
        
        function doInitPage ($main)
        {
                if (!$_GET['use_ajax'])
                {
                        self::$continue = isset ($_GET['continue']) ? url_make_suitable_dec ($_GET['continue']) : 'http://' . $_SERVER['SERVER_NAME'];
                        Template::load ('login');
                }
                else
                {
                        $account = doMkAccount ($_POST['account-id-l']);
                        $password = doMkPassword ($_POST['account-pw-l']);
                        $response = array ("response" => "fail");
                        
                        $main->database->doQuery ("SELECT COUNT(*) AS nAmount, nAuthority, strAvatar, strAccountID FROM MEMBERS WHERE strAccountID = '%s' AND strPasswd = '%s';", $account, $password);
                        $result = $main->database->doRead ();
                        if (intval ($result['nAmount']) > 0)
                                $response['response'] = 'success';
                        else
                        {
                                if (!isValidEMail ($_POST['account-id-l']))
                                        $response['response'] = 'fail';
                                else
                                {
                                        $main->database->doQuery ("SELECT COUNT(*) AS nAmount, nAuthority, strAccountID, strAvatar FROM MEMBERS WHERE strEMail = '%s' AND strPasswd = '%s';", $_POST['account-id-l'], $password);
                                        $result = $main->database->doRead ();
                                        if (intval ($result['nAmount']) > 0)
                                                $response['response'] = 'success';
                                        $account = $result['strAccountID'];
                                }
                        }
                        
                        if ($response['response'] == 'success')
                        {
                                $_SESSION['bLoggedIn'] = 1;
                                $_SESSION['strAccount'] = $result['strAccountID'];
                                $_SESSION['strPasswd'] = $password;
                                $_SESSION['strClientIp'] = $main->session->ip;
                                $_SESSION['nAuth'] = $result['nAuthority'];
                                $base = '/resources/user-content/';
                                if (file_exists ('.' . $base . $result['strAvatar']) && strlen ($result['strAvatar']) > 2)
                                        $base.= $result['strAvatar'];
                                else
                                        $base.= 'default.png';
                                $_SESSION['strAvatar'] = $base;
                        }
                        
                        echo json_encode ($response);
                }
        }
}
?>