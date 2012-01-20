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
<table cellpadding="0" cellspacing="0" align="center" valign="top">
                                                <tr>
                                                        <td style="width: 500px;" align="center">
                                                                <img src="<?php t(); ?>img/logout.jpg" alt="" />
                                                        </td>
                                                        <td style="width: 500px;" align="center" valign="top">
                                                                <div style="height: 114px;"></div>
                                                                <h1><?php __('farewell'); ?></h1>
                                                                <!--<div class="parter"></div>-->
                                                                <div align="left" id="intro">
                                                                        <h2><?php __('farewell_expl'); ?></h2>
                                                                </div>
                                                        </td>
                                                </tr>
                                        </table>
<div class="spacer"></div>
</div>
</div>