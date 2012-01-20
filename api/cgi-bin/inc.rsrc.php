<?php
if (!defined ('KS_VALID_KEY') || KS_VALID_KEY !== 'shared_version_on_snoxd')
        die ();

class RSRC extends Main
{
        static $cache = 0;
        static $timer = 0;
        static $title = '';
        static $tpl_file = 'json';
        private $format = null;
        private $file = null;
        
        function RSRC (){}
        
        function doInitPage ($main)
        {
                $this->file = !empty ($_GET[0]) ? preg_replace ('/[^a-z0-9\._\-]/i', '', $_GET[0]) : null;
                $file = substr ($this->file, 0, strrpos ($this->file, '.'));
                $format = substr ($this->file, strrpos ($this->file, '.'));
                list ($this->format, $this->file) = array ($format, $file);
                
                if ($this->format !== null && $this->file !== null)
                {
                        $expires = 60 * 60 * 24 * 2;
                        
                        header ('Content-type: ' . ($this->format == 'js' ? 'text/javascript' : 'text/css'));
                        header ('Pragma: public');
                        header ('Cache-control: maxage=' . $expires);
                        header ('Expires: ' . gmdate ('D, d M Y H:i:s', time () + $expires) . ' GMT');
                        
                        include ('./resources/release/' . substr ($this->format, 1) . '/'. $this->file . '.' . substr ($this->format, 1));
                }
        }
}
?>