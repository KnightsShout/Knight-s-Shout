<?php
if (!function_exists ('defriend'))
{
        function defriend ($user)
        {
                echo '
<form action="/ajax/friends" method="post">
        <input type="hidden" name="ks_secure_key" value="' . KS_SECURE_KEY . '" />
        <input type="hidden" name="a" value="disband" />
        <input type="hidden" name="target" value="'. $user . '" />
        <input type="hidden" name="redirect" value="' . url_continue () . '" />
        <input type="submit" class="ksbutton" value="-' . ___('friends_disband') . '" />
</form>
                ';
        }
}
?>