<script type="text/javascript">
$().ready(function(){
        set_title("<?php __('title_account_server'); ?>");
});
</script>
<div style="width: 992px;" align="center">
        <table cellpadding="0" cellspacing="0" width="992px" align="center">
                <tr>
                        <td width="6px"></td>
                        <td width="90px"></td>
                        <td width="200px" align="center">
                                <a href="/account/game">
                                        <div class="ksbutton" align="center">
                                                <?php __('account_game'); ?>
                                        </div>
                                </a>
                        </td>
                        <td width="200px" align="center">
                                <a href="/account/server">
                                        <div class="ksbutton" align="center">
                                                <?php __('account_server'); ?>
                                        </div>
                                </a>
                        </td>
                        <td width="200px" align="center">
                                <a href="/account/personality">
                                        <div class="ksbutton" align="center">
                                                <?php __('account_personality'); ?>
                                        </div>
                                </a>
                        </td>
                        <td width="200px" align="center">
                                <a href="/account/settings">
                                        <div class="ksbutton" align="center">
                                                <?php __('account_settings'); ?>
                                        </div>
                                </a>
                        </td>
                        <td width="90px"></td>
                        <td width="6px"></td>
                </tr>
                <tr>
                        <td colspan="8" style="height: 25px;"></td>
                </tr>
                <tr>
                        <td></td>
                        <td colspan="6" align="left">
                                <h1><?php __('title_account_server'); ?></h1>
                        </td>
                        <td></td>
                </tr>
                <tr>
                        <td></td>
                        <td colspan="6" align="left">
                                <?php
                                if (Account::$count == 0)
                                {
                                        ?>
                                        <div class="account-header">
                                                <?php __('account_server_intro'); ?>
                                        </div>
                                        <div class="account-content">
                                                <?php __('account_server_intro_expl'); ?><br /><br />
                                                <div align="center">
                                                        <a href="/account/server/create"><div class="ksbutton btn-maxed-b" align="center"><?php __('account_server_register'); ?></div></a><br /><br />
                                                </div>
                                        </div>
                                        <?php
                                }
                                else
                                {
                                        
                                }
                                ?>
                        </td>
                        <td></td>
                </tr>
        </table>
</div>