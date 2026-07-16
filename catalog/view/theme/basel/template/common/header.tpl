<!DOCTYPE html>
<!--[if IE]><![endif]-->
<!--[if IE 8 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie8"><![endif]-->
<!--[if IE 9 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie9"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<!--<![endif]-->

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title><?php echo $title; ?></title>
    <base href="<?php echo $base; ?>" />
    <?php if ($description) { ?>
        <meta name="description" content="<?php echo $description; ?>" /><?php } ?>
    <?php if ($keywords) { ?>
        <meta name="keywords" content="<?php echo $keywords; ?>" /><?php } ?>
    <!-- Load essential resources -->
    <script src="catalog/view/javascript/jquery/jquery-2.1.1.min.js"></script>
    <link href="catalog/view/javascript/bootstrap/css/bootstrap.css" rel="stylesheet" media="screen" />
    <script src="catalog/view/javascript/bootstrap/js/bootstrap.min.js"></script>
    <script src="catalog/view/theme/basel/js/slick.min.js"></script>
    <!-- Main stylesheet -->
    <?php $css_path = DIR_APPLICATION . 'view/theme/basel/stylesheet/stylesheet.css'; ?>
    <meta name="css_path" content="<?php echo $css_path; ?>" />
    <link href="catalog/view/theme/basel/stylesheet/stylesheet.css?v=<?php echo file_exists($css_path) ? filemtime($css_path) : time(); ?>" rel="stylesheet">
    <?php $js_path = DIR_APPLICATION . 'view/theme/basel/js/basel_common.js'; ?>
    <meta name="js_path" content="<?php echo $js_path; ?>" />
    <script src="catalog/view/theme/basel/js/basel_common.js?v=<?php echo file_exists($js_path) ? filemtime($js_path) : time(); ?>"></script>
    <!-- Mandatory Theme Settings CSS -->
    <style id="basel-mandatory-css">
        <?php echo $basel_mandatory_css; ?>
    </style>
    <!-- Plugin Stylesheet(s) -->
    <?php foreach ($styles as $style) { ?>
        <link href="<?php echo $style['href']; ?>" rel="<?php echo $style['rel']; ?>" media="<?php echo $style['media']; ?>" />
    <?php } ?>
    <!-- Pluing scripts(s) -->
    <?php foreach ($scripts as $script) { ?>
        <script src="<?php echo $script; ?>"></script>
    <?php } ?>
    <!-- Page specific meta information -->
    <?php foreach ($links as $link) { ?>
        <?php if ($link['rel'] == 'image') { ?>
            <meta property="og:image" content="<?php echo $link['href']; ?>" />
        <?php } else { ?>
            <link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
        <?php } ?>
    <?php } ?>
    <!-- Analytic tools -->
    <?php foreach ($analytics as $analytic) { ?>
        <?php echo $analytic; ?>
    <?php } ?>
    <?php if (isset($basel_styles_status)) { ?>
        <!-- Custom Color Scheme -->
        <style id="basel-color-scheme">
            <?php echo $basel_styles_cache; ?>
        </style>
    <?php } ?>
    <?php if (isset($basel_typo_status)) { ?>
        <!-- Custom Fonts -->
        <style id="basel-fonts">
            <?php echo $basel_fonts_cache; ?>
        </style>
    <?php } ?>
    <?php if ($direction == 'rtl') { ?>
        <link href="catalog/view/theme/basel/stylesheet/rtl.css" rel="stylesheet">
    <?php } ?>
    <?php if ($basel_custom_css_status) { ?>
        <!-- Custom CSS -->
        <style id="basel-custom-css">
            <?php echo $basel_custom_css; ?>
        </style>
    <?php } ?>
    <?php if ($basel_custom_js_status) { ?>
        <!-- Custom Javascript -->
        <script>
            <?php echo $basel_custom_js; ?>
        </script>
    <?php } ?>
    <link rel="apple-touch-icon" sizes="180x180" href="/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="/favicon-16x16.png">
    <link rel="manifest" href="/site.webmanifest">
    <link rel="mask-icon" href="/safari-pinned-tab.svg" color="#5bbad5">
    <meta name="msapplication-TileColor" content="#da532c">
    <meta name="theme-color" content="#ffffff">
    <meta name="facebook-domain-verification" content="75ykxvw3jd8pmxngc2fkzonjzq5z4j" />
    <!-- Facebook Pixel Code -->
    <script>
        ! function(f, b, e, v, n, t, s) {
            if (f.fbq) return;
            n = f.fbq = function() {
                n.callMethod ?
                    n.callMethod.apply(n, arguments) : n.queue.push(arguments)
            };
            if (!f._fbq) f._fbq = n;
            n.push = n;
            n.loaded = !0;
            n.version = '2.0';
            n.queue = [];
            t = b.createElement(e);
            t.async = !0;
            t.src = v;
            s = b.getElementsByTagName(e)[0];
            s.parentNode.insertBefore(t, s)
        }(window, document, 'script',
            'https://connect.facebook.net/en_US/fbevents.js');
        fbq('init', '569849224248630');
        fbq('track', 'PageView');
    </script>
    <!-- End Facebook Pixel Code -->
    <!-- VK Pixel Code -->
    <script type="text/javascript">
        ! function() {
            var t = document.createElement("script");
            t.type = "text/javascript", t.async = !0, t.src = 'https://vk.com/js/api/openapi.js?169', t.onload = function() {
                VK.Retargeting.Init("VK-RTRG-1285993-7bmc8"), VK.Retargeting.Hit()
            }, document.head.appendChild(t)
        }();
    </script><noscript><img src="https://vk.com/rtrg?p=VK-RTRG-1285993-7bmc8" style="position:fixed; left:-999px;" alt="" /></noscript>
    <!-- VK Pixel END Code -->
    <!-- Yandex.Metrika counter -->
    <script type="text/javascript">
        (function(m, e, t, r, i, k, a) {
            m[i] = m[i] || function() {
                (m[i].a = m[i].a || []).push(arguments)
            };
            m[i].l = 1 * new Date();
            k = e.createElement(t), a = e.getElementsByTagName(t)[0], k.async = 1, k.src = r, a.parentNode.insertBefore(k, a)
        })
        (window, document, "script", "https://mc.yandex.ru/metrika/tag.js", "ym");

        ym(86234829, "init", {
            clickmap: true,
            trackLinks: true,
            accurateTrackBounce: true,
            webvisor: true
        });
    </script>
    <noscript>
        <div><img src="https://mc.yandex.ru/watch/86234829" style="position:absolute; left:-9999px;" alt="" /></div>
    </noscript>
    <!-- /Yandex.Metrika counter -->
    <meta name="yandex-verification" content="9cdadeee62790858" />
</head>

<body class="<?php echo $class; ?><?php echo $basel_body_class; ?>">
    <noscript><img height="1" width="1" style="display:none"
            src="https://www.facebook.com/tr?id=569849224248630&ev=PageView&noscript=1" /></noscript>
    <?php require_once('catalog/view/theme/basel/template/common/mobile-nav.tpl'); ?>
    <div class="outer-container main-wrapper">
        <?php if ($notification_status) { ?>
            <div class="top_notificaiton">
                <div class="container<?php if ($top_promo_close) echo ' has-close'; ?> <?php echo $top_promo_width; ?> <?php echo $top_promo_align; ?>">
                    <div class="table">
                        <div class="table-cell w100">
                            <div class="ellipsis-wrap"><?php echo $top_promo_text; ?></div>
                        </div>
                        <?php if ($top_promo_close) { ?>
                            <div class="table-cell text-right">
                                <a onClick="addCookie('basel_top_promo', 1, 30);$(this).closest('.top_notificaiton').slideUp();" class="top_promo_close">&times;</a>
                            </div>
                        <?php } ?>
                    </div>
                </div>
            </div>
        <?php } ?>
        <?php require_once('catalog/view/theme/basel/template/common/headers/' . $basel_header . '.tpl'); ?>
        <!-- breadcrumb -->
        <div class="breadcrumb-holder">
            <div class="container">
                <span id="title-holder">&nbsp;</span>
                <div class="links-holder">
                    <a class="basel-back-btn" onClick="history.go(-1); return false;"><i></i></a><span>&nbsp;</span>
                </div>
            </div>
        </div>
        <div class="container">
            <?php echo $position_top; ?>
        </div>