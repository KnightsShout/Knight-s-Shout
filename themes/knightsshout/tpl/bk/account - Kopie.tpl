<script type="text/javascript">
$().ready(function(){
        set_title("<?php __('title_account'); ?>");
});
</script>
<div style="width: 992px;" align="center">
        <table cellpadding="0" cellspacing="0" width="992px" align="center">
                <tr>
                        <td></td>
                        <td colspan="6" align="left">
                                <h1><?php echo str_replace ('@', '&laquo;', ___('title_account')); ?></h1>
                        </td>
                        <td></td>
                </tr>
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
                        <td colspan="6" align="center">
                                <i><?php __('account_select_section'); ?></i>
                        </td>
                        <td></td>
                </tr>
        </table>
</div>