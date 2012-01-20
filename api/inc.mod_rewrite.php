<?php
/**
 * @todo Test for abuses/bugs?
 * @todo FCGI: use PATH_INFO and rewrite this.
 *
 * @deprecated split() is now deprecated!
 */

if (!defined ('KS_VALID_KEY') || KS_VALID_KEY !== 'shared_version_on_snoxd')
        die ();

class Rewrite extends Main
{
        /**
         * @deprecated
         *
         * NOTE:
         *  THE ENTIRE $_GET VARIABLE AS PASSED BY HTML (knightsshout.com/home.php?somevar=someval) IS REPLACED.
         *  HENCE MAKE USE OF THE URI_REWRITE SYSTEM.
         * 
         * UPDATED AS OF 18TH APRIL '11
         * THE CURRENT URI PATTERNS ARE AS FOLLOWS:
         *  /$page.php/$params
         *      $params may be split by as many / as you wish. every / declares a new stack in the $_GET array
         *  /$page.php
         *      for calling a page w/o any params.
         *  /ajax/$page.php/$params
         *      again, $params may be split by as many / as you wish. see above ^.
         *  /ajax/$page.php
         *      for calling a single ajax page w/o $_GETs
         * YOU CAN ADD FURTHER PATTERNS BY EXTENDING THE $uri_patterns ARRAY!
         * DON'T FORGET TO DOCUMENT THEM AS ABOVE ^, IF YOU ADD ONE!
         */
        
        /*
        public $uri_patterns = array (
                //'regular_expression' => 'replace_mode'
                'ajax\/(.+)\.php\/?(([^\/]+)\/?)*\/?' => 'i',
                '(.+)\.php\/?(([^\/]+)\/?)*' => 'i'
        );
        */
        public $uri_modules = array (
                'ajax' => 'use_ajax'#,
                #'xml' => 'use_xml'
        );
        public $act;
        public $act_clean;
        #public $params = array ();
        
        function Rewrite ($conf)
        {
                $true = false;
                /**
                 * prepare for implementation of $_GETs
                 */
                $uri = preg_match ('/\?/', $_SERVER['REQUEST_URI'], &$true) ? substr ($_SERVER['REQUEST_URI'], 0, strpos ($_SERVER['REQUEST_URI'], '?')) : $_SERVER['REQUEST_URI'];
                /**
                 * @deprecated
                 * 
                 * clear the $_GET global var, so we can make use of it
                 * for our own stuff. no need to use ?s after all,
                 * we got our own rewriting anyways.
                 */
                #$_GET = array ();
                $_GET = explode ('/', $uri);
                array_shift ($_GET);
                
                /**
                 * implement $_GET
                 */
                if ($true !== false && !empty ($true[0]))
                {
                        $str = '&' . substr ($_SERVER['REQUEST_URI'], (strpos ($_SERVER['REQUEST_URI'], '?') + 1));
                        $arr = @split ('&', $str);
                        array_shift ($arr);
                        foreach ($arr as $arg)
                        {
                                $para = @split ('=', $arg);
                                if ($para[0] != '0')
                                        $_GET[$para[0]] = $para[1];
                        }
                        /**
                         * debugging
                         */
                        #print_r ($arr);
                        /**
                         * ^ uncomment to debug
                         */
                }
                
                foreach ($this->uri_modules as $module => $term)
                {
                        $_GET[$term] = !empty ($_GET[0]) ? ($_GET[0] === $module ? 1 : 0) : 0;
                        if ($_GET[$term])
                                array_shift ($_GET);
                }
                
                if (array_key_exists (@$_GET[0], $conf['pages']))
                {
                        $this->act_clean = $_GET[0];
                        $this->act = $conf['pages'][$_GET[0]];
                        array_shift ($_GET);
                }
                else
                {
                        if (file_exists ('./api/cgi-bin/inc.' . preg_replace ('/[^a-z0-9\_\-]/i', '', $_GET[0]) . '.php') && file_exists ('./api/cgi-bin/ini/inc.' . preg_replace ('/[^a-z0-9\_\-]/i', '', $_GET[0]) . '.php'))
                        {
                                $this->act_clean = preg_replace ('/[^a-z0-9\_\-]/i', '', $_GET[0]);
                                $this->act = './api/cgi-bin/inc.' . $this->act_clean . '.php';
                                array_shift ($_GET);
                        }
                        else
                        {
                                $this->act_clean = array_search (reset ($conf['pages']), $conf['pages']);
                                $this->act = reset ($conf['pages']);
                        }
                }
                
                /**
                 * debugging
                 */
                #print_r ($_GET);
                /**
                 * ^ uncomment to debug.
                 */
                
                /**
                 * @deprecated
                foreach ($this->uri_patterns as $pattern => $mode)
                        if (preg_match ('/\\b' . $pattern . '$\\b/' . $mode, $uri, $match))
                                break;
                @array_shift ($match);
                $this->act_clean = @$match[0];
                $this->act = array_key_exists (@$match[0], $conf['pages']) ? $conf['pages'][$match[0]] : reset ($conf['pages']);
                @array_shift ($match);
                $_GET = $this->params = $match;
                */
                
                /**
                 * Check for Modules
                 */
                /*
                $mod = substr ($_SERVER['REQUEST_URI'], 1, strpos (substr ($_SERVER['REQUEST_URI'], 1), '/'));
                foreach ($this->uri_modules as $module => $term)
                        $this->params[$term] = $_GET[$term] = $module === $mod ? 1 : 0;
                */
                /**
                 * if you experience any problems with the
                 * url_rewriting and aren't quite sure what to do,
                 * a good idea would be to parse the eval'd params
                 */
                #print_r ($this->params);
                /**
                 * by uncommenting the ^ above line.
                 * or just catch me up on msn. ;o
                 */
        }
}
?>