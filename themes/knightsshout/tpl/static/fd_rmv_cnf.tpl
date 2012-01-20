<?php
global $main;
if (!LOGGED_IN)
{
        die ();
}
?>
<script type="text/javascript">
function __rmv_go()
{
        var attr = new Array(0, null, '/ajax/user/<?php echo strtolower ($_SESSION['strAccount']); ?>/feed_remove?id=<?php echo intval (@$_GET['id']); ?>', null);
        KS.doPopup(attr);
}
</script>
<div align="center" class="ppheadline"><?php __('confirm'); ?></div>
<div align="left" class="ppcontent">
        <?php __('remove_feed_expl'); ?><br />
        <div align="center">
                <table cellpadding="0" cellspacing="0" align="center">
                        <tr>
                                <td colspan="3" style="height: 7px;"></td>
                        </tr>
                        <tr>
                                <td>
                                        <a href="javascript:;" onclick="__rmv_go();"><div class="ksbutton"><?php __('glob_proceed'); ?></div></a>
                                </td>
                                <td width="10px"></td>
                                <td>
                                        <a href="javascript:;" onclick="KS.doHidePopup();"><div class="ksbutton"><?php __('glob_cancel'); ?></div></a>
                                </td>
                        </tr>
                </table>
        </div>
</div>