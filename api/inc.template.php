<?php
/**
 * [ ] @todo implement more languages.
 * [x] @todo function doLoadLang ()
 * [-] @todo Write a cacher for function doBuildPage that considers $_REQUESTs.
 *      -> no need anymore, we'll use MEM_CACHED if at all. casual caching is way too inefficient.
 */

if (!defined ('KS_VALID_KEY') || KS_VALID_KEY !== 'shared_version_on_snoxd')
        die ();

class Template extends Main
{
        public $lang = 'en'; #default lang
        public $vars_l = array ();
        public $langs = array ();
        public $langx = array ();
        public $langs_available = array();
        static $tpl_file = null;
        static $title = null;
        
        function Template ($m)
        {
                $this->m = $m;
                include ('./api/lang/inc.' . $this->lang . '.php');
                $this->langs_available = $m->conf['translation']['languages'];
                $this->vars_l = array_merge ($this->vars_l, $langvars);
                unset ($langvars);
                $lang = $this->lang;
                $this->doLoadLang ();
                if ($lang !== $this->lang)
                {
                        if (file_exists ('./api/lang/inc.' . $this->lang . '.php'))
                        {
                                include ('./api/lang/inc.' . $this->lang . '.php');
                                $this->vars_l = array_merge ($this->vars_l, $langvars);
                                unset ($langvars);
                        }
                        else
                        {
                                $this->lang = $_SESSION['strLang'] = 'en';
                        }
                }
        }
        
        function doStartOutput ($m)
        {
                #from now on ob is started in the index
                #ob_start ();
                include ($m->rewrite->act);
                #pages will from now on be initialized from
                #ini subpages due to several sweet
                #new features being available by that.
                #deprecated: $this->page = new Page ($m);
                include ('./api/cgi-bin/ini/inc.' . $m->rewrite->act_clean . '.php');
                
                if ($_GET['use_ajax'])
                        $this->doBuildPage ();
                else
                        self::load (self::$tpl_file);
        }
        
        function doLoadLang ()
        {
                require_once ('./plugins/inc.php_language_detection.php');
                $this->langs = languages ();
                $this->langx = get_languages ('data');
                if (isset ($_SESSION['strLang']))
                        return $this->lang = $_SESSION['strLang'];
                $this->lang = $_SESSION['strLang'] = !empty ($this->langx[0][1]) ? $this->langx[0][1] : 'en';
        }
        
        static function load ($file)
        {
                $file = PTPL . 'tpl/' . $file . '.tpl';
                if (!file_exists ($file)) return 0;
                /**
                 * fiddly. why the hell did we eval() this?
                 *
                $content = file_get_contents ($file);
                eval ('global $main; ?>' . $content);
                 */
                global $main;
                include ($file);
        }
        
        static function _load_static ($file, $rpl = null)
        {
                $file = PTPL . 'tpl/static_html/' . $file . '.tpl';
                if (!file_exists ($file)) return 0;
                
                $cnt = file_get_contents ($file);
                if (!is_array ($rpl))
                        foreach ($rpl as $k => $v)
                                $cnt = str_ireplace ($k, $v, $cnt);
                
                return $cnt;
        }
        
        function doBuildPage ()
        {
                /**
                 * @todo cacher goes here.
                 */
                $this->page->doInitPage ($this->m);
        }
}
?>