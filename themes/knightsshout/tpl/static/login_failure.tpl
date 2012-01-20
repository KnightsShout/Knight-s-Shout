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
<div style="width:1000px;" align="center">
<div class="spacer"></div>
<div id="404-callback"></div>
<div class="spacer"></div>
<script type="text/javascript">
KS.doError('#404-callback', "<?php __('login_failure'); ?>");
</script>
</div>
</div>