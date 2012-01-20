<?php
Blog::$jsp['strTitle'] = str_replace ("\'", "'", Blog::$jsp['strTitle']);
$cont = str_replace ("\'", "'", preg_replace ('/<(.+)>/i', '', htmlspecialchars_decode (Blog::$jsp['strContent'])));
$n1 = (Blog::$jspc != 1 ? '<hr />' : '');
$n2 = ((strlen ($cont) > 200) ? (substr ($cont, 0, 200) . '...<a href="/blog/' . Blog::$jsp['nID'] . '-' . blog_title_to_url (Blog::$jsp['strTitle']) .'">&nbsp;&laquo;&nbsp;' . ___('blog_post_read_more') . '</a>') : ($cont . '...<a href="/blog/' . Blog::$jsp['nID'] . '-' . blog_title_to_url (Blog::$jsp['strTitle']) .'">&nbsp;&laquo;&nbsp;' . ___('blog_post_read_more') . '</a>'));
$n3 = ((LOGGED_IN == 2) ? ('<i><a href="javascript:edtpost(' . Blog::$jsp['nID'] . ',' . Blog::$jspc .');"><img src="' . TPL . 'img/blog-post-edit.jpg" alt="" /> ' . ___('blog_post_edit') . '</a> &mdash; <a href="javascript:rmvpost(' . Blog::$jsp['nID'] . ');"><img src="' . TPL . 'img/blog-post-remove.jpg" alt="" /> ' . ___('blog_post_remove') . '</a></i>') : '');
$main->js_pipe->jsify ('
<div class="blog-post" id="blog-no-' . Blog::$jsp['nID'] .'">
        ' . $n1 . '
        <div class="h1"><img src="' . TPL . 'img/blog-post.jpg" alt="" />&nbsp;' . Blog::$jsp['strTitle'] . '</div>
        <div class="h2">
                <blockquote>
                        <i>//</i>&nbsp;<b>' . Blog::$jsp['strDate'] . ':&nbsp;</b>
                        <i>
                                ' . $n2 . '
                        </i>
                </blockquote>
        </div>
        ' . $n3 . '
        <div class="spacer"></div>
</div>
'
, array (1, '#frmNewPostCallback'));


#$main->js_pipe->jsify ('<div id="some">what the fuck?</div>', array (1, '#frmNewPostCallback'));
#sleep (1);
?>