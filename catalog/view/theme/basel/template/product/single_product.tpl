<div id="product-<?php echo $product['product_id']; ?>" class="item single-product">
	<div class="single-product-wrapper">
		<div class="image" <?php if ((isset($columns)) && ($columns == 'list')) echo 'style="width:' . $img_width . 'px"'; ?>>
			<a href="<?php echo $product['href']; ?>">
				<img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" />
				<?php if ($product['thumb2']) { ?>
					<img class="thumb2" src="<?php echo $product['thumb2']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" />
				<?php } ?>
			</a>
			<?php if (($product['price']) && ($product['special']) && ($salebadge_status)) { ?>
				<div class="sale-counter id<?php echo $product['product_id']; ?>"></div>
				<span class="badge sale_badge"><i><?php echo $product['sale_badge']; ?></i></span>
			<?php } ?>
			<?php if ($product['new_label']) { ?>
				<span class="badge new_badge"><i><?php echo $basel_text_new; ?></i></span>
			<?php } ?>
			<?php if (($product['quantity'] < 1) && ($stock_badge_status)) { ?>
				<span class="badge out_of_stock_badge"><i><?php echo $basel_text_out_of_stock; ?></i></span>
				<?php $button_cart = $basel_text_out_of_stock; ?>
			<?php } else { ?>
				<?php $button_cart = $default_button_cart; ?>
			<?php } ?>
			<a class="img-overlay" href="<?php echo $product['href']; ?>"></a>
			<div class="btn-center catalog_hide"><a class="btn btn-light-outline btn-thin" onclick="cart.add('<?php echo $product['product_id']; ?>', '<?php echo $product['minimum']; ?>');"><?php echo $button_cart; ?></a></div>
			<div class="icons-wrapper">
				<a class="icon is-cart catalog_hide" data-toggle="tooltip" data-placement="<?php echo $tooltip_align; ?>" data-title="<?php echo $button_cart; ?>" onclick="cart.add('<?php echo $product['product_id']; ?>', '<?php echo $product['minimum']; ?>');"><span class="global-cart"></span></a>
				<a class="icon is_wishlist" data-toggle="tooltip" data-placement="<?php echo $tooltip_align; ?>"  data-title="<?php echo $button_wishlist; ?>" onclick="wishlist.add('<?php echo $product['product_id']; ?>');"><span class="icon-heart"></span></a>
				<a class="icon is_compare" onclick="compare.add('<?php echo $product['product_id']; ?>');" data-toggle="tooltip" data-placement="<?php echo $tooltip_align; ?>" data-title="<?php echo $button_compare; ?>"><span class="icon-refresh"></span></a>
				<a class="icon is_quickview hidden-xs" onclick="quickview('<?php echo $product['product_id']; ?>');" data-toggle="tooltip" data-placement="<?php echo $tooltip_align; ?>" data-title="<?php echo $basel_button_quickview; ?>"><span class="icon-magnifier-add"></span></a>
			</div>
			<!-- .icons-wrapper -->
		</div>
		<!-- .image ends -->
		<div class="caption">
			<a class="product-name" href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
			<?php if ($product['rating']) { ?>      
				<div class="rating">
					<span class="rating_stars rating r<?php echo $product['rating']; ?>">
						<i class="fa fa-star-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i>
					</span>
				</div>
			<?php } ?>
			<div class="product-description">
				<?php echo $product['description']; ?>
			</div>
			<?php if ($product['options']) { ?>
				<div class="product-options">
					<?php foreach ($product['options'] as $option) { ?>
						<?php if ($option['type'] == 'select') { ?>
							<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> table-row">
								<div class="table-cell name">
									<label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
								</div>
								<div class="table-cell">
									<select name="option[<?php echo $option['product_option_id']; ?>]" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control">
										<option value=""><?php echo $text_select; ?></option>
										<?php foreach ($option['product_option_value'] as $option_value) { ?>
											<option value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
												<?php if ($option_value['price']) { ?>
													(<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
												<?php } ?>
											</option>
										<?php } ?>
									</select>
								</div>
							</div>
						<?php } ?>
						<?php if ($option['type'] == 'radio') { ?>
							<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
								<div class="radio-cell">
									<div id="input-option<?php echo $option['product_option_id']; ?>" class="btn-group" data-toggle="buttons">
										<?php $option_counter = 0; ?>
										<?php foreach ($option['product_option_value'] as $option_value) { ?>
											<label class="btn btn-default<?php echo ($option_counter == 0) ? ' active' : ''; ?>">
											<input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" <?php echo ($option_counter == 0) ? ' checked="checked"' : ''; ?> />
											<span class="name">
												<?php echo $option_value['name']; ?>
												<?php /* if ($option_value['price']) { ?>
												(<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
												<?php } */ ?>
											</span>
											</label>
											<?php $option_counter++; ?>
										<?php } ?>
									</div>
								</div>
							</div>
						<?php } ?>			
						<?php if ($option['type'] == 'checkbox') { ?>
							<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> table-row">
								<div class="table-cell checkbox-cell name">
									<label class="control-label"><?php echo $option['name']; ?></label>
								</div>
								<div class="table-cell checkbox-cell">
									<div id="input-option<?php echo $option['product_option_id']; ?>">
										<?php foreach ($option['product_option_value'] as $option_value) { ?>
											<div class="checkbox<?php if ($option_value['image']) echo ' has-image'; ?>">
												<label>
												<input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" />
												<?php if ($option_value['image']) { ?>
													<img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" data-toggle="tooltip" data-title="<?php echo $option_value['name']; ?><?php if ($option_value['price']) { ?> (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)<?php } ?>" /> 
												<?php } ?>
												<span class="name">
												<?php echo $option_value['name']; ?>
												<?php if ($option_value['price']) { ?>
													(<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
												<?php } ?>
												</span>
												</label>
											</div>
										<?php } ?>
									</div>
								</div>
							</div>
						<?php } ?>
						<?php if ($option['type'] == 'text') { ?>
							<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> table-row">
								<div class="table-cell name">
									<label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
								</div>
								<div class="table-cell">
									<input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
								</div>
							</div>
						<?php } ?>
						<?php if ($option['type'] == 'textarea') { ?>
							<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> table-row">
								<div class="table-cell name">
									<label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
								</div>
								<div class="table-cell">
									<textarea name="option[<?php echo $option['product_option_id']; ?>]" rows="5" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control"><?php echo $option['value']; ?></textarea>
								</div>
							</div>
						<?php } ?>
						<?php if ($option['type'] == 'file') { ?>
							<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> table-row">
								<div class="table-cell name">
									<label class="control-label"><?php echo $option['name']; ?></label>
								</div>
								<div class="table-cell">
									<button type="button" id="button-upload<?php echo $option['product_option_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-default btn-block"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
									<input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" id="input-option<?php echo $option['product_option_id']; ?>" />
								</div>
							</div>
						<?php } ?>
						<?php if ($option['type'] == 'date') { ?>
							<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> table-row">
								<div class="table-cell name">
									<label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
								</div>
								<div class="table-cell">
									<div class="input-group date">
										<input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
										<span class="input-group-btn">
										<button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
										</span>
									</div>
								</div>
							</div>
						<?php } ?>
						<?php if ($option['type'] == 'datetime') { ?>
							<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> table-row">
								<div class="table-cell name">
									<label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
								</div>
								<div class="table-cell">
									<div class="input-group datetime">
										<input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
										<span class="input-group-btn">
										<button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
										</span>
									</div>
								</div>
							</div>
						<?php } ?>
						<?php if ($option['type'] == 'time') { ?>
							<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> table-row">
								<div class="table-cell name">
									<label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
								</div>
								<div class="table-cell">
									<div class="input-group time">
										<input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
										<span class="input-group-btn">
										<button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
										</span>
									</div>
								</div>
							</div>
						<?php } ?>
					<?php } ?> <!-- foreach option -->
				</div>
			<?php } ?>
			<div class="price-wrapper">
				<?php if ($product['price']) { ?>
					<div class="price">
						<?php if (!$product['special']) { ?>
							<span class="price-regular"><?php echo $product['price']; ?></span>
						<?php } else { ?>
							<span class="price-old"><?php echo $product['price']; ?></span><span class="price-new"><?php echo $product['special']; ?></span>
						<?php } ?>
						<?php if ($product['tax']) { ?>
							<span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
						<?php } ?>
					</div>
					<!-- .price -->
				<?php } ?>
				<input type="hidden" name="quantity" value="<?php echo $product['minimum']; ?>" />
				<input type="hidden" name="product_id" value="<?php echo $product['product_id']; ?>" />				
				<?php /* <p class="description"><?php if (isset($product['description'])) echo $product['description']; ?></p> */ ?>
				<a class="btn btn_catalog_cart catalog_hide <?php if ($basel_list_style == '6') { echo 'btn-contrast'; } else { echo 'btn-outline';} ?>" onclick="cart.add('<?php echo $product['product_id']; ?>', '<?php echo $product['minimum']; ?>');"><span class="global-cart"></span><?php echo $button_cart; ?></a>
			</div>
			<!-- .price-wrapper -->
			<div class="plain-links">
				<a class="icon is_wishlist link-hover-color" onclick="wishlist.add('<?php echo $product['product_id']; ?>');"><span class="icon-heart"></span> <?php echo $button_wishlist; ?></a>
				<a class="icon is_compare link-hover-color" onclick="compare.add('<?php echo $product['product_id']; ?>');"><span class="icon-refresh"></span> <?php echo $button_compare; ?></a>
				<a class="icon is_quickview link-hover-color" onclick="quickview('<?php echo $product['product_id']; ?>');"><span class="icon-magnifier-add"></span> <?php echo $basel_button_quickview; ?></a>
			</div>
			<!-- .plain-links-->
		</div>
		<!-- .caption-->
	</div>
	<?php if ($product['sale_end_date'] && $countdown_status) { ?>
		<script>
			$(function() {
			$(".sale-counter.id<?php echo $product['product_id']; ?>").countdown("<?php echo $product['sale_end_date']; ?>").on('update.countdown', function(event) {
			var $this = $(this).html(event.strftime(''
			  + '<div>'
			  + '%D<i><?php echo $basel_text_days; ?></i></div><div>'
			  + '%H <i><?php echo $basel_text_hours; ?></i></div><div>'
			  + '%M <i><?php echo $basel_text_mins; ?></i></div><div>'
			  + '%S <i><?php echo $basel_text_secs; ?></i></div></div>'));
			});
			});
		</script>
	<?php } ?>
</div>
<!-- .single-product ends -->