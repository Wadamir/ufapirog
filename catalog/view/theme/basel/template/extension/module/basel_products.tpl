<div class="widget module<?php echo $module; if ($columns != 'list') echo ' grid'; if ($contrast) echo ' contrast-bg'; if ($carousel && $rows > 1) echo ' multiple-rows'; ?>" <?php if ($use_margin) echo 'style="margin-bottom:' . $margin . '"'; ?>>
<?php if ($block_title) { ?>
<!-- Block Title -->
<div class="widget-title">
<?php if ($title_preline) { ?><p class="pre-line"><?php echo $title_preline; ?></p><?php } ?>
<?php if ($title) { ?> 
<p class="main-title"><span><?php echo $title; ?></span></p>
<p class="widget-title-separator"><i class="icon-line-cross"></i></p>
<?php } ?>
<?php if ($title_subline) { ?>
<p class="sub-line"><span><?php echo $title_subline; ?></span></p>
<?php } ?>
</div>
<?php } ?>
<?php if (count($tabs) >= 2) { ?>
<!-- Tabs -->
<ul id="tabs-<?php echo $module; ?>" class="nav nav-tabs <?php echo $tabstyle; ?>" data-tabs="tabs" style="">
    <?php foreach ($tabs as $keyTab => $tab) { ?>
        <?php if($keyTab == 0) { ?>
        <li class="active"><a href="#tab<?php echo $module; ?><?php echo $keyTab; ?>" data-toggle="tab"><?php echo $tab['title']; ?></a></li>
        <?php } else { ?>
        <li><a href="#tab<?php echo $module; ?><?php echo $keyTab; ?>" data-toggle="tab"><?php echo $tab['title']; ?></a></li>
        <?php } ?>
    <?php } ?>
</ul>
<?php } ?>
<div class="tab-content has-carousel <?php if (!$carousel) echo "overflow-hidden"; ?>">
<!-- Product Group(s) -->
<?php foreach ($tabs as $key => $tab) { ?>
<div class="tab-pane <?php echo (empty($key) ? 'active in' : ''); ?> fade" id="tab<?php echo $module; ?><?php echo $key; ?>">
    <div class="grid-holder grid<?php echo $columns; ?> prod_module<?php echo $module; ?> <?php if ($carousel) echo "carousel"; ?> <?php if ($carousel_a && $rows > 1) echo "sticky-arrows"; ?>">
        <?php foreach ($tab['products'] as $product) { ?>
			<?php require('catalog/view/theme/basel/template/product/single_product.tpl'); ?>
        <?php } ?>
    </div>
</div>
<?php } ?>
<?php if ($use_button) { ?>
<!-- Button -->
<div class="widget_bottom_btn <?php if ($carousel && $carousel_b) echo 'has-dots'; ?>">
<a class="btn btn-contrast" href="<?php echo isset($link_href) ? $link_href : ''; ?>"><?php echo $link_title; ?></a>
</div>
<?php } ?>
</div>
<div class="clearfix"></div>
</div>
<?php if ($carousel) { ?>
<script><!--
$('.grid-holder.prod_module<?php echo $module; ?>').slick({
<?php if ($carousel_a) { ?>
prevArrow: "<a class=\"arrow-left icon-arrow-left\"></a>",
nextArrow: "<a class=\"arrow-right icon-arrow-right\"></a>",
<?php } else { ?>
arrows: false,
<?php } ?>
<?php if ($direction == 'rtl') { ?>
rtl:true,
<?php } ?>
<?php if ($carousel_b) { ?>
dots:true,
<?php } ?>
respondTo:'min',
rows:<?php echo $rows; ?>,
<?php if ($columns == '5') { ?>
slidesToShow:5,slidesToScroll:5,responsive:[{breakpoint:1100,settings:{slidesToShow:4,slidesToScroll:4}},{breakpoint:960,settings:{slidesToShow:3,slidesToScroll:3}},{breakpoint:600,settings:{slidesToShow:2,slidesToScroll:2}},
<?php } elseif ($columns == '4') { ?>
slidesToShow:4,slidesToScroll:4,responsive:[{breakpoint:960,settings:{slidesToShow:3,slidesToScroll:3}},{breakpoint:600,settings:{slidesToShow:2,slidesToScroll:2}},
<?php } elseif ($columns == '3') { ?>
slidesToShow:3,slidesToScroll:3,responsive:[{breakpoint:600,settings:{slidesToShow:2,slidesToScroll:2}},
<?php } elseif ($columns == '2') { ?>
slidesToShow:2,slidesToScroll:2,responsive:[
<?php } elseif (($columns == '1' || $columns == 'list')) { ?>
adaptiveHeight:true,slidesToShow:1,slidesToScroll:1,responsive:[
<?php } ?>
<?php if ($items_mobile_fw) { ?>
{breakpoint:420,settings:{slidesToShow:1,slidesToScroll:1}}
<?php } ?>
]
});
$('.product-style2 .single-product .icon').attr('data-placement', 'top');
$('[data-toggle=\'tooltip\']').tooltip({container: 'body'});
<?php if ($carousel_a && $rows > 1) { ?>
$(window).load(function() {
var p_c_o = $('.prod_module<?php echo $module; ?>').offset().top;
var p_c_o_b = $('.prod_module<?php echo $module; ?>').offset().top + $('.prod_module<?php echo $module; ?>').outerHeight(true) - 100;
var p_sticky_arrows = function(){
var p_m_o = $(window).scrollTop() + ($(window).height()/2);
if (p_m_o > p_c_o && p_m_o < p_c_o_b) {
$('.prod_module<?php echo $module; ?> .slick-arrow').addClass('visible').css('top', p_m_o - p_c_o + 'px');
} else {
$('.prod_module<?php echo $module; ?> .slick-arrow').removeClass('visible');
}
};
$(window).scroll(function() {p_sticky_arrows();});
});
<?php } ?>
//--></script>
<?php } ?>