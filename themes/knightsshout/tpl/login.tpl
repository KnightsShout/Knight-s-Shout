<div style="padding-left: 12px; padding-right: 12px;" align="left">
        <div class="spacer"></div>
        <h1><?php __('login'); ?></h1>
        <div id="ctr" style="margin-top: -13px;"></div>
        <div class="spacer"></div>
        <script type="text/javascript">
        $().ready(function(){
            KS.doError ('#ctr', "<?php __('login_please'); ?>");
        });
        </script>
        <script type="text/javascript">
                $().ready(function(){
                        $("#login-callback-m").hide();
                        $("#frmMain").submit(function(){
                                var strNick = document.getElementById("account-id-m").value;
                                var strPass = document.getElementById("account-pw-m").value;
                                var data = $("#frmMain").serialize();
                                
                                if (strNick.length < 4 || strPass.length < 4)
                                        return false;
                                
                                KS.doLoad('#login-callback-m');
                                $("input").attr('disabled', 'true');
                                
                                $.ajax({
                                        url: "/ajax/login",
                                        type: "post",
                                        data: data,
                                        dataType: "json",
                                        success:
                                                function(obj)
                                                {
                                                        if (obj.response == "fail")
                                                        {
                                                                KS.doError('#login-callback-m', "<?php __('login_failure'); ?>");
                                                        }
                                                        else
                                                        {
                                                                KS.doSuccess('#login-callback-m', "&nbsp;&nbsp;<img src='<?php t(); ?>img/ajax-loader-2.gif' alt='' />");
                                                                window.location = "<?php echo Login::$continue; ?>";
                                                        }
                                                },
                                        failure:
                                                function(error)
                                                {
                                                        alert (error);
                                                },
                                        complete:
                                                function()
                                                {
                                                        $('input').removeAttr('disabled');
                                                }
                                });
                                
                                return false;
                        });
                });
        </script>
        <div align="center">
                <form action="/login" id="frmMain" name="frmMain" method="post">
                        <table cellpadding="0" cellspacing="0" align="center" width="800px">
                                <tr>
                                        <td align="center" width="500px" valign="middle">
                                                <input type="text" id="account-id-m" name="account-id-l" value="<?php __('account_id'); ?>" onfocus="if(this.value=='<?php __('account_id'); ?>'){this.value='';}" onblur="if(this.value==''){this.value='<?php __('account_id'); ?>';}" maxlength="55" /><br />
                                                <input type="password" id="account-pw-m" name="account-pw-l" value="<?php __('account_pw'); ?>" onfocus="if(this.value=='<?php __('account_pw'); ?>'){this.value='';}" onblur="if(this.value==''){this.value='<?php __('account_pw'); ?>';}" maxlength="35" />
                                        </td>
                                        <td align="center" width="300px" valign="middle">
                                                <input type="submit" value="<?php __('account_login'); ?>" class="button-special" />
                                        </td>
                                </tr>
                                <tr>
                                        <td colspan="2" class="spacer"></td>
                                </tr>
                                <tr>
                                        <td colspan="2">
                                                <div id="login-callback-m"></div>
                                        </td>
                                </tr>
                                <tr>
                                        <td colspan="2" class="spacer"></td>
                                </tr>
                        </table>
                </form>
        </div>
</div>