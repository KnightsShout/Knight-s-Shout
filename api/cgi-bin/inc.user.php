<?php
if (!defined ('KS_VALID_KEY') || KS_VALID_KEY !== 'shared_version_on_snoxd')
        die ();

class pUser extends Main
{
        static $cache = 0;
        static $timer = 0;
        static $title;
        static $tpl_file = TPL_SUBFILE;
        static $account = null;
        static $user = null;
        static $friends = 0;
        private $pipe = null;
        static $fake_url = 0;
        private $main;
        
        function pUser ()
        {
                if (!isset ($_GET[0]))
                {
                        header ('Location: /');
                        return;
                }
                
                self::$account = preg_replace ('/[^a-z0-9\-_:\.]/i', '', $_GET[0]);
                if (strlen (self::$account) < 4)
                {
                        header ('Location: /');
                        return;
                }
                
                if (!LOGGED_IN)
                {
                        header ('Location: /login?continue=' . url_continue () . '&mod=user&id=' . self::$account);
                        exit;
                }
                
                self::$title = array ("title_user", array(self::$account));
                if ($_GET['use_ajax'])
                        self::$tpl_file = 'json';
        }
        
        function doInitPage ($main)
        {
                $this->main = $main;
                
                if ($_GET['use_ajax'])
                {
                        if (@$_GET[1] == 'feed_remove')
                        {
                                $id = intval ($_GET['id']);
                                if ($id < 1)
                                        return;
                                $main->feeds->removeFeed ($id, $_SESSION['strAccount']);
                                echo '<script type="text/javascript">KS.doHidePopup(); location.reload(true);</script>';
                        }
                        return;
                }
                
                $c = $main->database->doQuery ("SELECT * FROM MEMBERS LEFT OUTER JOIN FRIENDSHIPS ON (strAccountID = strRequester AND strAsked = '%s') OR (strAccountID = strAsked AND strRequester = '%s') WHERE strAccountID = '%s'", $_SESSION['strAccount'], $_SESSION['strAccount'], self::$account);
                if (!$c)
                {
                        Template::load ('user_fail');
                        return 0;
                }
                
                if (@isset ($_GET[1]))
                {
                        switch ($_GET[1])
                        {
                                case 'wall':
                                        $this->pipe[0] = 'wall'; break;
                                case 'personality':
                                        $this->pipe[0] = 'personality'; break;
                                default:
                                        $this->pipe[0] = 'game'; break;
                        }
                }
                else
                {
                        self::$fake_url = 1;
                        $this->pipe[0] = 'game';
                }
                
                Template::load ('user');
        }
        
        function in ()
        {
                if ($this->pipe == null)
                        return 0;
                
                switch ($this->pipe[0])
                {
                        case 'wall':
                                $this->pipeWall (); break;
                        case 'personality':
                                $this->pipePersonality (); break;
                        default:
                                $this->pipeGame (); break;
                }
        }
        
        function pipeGame ()
        {
                if (self::$friends == 2 || self::$friends == 4)
                        if ($_GET[1] == 'game')
                                Template::load ('user_game');
                        else
                                $this->pipeWall ();
                else
                        Template::load ('user_game');
        }
        
        function pipePersonality ()
        {
                if (self::$friends == 2 || self::$friends == 4)
                        Template::load ('user_pers');
                else
                        Template::load ('user_no_access');
        }
        
        function pipeWall ()
        {
                if (self::$friends == 2 || self::$friends == 4)
                        Template::load ('user_wall');
                else
                        Template::load ('user_no_access');
        }
}
?>