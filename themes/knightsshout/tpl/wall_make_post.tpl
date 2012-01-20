<?php
if (!function_exists ('wall_post_form'))
{
        function wall_post_form ($user)
        {
                echo '
<form action="/ajax/user/' . strtolower ($user) . '/make_wall_post" method="post">
        <input type="hidden" name="a" value="request" />
        <input type="hidden" name="target" value="'. $user . '" />
        <input type="hidden" name="redirect" value="' . url_continue () . '" />
        <input type="submit" class="ksbutton" value="+' . ___('friends_add') . '" />
</form>
                ';
        }
}
?>