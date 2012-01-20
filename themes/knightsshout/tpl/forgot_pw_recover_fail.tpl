<script type="text/javascript">
$().ready(function(){
        $("#main").prepend('<div align="center">').append('</div>');
        $("#main").css({'margin-top': '4px'});
        $("#main").css({'width': KS.browser.width});
        $("#main").css({'background': '#fff'});
        $(window).resize(function(){
                $("#main").css({'width': KS.browser.width});
        });
});
</script>
<div align="center">
        <div class="spacer"></div>
        <div style="width:1000px;" id="fp-callback" align="center">
                
        </div>
        <div class="spacer"></div>
        <script type="text/javascript">
        $().ready(function(){
                KS.doError ('#fp-callback', "<?php __('forgot_pw_fail'); ?>");
        });
        </script>
</div>