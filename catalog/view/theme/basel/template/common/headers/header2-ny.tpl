<div class="header-wrapper header2 fixed-header-possible">
	<?php if ($top_line_style) { ?>
	<div class="top_line">
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
						<?php if ($header_phone) { ?>
						<div class="icon-element is_clock">
							<a class="shortcut-wrapper clock" href="/delivery/">
								<div class="clock-hover">
									<span class="clock_time">
										Приём заказов с 9:00 до 19:00
									</span>
								</div>
							</a>
						</div>
						<?php } ?>
					</div>
				</div>
				<div class="table-cell text-center sm-text-center xs-text-center hidden-xxs hidden">
					<div class="promo-message">
						<?php echo $promo_message; ?>
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
	<!-- .top_line ends -->
	<!-- .new year -->
	<div class="top_line" style="background-color:#ff0000">
		<div class="container <?php echo $top_line_width; ?>">
			<div class="table" style="table-layout:fixed">
			    <div class="table-cell">
			        <div class="text-center hidden-md hidden-sm hidden-xs visible-xxs col-xs-12">
			            <span class="" style="background-color:#ff0000; color: #ffffff; font-family: Phenomena, sans-serif;    display: block; font-size:1.5em">1 - 4 января выходные дни. Приём заказов и доставка начнёт свою работу с 05.01.2024</span>
			        </div>
			    </div>
			</div>
		</div>
	</div>
	<!-- .new year ends -->
	<?php } ?>
	<span class="table header-main sticky-header-placeholder hidden">&nbsp;</span>
	<div class="sticky-header outer-container header-style">
		<div class="container <?php echo $main_header_width; ?>">
			<div class="table header-main <?php echo $main_menu_align; ?>">
				<div class="table-cell text-left w20 md-w25 sm-w25 xs-w30 xxs-w45 logo">
					<?php if ($logo) { ?>
					<div id="logo">
						<a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>"
								alt="<?php echo $name; ?>" /></a>
					</div>
					<?php } ?>
				</div>
				<?php if($primary_menu) { ?>
				<div class="table-cell text-center w60 menu hidden-xs hidden-sm hidden-md">
					<div class="main-menu">
						<ul class="categories">
							<?php if($primary_menu == 'oc') { ?>
							<!-- Default menu -->
							<?php echo $default_menu; ?>
							<?php } else if (isset($primary_menu)) { ?>
							<!-- Mega menu -->
							<?php foreach($primary_menu_desktop as $key=> $row) { ?>
							<?php require('catalog/view/theme/basel/template/common/menus/mega_menu.tpl'); ?>
							<?php } ?>
							<?php } ?>
						</ul>
					</div>
				</div>
				<?php } ?>
				<div class="table-cell text-center md-w50 sm-w50 xs-w40 hidden-lg hidden-xxs">
					<div class="text-center col-xs-12 lh_normal">
						<?php if ($header_phone) { ?>
						<div class="icon-element is_phone">
							<a class="shortcut-wrapper phone" href="tel:<?php echo $telephone; ?>" target="_blank">
								<div class="phone-hover"><i class="icon-phone icon"></i><span class="phone_number">
										<?php echo $telephone; ?>
									</span></div>
							</a>
						</div>
						<?php } ?>
					</div>
					<div class="text-center col-xs-12 lh_normal">
						<?php if ($header_phone) { ?>
						<div class="icon-element is_clock">
							<a class="shortcut-wrapper clock" href="/delivery/">
								<div class="clock-hover">
									<span class="clock_time">
										Приём заказов с 9:00 до 19:00
									</span>
								</div>
							</a>
						</div>
						<?php } ?>
					</div>
				</div>
				<div class="table-cell text-right w20 md-w25 sm-w25 xs-w30 xxs-w55 shortcuts">
					<div class="font-zero">
						<div class="icon-element">
							<a class="shortcut-wrapper instagram" href="https://wa.me/79373335833/" target="_blank">
								<img src="/catalog/view/theme/basel/stylesheet/icons/icon-whatsapp.png" title="whatsapp"
									alt="whatsapp" />
							</a>
						</div>
						<!-- <div class="icon-element hidden">
							<a class="shortcut-wrapper vk" href="https://vk.com/makovka_ufa" target="_blank">
								<img src="/catalog/view/theme/basel/stylesheet/icons/icon-vk.png" title="vkonakte"
									alt="vkonakte" />
							</a>
						</div> -->
						<?php if ($header_search) { ?>
						<div class="icon-element">
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
								<i class="icon-line-menu icon"></i>
							</a>
						</div>
					</div>
				</div>
			</div>
			<!-- .table.header_main ends -->
		</div>
		<!-- .container ends -->
	</div>
	<!-- .sticky ends -->
</div>
<!-- .header_wrapper ends -->