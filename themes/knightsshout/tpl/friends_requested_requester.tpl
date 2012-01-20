<?php
if (!function_exists ('befriend_progress'))
{
        function befriend_progress ($user = null)
        {
                echo '
<span class="ksbutton">' . ___('friends_requested') . '</span>
                ';
        }
}
?>