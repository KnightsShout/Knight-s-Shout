<?php
global $main;
?>
<div align="center" class="ppheadline"><?php __('title_translate-info'); ?></div>
<div align="left" class="ppcontent">
        <?php __('translateinfo_expl'); ?><br />
        <div class="spacer"></div>
        <div align="center">
                <a href='javascript:;' id="lngfllw">&rarr; <?php __('translateinfo_follow'); ?></a><br />
                -<br />
                <script type="text/javascript">
                function __g_ov(){
                        var attr = new Array(0, null, '/ajax/translate?overview=1', null);
                        KS.doPopup(attr);
                        /*
                        Popupify.doPopup({type: Popupify.as_ajax, ajax: {
                                url: '/ajax/translate',
                                method: 'GET',
                                data: 'overview=1',
                                success: function(rsp){
                                        Popupify.doPopup({type: Popupify.as_html, html: rsp});
                                }
                        }});
                        */
                }
                </script>
                <a href='javascript:;' id="lngback" onclick="__g_ov();">&larr; <?php __('glob_cancel'); ?></a>
        </div>
</div>