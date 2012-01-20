<?php
global $main;
?>
<div align="center" class="ppheadline"><?php __('title_notifications-other'); ?></div>
<div align="left" class="ppcontent">
        <div class="user-notification-header" align="left"><?php __('notifications_other_title'); ?></div>
        <?php
        if ($main->notifications->hasNotifications ())
        {
                foreach ($main->notifications->notifications as $notification)
                {
                        if (empty ($notification['strAccountID']))
                                continue;
                        echo $main->notifications->parseNotification ($notification);
                }
        }
        else
        {
                ?>
                <div class="user-notification"><?php __('notifications_other_none_'); ?></div>
                <?php
        }
        ?>
        <div style="height: 15px;"></div>
        <div class="user-notification-header" align="left"><?php __('notifications_other_title_'); ?></div>
        <?php
        if ($main->notifications->hasNotificationsOther ())
        {
                foreach ($main->notifications->notificationsOther as $notification)
                {
                        if (empty ($notification['strAccountID']))
                                continue;
                        echo $main->notifications->parseNotification ($notification);
                }
        }
        else
        {
                ?>
                <div class="user-notification"><?php __('notifications_other_none_'); ?></div>
                <?php
        }
        ?>
</div>