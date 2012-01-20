<?php
$article = $main->database->doRead ();
$title = str_replace ("\'", "'", $article['strTitle']);
$cont = str_replace ("\'", "'", htmlspecialchars_decode ($article['strContent']));
$sec = array(1 => ___('blog_post_category_comm'), 2 => ___('blog_post_category_tech'), 3 => '');
$secz = array(1 => '-comm', 2 => '-tech', 3 => '');
?>
<div id="blog-header-p" align="left">
        <div style="padding-left: 162px; padding-top: 12px;" align="left">
                <h1>&nbsp;<img src="<?php t(); ?>img/blog-post<?php echo $secz[$article['nCategory']];?>.jpg" alt="" />&nbsp;<?php echo $title; ?></h1>
                <div class="blog-post-desc">
                        <?php
                        $article['nCategory'] != 3 ?
                                __('blog_article_posted_on', array ((string) strtolower ($article['strAuthor']), (string) $article['strAuthor'], (string) $sec[$article['nCategory']], (string) $article['strDate']))
                                :
                                __('blog_article_posted_on2', array ((string) strtolower ($article['strAuthor']), (string) $article['strAuthor'], (string) $article['strDate']));
                        ?>
                </div>
                <div style="height: 4px;"></div>
                <hr />
                <div id="bhcnt"></div>
                <div id="bmcnt">
                        <div class="bheader"><?php __('blog_article_post_top'); ?>,</div>
                        <div class="bcontent">
                                <?php
                                echo $cont;
                                ?>
                        </div>
                        <div class="bfooter"><?php __('blog_article_post_footer', array ((string) $article['strAuthor'])); ?></div>
                </div>
                <div style="height: 8px;"></div>
                <hr />
                <div style="height: 13px;"></div>
                <div class="blog-post-desc">
                        <a href="javascript:$('#bmcnt').slideToggle(200);KS.doLoad ('#bhcnt');window.location='/blog';"><i>&raquo; <?php __('blog_return'); ?></i></a>
                </div>
                <div style="height: 9px;"></div>
        </div>
</div>