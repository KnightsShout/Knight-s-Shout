<?php
if (!function_exists ('befriend_requested'))
{
        function befriend_requested ($user, $redirect = null)
        {
                if ($redirect === null)
                        $redirect = url_continue ();
                echo '
<form action="/ajax/friends" method="post">
        <input type="hidden" name="ks_secure_key" value="' . KS_SECURE_KEY . '" />
        <input type="hidden" name="a" value="confirm" />
        <input type="hidden" name="target" value="'. $user . '" />
        <input type="hidden" name="redirect" value="' . $redirect . '" />
        <input type="submit" class="ksbutton" value="+' . ___('friends_accept') . '" />
</form>
                ';
        }
}

if (!function_exists ('fdecline_requested'))
{
        function fdecline_requested ($user, $redirect = null)
        {
                if ($redirect === null)
                        $redirect = url_continue ();
                echo '
<form action="/ajax/friends" method="post">
        <input type="hidden" name="ks_secure_key" value="' . KS_SECURE_KEY . '" />
        <input type="hidden" name="a" value="decline" />
        <input type="hidden" name="target" value="'. $user . '" />
        <input type="hidden" name="redirect" value="' . $redirect . '" />
        <input type="submit" class="ksbutton" value="-' . ___('friends_decline') . '" />
</form>
                ';
        }
}
?>