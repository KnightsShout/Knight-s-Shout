<?php
global $main;
?>
<div align="center" class="ppheadline"><?php __('title_notifications-friends'); ?></div>
<div align="left" class="ppcontent">
        <?php
        Template::load ('friends_requested');
        foreach ($main->notifications->friendRequests as $request)
        {
                if (empty ($request['strAccountID']))
                        continue;
                $strAvatar = '/resources/user-content/';
                $strAvatar.= strlen ($request['strAvatar']) > 2 ? $request['strAvatar'] : 'default.png';
                ?>
                <div class="friend-request" align="left">
                        <table cellpadding="0" cellspacing="0" align="left">
                                <tr>
                                        <td width="125px" height="125px" align="center" valign="middle"><img src="<?php echo $strAvatar; ?>" width="100px" height="100px" alt="" /></td>
                                        <td width="350px" align="left" valign="top">
                                                <div style="height: 12px;"></div>
                                                <div><h1><?php echo $request['strAccountID']; ?></h1></div>
                                                <div style="height: 25px;"></div>
                                                &nbsp;&raquo;&nbsp;<a href="/user/<?php echo strtolower ($request['strAccountID']); ?>"><?php __('notifications_friend_requests_full'); ?></a>
                                        </td>
                                        <td width="122px" align="center" valign="middle">
                                                <?php befriend_requested ($request['strAccountID'], '/user/' . strtolower ($request['strAccountID'])); ?>
                                                <div style="height: 7px;"></div>
                                                <?php fdecline_requested ($request['strAccountID'], '/home'); ?>
                                        </td>
                                </tr>
                        </table>
                </div>
                <?php
        }
        ?>
</div>