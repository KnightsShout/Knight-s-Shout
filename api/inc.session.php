<?php
/**
 * @todo add a cookie recognizion system. note said security issues about session hi-jacking that'll be caused by the cookie system if not implemented properly.
 */

if (!defined ('KS_VALID_KEY') || KS_VALID_KEY !== 'shared_version_on_snoxd')
        die ();

class Session extends Main
{
        public $status = 0;
        public $ip = 0;
        
        function doInit ()
        {
                session_save_path ('./api/cgi-bin/tmp_sessions/');
                $this->getIp ();
                $this->doStartSession ();
                $this->doCheckCookies ();
                #$this->COMET ();
                $this->doCheckLogin ();
        }
        
        function getIp ()
        {
                $this->ip = !empty ($_SERVER['HTTP_X_FORWARDED_FOR' ]) ? $_SERVER['HTTP_X_FORWARDED_FOR'] : $_SERVER['REMOTE_ADDR'];
        }
        
        function doStartSession ()
        {
                session_set_cookie_params ($this->conf['session']['lifetime'], $this->conf['session']['path'], $this->conf['session']['domain'], $this->conf['session']['secure'], $this->conf['session']['httpd_only']);
                session_start ();
        }
        
        function doCheckCookies ()
        {
                if (!isset ($_COOKIE['ks_data']))
                {
                        $this->doSendCookies ();
                }
        }
        
        function doSendCookies ()
        {
                setcookie ('ks_data', $this->encryptSession (session_id ()), $this->conf['session']['lifetime'], $this->conf['session']['path'], $this->conf['session']['domain'], $this->conf['session']['secure'], $this->conf['session']['httpd_only']);
        }
        
        function encryptSession ($id)
        {
                return base64_encode (doMkRString (4) . session_id () . doMkRString (4));
        }
        
        function decryptSession ($id)
        {
                return substr (base64_decode ($id), 4, 32);
        }
        
        /**
         * @deprecated
         */
        function COMET ()
        {
                if (isset ($_SESSION['COMET_is_initialized']))
                {
                        if ($_SESSION['COMET_is_initialized'] == true)
                        {
                                if (@$_GET['_comet'] == 1)
                                {
                                        if (session_id () != $_SESSION['COMET_sess_id'])
                                        {
                                                $this->COMET_enable ();
                                        }
                                }
                                else
                                {
                                        if (session_id () == $_SESSION['COMET_sess_id'])
                                        {
                                                $this->COMET_disable ();
                                        }
                                }
                        }
                        else
                        {
                                $this->COMET_init ();
                        }
                }
                else
                {
                        $this->COMET_init ();
                }
        }
        
        /**
         * @deprecated
         */
        function COMET_init ()
        {
                $_SESSION['COMET_is_initialized'] = true;
                $_SESSION['COMET_sess_id'] = session_id ();
                $_session_comet = $_SESSION;
                session_regenerate_id ();
                $_SESSION = $_session_comet;
                $_SESSION['COMET_sess_back'] = session_id ();
        }
        
        /**
         * @deprecated
         */
        function COMET_enable ()
        {
                $_session_norm = $_SESSION;
                session_id ($_session_norm['COMET_sess_id']);
                $_SESSION = $_session_norm;
        }
        
        /**
         * @deprecated
         */
        function COMET_disable ()
        {
                $_session_comet = $_SESSION;
                session_id ($_session_comet['COMET_sess_back']);
                $_SESSION = $_session_comet;
        }
        
        function doRestartSession ($recover_full = 0)
        {
                @$log = $_SESSION['bLoggedIn'];
                @$acc = $_SESSION['strAccount'];
                @$pw = $_SESSION['strPasswd'];
                @$ip = $_SESSION['strClientIp'];
                @$auth = $_SESSION['nAuth'];
                $lang = $_SESSION['strLang'];
                session_destroy ();
                $this->doStartSession ();
                session_regenerate_id (1);
                $_SESSION['strLang'] = $lang;
                if ($recover_full)
                {
                        if ($log)
                        {
                                $_SESSION['bLoggedIn'] = $log;
                                $_SESSION['strAccount'] = $acc;
                                $_SESSION['strPasswd'] = $pw;
                                $_SESSION['strClientIp'] = $ip;
                                $_SESSION['nAuth'] = $auth;
                        }
                }
        }
        
        function doCheckLogin ()
        {
                if (isset ($_SESSION['bLoggedIn']) && isset ($_SESSION['strAccount']) && isset ($_SESSION['strPasswd']) && isset ($_SESSION['strClientIp']) && isset ($_SESSION['nAuth']))
                {
                        $this->status = intval ($_SESSION['nAuth']) == 2 ? 2 : 1;
                        if ($this->ip !== $_SESSION['strClientIp'])
                        {
                                $this->status = 0;
                                session_destroy ();
                                setcookie ('ks_data');
                                header ('Location: ' . $_SERVER['REQUEST_URI']);
                                #$this->doRestartSession ();
                        }
                        elseif (!isset ($_COOKIE['ks_data']))
                        {
                                $this->doSendCookies ();
                        }
                }
                elseif (isset ($_COOKIE['ks_data']))
                {
                        
                }
        }
}
?>