<div class="header-wrapper header2 fixed-header-possible"></div>
<?php if ($top_line_style) { ?>
    <div class="top_line d-none hidden">
        <div class="container <?php echo $top_line_width; ?>">
            <div class="table" style="table-layout:fixed">
                <div class="table-cell">
                    <div class="text-center hidden-md hidden-sm hidden-xs visible-xxs col-xs-12">
                        <?php if ($header_phone) { ?>
                            <div class="icon-element is_phone">
                                <a class="shortcut-wrapper phone" href="tel:<?php echo $telephone; ?>" target="_blank">
                                    <div class="phone-hover">
                                        <i class="icon-phone icon"></i>
                                        <span class="phone_number">
                                            <?php echo $telephone; ?>
                                        </span>
                                    </div>
                                </a>
                            </div>
                        <?php } ?>
                    </div>
                </div>
                <div class="table-cell text-right hidden-xs hidden-sm hidden">
                    <div class="links">
                        <ul>
                            <?php require('catalog/view/theme/basel/template/common/static_links.tpl'); ?>
                        </ul>
                        <?php if ($lang_curr_title) { ?>
                            <div class="setting-ul">
                                <div class="setting-li dropdown-wrapper from-left lang-curr-trigger nowrap">
                                    <a>
                                        <span>
                                            <?php echo $lang_curr_title; ?>
                                        </span>
                                    </a>
                                    <div class="dropdown-content dropdown-right lang-curr-wrapper">
                                        <?php echo $language; ?>
                                        <?php echo $currency; ?>
                                    </div>
                                </div>
                            </div>
                        <?php } ?>
                    </div>
                </div>
            </div>
            <!-- .table ends -->
        </div>
        <!-- .container ends -->
    </div>
    <div class="top_line table text-center sm-text-center xs-text-center">
        <div class="promo-message">
            <div class="icon-element is_clock">
                <a class="shortcut-wrapper clock" href="/delivery/">
                    <div class="clock-hover">
                        <span class="clock_time">
                            <?php echo $promo_message; ?>
                        </span>
                    </div>
                </a>
            </div>
            <div class="icon-element is_clock">
                <a class="shortcut-wrapper clock" href="/delivery/">
                    <div class="clock-hover">
                        <span class="clock_time">
                            <?php echo $promo_message2; ?>
                        </span>
                    </div>
                </a>
            </div>
        </div>
    </div>
    <!-- .top_line ends -->
<?php } ?>
<span class="table header-main sticky-header-placeholder hidden">&nbsp;</span>
<div class="sticky-header outer-container header-style">
    <div class="container <?php echo $main_header_width; ?>">
        <div class="table header-main <?php echo $main_menu_align; ?>">
            <div class="table-cell text-left w20 xxs-w20 logo">
                <?php if ($logo) { ?>
                    <div id="logo">
                        <a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>"
                                alt="<?php echo $name; ?>" /></a>
                    </div>
                <?php } ?>
            </div>
            <div class="table-cell text-right w20 xxs-w80 shortcuts">
                <div class="font-zero">
                    <?php if ($header_phone) { ?>
                        <div class="icon-element is_phone">
                            <a class="shortcut-wrapper phone" href="tel:<?php echo $telephone; ?>" target="_blank">
                                <i class="icon-phone icon"></i>
                                <span class="phone_number">
                                    <?php echo $telephone; ?>
                                </span>
                            </a>
                        </div>
                    <?php } ?>
                    <div class="icon-element is_whatsapp">
                        <a class="shortcut-wrapper instagram" href="https://wa.me/79373335833/" target="_blank">
                            <svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="bi bi-whatsapp" viewBox="0 0 16 16">
                                <path d="M13.601 2.326A7.85 7.85 0 0 0 7.994 0C3.627 0 .068 3.558.064 7.926c0 1.399.366 2.76 1.057 3.965L0 16l4.204-1.102a7.9 7.9 0 0 0 3.79.965h.004c4.368 0 7.926-3.558 7.93-7.93A7.9 7.9 0 0 0 13.6 2.326zM7.994 14.521a6.6 6.6 0 0 1-3.356-.92l-.24-.144-2.494.654.666-2.433-.156-.251a6.56 6.56 0 0 1-1.007-3.505c0-3.626 2.957-6.584 6.591-6.584a6.56 6.56 0 0 1 4.66 1.931 6.56 6.56 0 0 1 1.928 4.66c-.004 3.639-2.961 6.592-6.592 6.592m3.615-4.934c-.197-.099-1.17-.578-1.353-.646-.182-.065-.315-.099-.445.099-.133.197-.513.646-.627.775-.114.133-.232.148-.43.05-.197-.1-.836-.308-1.592-.985-.59-.525-.985-1.175-1.103-1.372-.114-.198-.011-.304.088-.403.087-.088.197-.232.296-.346.1-.114.133-.198.198-.33.065-.134.034-.248-.015-.347-.05-.099-.445-1.076-.612-1.47-.16-.389-.323-.335-.445-.34-.114-.007-.247-.007-.38-.007a.73.73 0 0 0-.529.247c-.182.198-.691.677-.691 1.654s.71 1.916.81 2.049c.098.133 1.394 2.132 3.383 2.992.47.205.84.326 1.129.418.475.152.904.129 1.246.08.38-.058 1.171-.48 1.338-.943.164-.464.164-.86.114-.943-.049-.084-.182-.133-.38-.232" />
                            </svg>
                        </a>
                    </div>
                    <!-- <div class="icon-element hidden">
							<a class="shortcut-wrapper vk" href="https://vk.com/makovka_ufa" target="_blank">
								<img src="/catalog/view/theme/basel/stylesheet/icons/icon-vk.png" title="vkonakte"
									alt="vkonakte" />
							</a>
						</div> -->
                    <?php if ($header_search) { ?>
                        <div class="icon-element is_search">
                            <div class="dropdown-wrapper-click from-top hidden-sx hidden-sm hidden-xs">
                                <a class="shortcut-wrapper search-trigger from-top clicker">
                                    <i class="icon-magnifier icon"></i>
                                </a>
                                <div class="dropdown-content dropdown-right">
                                    <div class="search-dropdown-holder">
                                        <div class="search-holder">
                                            <?php echo $basel_search; ?>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    <?php } ?>
                    <div class="icon-element is_wishlist hidden-xs hidden-sm">
                        <a class="shortcut-wrapper wishlist" href="<?php echo $wishlist; ?>">
                            <div class="wishlist-hover"><i class="icon-heart icon"></i><span
                                    class="counter wishlist-counter">
                                    <?php echo $wishlist_counter; ?>
                                </span></div>
                        </a>
                    </div>
                    <div class="icon-element catalog_hide">
                        <div id="cart" class="dropdown-wrapper from-top">
                            <a href="<?php echo $shopping_cart; ?>" class="shortcut-wrapper cart">
                                <i id="cart-icon" class="global-cart icon"></i> <span id="cart-total"
                                    class="nowrap">
                                    <span class="counter cart-total-items">
                                        <?php echo $cart_items; ?>
                                    </span> <span class="slash hidden-md hidden-sm hidden-xs">/</span>&nbsp;<b
                                        class="cart-total-amount hidden-sm hidden-xs">
                                        <?php echo $cart_amount; ?>
                                    </b>
                                </span>
                            </a>
                            <div class="dropdown-content dropdown-right hidden-sm hidden-xs">
                                <?php echo $cart; ?>
                            </div>
                        </div>
                    </div>
                    <div class="icon-element">
                        <a class="shortcut-wrapper menu-trigger hidden-lg">
                            <svg class="ham hamRotate ham1" viewBox="0 0 100 100" width="40px" height="40px">
                                <path class="line top" d="m 30,33 h 40 c 0,0 9.044436,-0.654587 9.044436,-8.508902 0,-7.854315 -8.024349,-11.958003 -14.89975,-10.85914 -6.875401,1.098863 -13.637059,4.171617 -13.637059,16.368042 v 40"></path>
                                <path class="line middle" d="m 30,50 h 40"></path>
                                <path class="line bottom" d="m 30,67 h 40 c 12.796276,0 15.357889,-11.717785 15.357889,-26.851538 0,-15.133752 -4.786586,-27.274118 -16.667516,-27.274118 -11.88093,0 -18.499247,6.994427 -18.435284,17.125656 l 0.252538,40"></path>
                            </svg>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container-fluid hidden-md container-menu">
        <div class="table w-100 <?php echo $main_menu_align; ?>">
            <?php if ($primary_menu) { ?>
                <div class="table-cell text-center menu hidden-xs hidden-sm hidden-md">
                    <div class="main-menu">
                        <ul class="categories">
                            <?php if ($primary_menu == 'oc') { ?>
                                <!-- Default menu -->
                                <?php echo $default_menu; ?>
                            <?php } else if (isset($primary_menu)) { ?>
                                <!-- Mega menu -->
                                <?php foreach ($primary_menu_desktop as $key => $row) { ?>
                                    <?php require('catalog/view/theme/basel/template/common/menus/mega_menu.tpl'); ?>
                                <?php } ?>
                            <?php } ?>
                        </ul>
                    </div>
                </div>
            <?php } ?>
        </div>
        <!-- .table.header_main ends -->
    </div>
    <!-- .container ends -->
</div>
<!-- .sticky ends -->
</div>
<!-- .header_wrapper ends -->