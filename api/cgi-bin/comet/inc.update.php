<?php
if (!defined ('KS_VALID_KEY') || KS_VALID_KEY !== 'shared_version_on_snoxd')
        die ();

class pComet extends COMET implements _COMET
{
        public $comet;
        public $delay = 1;
        
        function pComet ($comet)
        {
                $this->comet = $comet;
        }
        
        function _action ()
        {
                if (!parent::_check ())
                        return true;
                
                Template::load ('comet/update');
                return true;
                #return false;
        }
}
?>