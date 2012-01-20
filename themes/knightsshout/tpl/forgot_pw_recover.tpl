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
        <script type="text/javascript">
        function submit()
        {
                var strPasswd = document.getElementById("account-pw").value;
                var strPasswdc = document.getElementById("account-pw-c").value;
                
                if (strPasswd.length < 4)
                        return KS.doError ('#fp-callback', "<?php __('register_pass_too_short'); ?>");
                if (!strPasswd.match (/^[a-zA-Z0-9]+$/))
                        return KS.doError ('#fp-callback', "<?php __('register_pass_invalid'); ?>");
                if (strPasswd !== strPasswdc)
                        return KS.doError ('#fp-callback', "<?php __('register_pass_mismatch'); ?>");
                
                var info = $("#fp-form").serialize();
                KS.doLoad ('#fp-callback');
                        
                $.ajax({
                        url: '/ajax/forgot_pw/recover/cast',
                        type: "post",
                        data: info,
                        dataType: "json",
                        success:
                                function(rsp)
                                {
                                        if (rsp.result == "success")
                                        {
                                                $("#fp-button").attr('href', 'javascript:;');
                                                KS.doSuccess ('#fp-callback', "<?php __('forgot_pw_recover_success'); ?>");
                                        }
                                },
                        failure:
                                function(error)
                                {
                                        return KS.doError ('#fp-callback', error);
                                }
                });
        }
        </script>
        <div style="width:1000px;" id="forgot-pw-section" align="center">
                <form action="/forgot_pw/recover" method="post" id="fp-form">
                        <input type="hidden" name="account-id" value="<?php echo ForgotPW::$user['strAccountID']; ?>" />
                        <input type="hidden" name="key" value="<?php echo ForgotPW::$user['strFPKey']; ?>" />
                        <table cellpadding="0" cellspacing="0" align="center">
                                <tr>
                                        <th width="200px"></th>
                                        <th width="200px"></th>
                                        <th width="100px"></th>
                                        <th width="200px"></th>
                                        <th width="100px"></th>
                                        <th width="200px"></th>
                                </tr>
                                <tr>
                                        <td colspan="6" align="center">
                                                <h1><?php __('forgot_pw_recover_header'); ?></h1>
                                        </td>
                                </tr>
                                <tr>
                                        <td colspan="6" align="center">
                                                <?php __('forgot_pw_recover_expl'); ?>
                                                <div class="spacer"></div>
                                        </td>
                                </tr>
                                <tr>
                                        <td colspan="6" align="center" id="fp-callback">
                                                
                                        </td>
                                </tr>
                                <tr>
                                        <td colspan="6" class="spacer"></td>
                                </tr>
                                <tr>
                                        <td></td>
                                        <td align="center">
                                                <b><?php __('account_pw_new'); ?></b>
                                        </td>
                                        <td align="center">
                                                <input type="password" id="account-pw" name="account-pw" maxlength="35" />
                                        </td>
                                        <td align="center">
                                                <b><?php __('account_pw_c'); ?></b>
                                        </td>
                                        <td align="center">
                                                <input type="password" id="account-pw-c" name="account-pw-c" maxlength="35" />
                                        </td>
                                        <td></td>
                                </tr>
                                <tr>
                                        <td colspan="6" class="spacer"></td>
                                </tr>
                                <tr>
                                        <td colspan="6" align="center">
                                                <a href="javascript:submit();" id="fp-button"><div class="button-special-proceed" style="width: 80px;" id="reg-button-step2"><?php __('glob_proceed'); ?></div></a>
                                        </td>
                                </tr>
                        </table>
                </form>
        </div>
        <div class="spacer"></div>
</div>