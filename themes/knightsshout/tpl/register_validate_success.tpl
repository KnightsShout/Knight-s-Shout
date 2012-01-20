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
<div id="container-validation" align="left">
        <div valign="middle" style="padding-left: 100px;">
                <div style="height: 107px;"></div>
                <h1><?php __('register_validate_success'); ?></h1>
                <h2><?php __('register_validate_welcome'); ?></h2>
        </div>
</div>