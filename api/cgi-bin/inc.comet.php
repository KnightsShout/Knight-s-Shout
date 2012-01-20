<?php
if (!defined ('KS_VALID_KEY') || KS_VALID_KEY !== 'shared_version_on_snoxd')
        die ();

interface _COMET
{
        public function _action();
}

class COMET
{
        static $cache = 0;
        static $timer = 0;
        static $title = '';
        static $tpl_file = 'json';
        private $main;
        
        function COMET ($mode = 'ajax', $main)
        {
                if (!$_GET['use_ajax'] && $mode == 'ajax') header ('Location: /');
                
                define ('COMET_TIMEOUT', 1);
                $this->main = $main;
        }
        
        function doInitPage ($main)
        {
                @$a = isset ($_GET['a']) ? $_GET['a'] : 'die';
                
                switch ($a)
                {
                        case 'get_updates':
                                require_once ('./api/cgi-bin/comet/inc.update.php');
                                $this->_comet (1);
                                break;
                        default:
                                break;
                }
        }
        
        function _comet ($func = null)
        {
                if ($func === null)
                        return false;
                if (!class_exists ('pComet', false))
                        return false;
                
                $s = time ();
                $f = new pComet ($this);
                
                while (($s + COMET_TIMEOUT) >= time ())
                {
                        $this->main->session->COMET_enable ();
                        if ($f->_action ())
                                break;
                        $this->main->session->COMET_disable ();
                        sleep ($f->delay);
                }
        }
        
        static function _check ()
        {
                if (!LOGGED_IN)
                {
                        Template::load ('comet/_authenticate');
                        return false;
                }
                return true;
        }
}
?>