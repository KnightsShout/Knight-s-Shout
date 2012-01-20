<script type="text/javascript">profileSectionSelect("#button-wall");</script>
<div class="profile-content-section-header">
        <div class="profile-content-section-header-h1">
                <?php __('user_profile_wall'); ?>
        </div>
</div>
<div style="height: 6px;"></div>
<?php
Template::load ('wall_make_post');
?>
<div style="height: 6px;"></div>
<script type="text/javascript">
function frmv(nID)
{
        var attr = new Array(0, null, '/ajax/static/fd_rmv_cnf?id=' + nID, null);
        KS.doPopup(attr);
}
</script>
<?php
$c = $main->feeds->loadFeed (pUser::$user['strAccountID']);

while ($feed = $main->database->doRead ())
{
        echo '<div class="user-feed" id="feed-no-' . $feed['FEED'] . '" onmouseover="$(\'#feedrmv-' . $feed['FEED'] . '\').show();" onmouseout="$(\'#feedrmv-' . $feed['FEED'] . '\').hide();">&nbsp;<img src="' . TPL . 'img/feed/' . $feed['nType'] . '.png" width="12px" height="12px" alt="" />&nbsp;&nbsp;' . $main->feeds->_parseFeed ($feed);
        if (pUser::$friends === 4)
        {
                ?>
                &nbsp;<a href="javascript:;" onclick="frmv(<?php echo $feed['FEED']; ?>);"><span class="feedrmv" id="feedrmv-<?php echo $feed['FEED']; ?>">X</span></a>
                <?php
        }
        echo '</div>';
}

if ($c < 25)
{
        ?><div class="user-feed"><?php __('feed_no_further'); ?></div><?php
}
?>
<script type="text/javascript">
$().ready(function(){
        ks_url.fake('', '/user/<?php echo strtolower (pUser::$user['strAccountID']); ?>/wall', 2);
});
</script>