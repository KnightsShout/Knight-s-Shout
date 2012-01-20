<?php
if (!defined ('KS_VALID_KEY') || KS_VALID_KEY !== 'shared_version_on_snoxd')
        die ();

class JsPipe extends Main
{
        private $pipe = '';
        private $main;
        
        function JsPipe ($main)
        {
                $this->main = $main;
                
                define ('FLUSH_ECHO', 1);
                define ('FLUSH_RETURN', 2);
                
                define ('FLUSH_FULL', 1);
                define ('FLUSH_MERE', 2);
                
                define ('JSPIPE_START', '<script type="text/javascript">');
                define ('JSPIPE_END', '</script>');
        }
        
        function flush ($mode = FLUSH_ECHO, $flush = FLUSH_FULL)
        {
                if ($mode == FLUSH_ECHO)
                        echo JSPIPE_START . $this->pipe . JSPIPE_END;
                return $this->pipe = $flush == FLUSH_FULL ? '' : $this->pipe;
        }
        
        function jsify ($string, $options = array(0 => 1, 1 => null))
        {
                if (is_array ($options))
                        if (sizeof ($options) < 2)
                                return 0;
                $string = trim (str_replace (array ("\r\n", "\n", "  ", "/"), array ('', '', '', '\/'), addslashes ($string)));
                $this->pipe.= $js = " KS.addPipe('$string', {'anim': " . (@$options[0]) . ", 'target': '" . (@$options[1]) . "'}); ";
                return $js;
        }
        
        function clear ()
        {
                $this->pipe = '';
        }
        
        function JsPipeRTInit ()
        {
                if (method_exists ($this->main->template->page, 'doAddPipe'))
                        $this->main->template->page->doAddPipe ();
                return;
        }
        
        function set ($string)
        {
                $this->pipe = $string;
        }
}
?>