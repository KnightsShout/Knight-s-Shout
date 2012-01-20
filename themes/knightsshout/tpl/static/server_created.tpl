<?php
global $main;
if (!LOGGED_IN)
{
        die ();
}
?>
<script type="text/javascript">
function __p_go()
{
        window.location = '/account/server';
}
</script>
<div align="center" class="ppheadline"><?php __('account_server_created'); ?></div>
<div align="left" class="ppcontent">
        <?php __('account_server_created_expl'); ?><br /><br />
        <div align="center">
                <a href="javascript:;" onclick="__p_go();"><div class="ksbutton btn-maxed-b"><?php __('glob_proceed'); ?></div></a>
        </div>
</div>