<?php echo $header; ?>
<div id="ymap" class="map-full-width" style="margin-top:-40px;margin-bottom:40px"><script type="text/javascript" charset="utf-8" async src="https://api-maps.yandex.ru/services/constructor/1.0/js/?um=constructor%3Aa7235226c317e41622062b0d12e47081c2f0d974e7e70d9e032ead52f6566b1e&amp;width=100%25&amp;height=400&amp;lang=ru_RU&amp;scroll=true"></script></div>
<div class="container">
	<ul class="breadcrumb">
		<?php foreach ($breadcrumbs as $breadcrumb) { ?>
			<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
		<?php } ?>
	</ul>
	<div class="row">
		<?php if ($basel_map_lat & $basel_map_lon && $basel_map_style == "inline") { ?>
		<div id="gmap" class="col-sm-12 map-inline"></div>
		<?php } ?>
		<?php echo $column_left; ?>
		<?php if ($column_left && $column_right) { ?>
			<?php $class = 'col-sm-6'; ?>
		<?php } elseif ($column_left || $column_right) { ?>
			<?php $class = 'col-md-9 col-sm-8'; ?>
		<?php } else { ?>
			<?php $class = 'col-sm-12'; ?>
		<?php } ?>
		<div id="content" class="<?php echo $class; ?>">
			<?php echo $content_top; ?>
			<h1 id="page-title"><?php echo $heading_title; ?></h1>
			<div class="row">
				<div class="col-sm-6">
					<h3 class="lined-title lg margin-b30"><span><b><?php echo $heading_title; ?></b></span></h3>
					<?php if ($image) { ?>
						<div class="contact-image margin-b25"><img src="<?php echo $image; ?>" alt="<?php echo $store; ?>" title="<?php echo $store; ?>" /></div>
					<?php } ?>
					<div class="grid-holder margin-b20">
						<div class="item">
							<p class="contact-detail">
								<i class="icon-cursor icon"></i>
								<?php echo $address; ?>
								<?php /* if ($geocode) { ?>
								<a href="https://maps.google.com/maps?q=<?php echo urlencode($geocode); ?>&hl=<?php echo $geocode_hl; ?>&t=m&z=15" target="_blank"><i class="fa fa-map-marker"></i> <?php echo $button_map; ?></a>
								<?php } */ ?>
							</p>
						</div>
						<div class="item">
							<p class="contact-detail">
								<i class="icon-phone icon"></i>
								<a href="tel:<?php echo $telephone; ?>" target="_blank"><?php echo $telephone; ?></a>
								<?php if ($fax) { ?>
									<br /><?php echo $text_fax; ?>: <?php echo $fax; ?>
								<?php } ?>
							</p>
						</div>
						<?php if ($open) { ?>
							<div class="item">
								<p class="contact-detail">
									<i class="icon-clock icon"></i>
									<?php echo $open; ?>
								</p>
							</div>
						<?php } ?>						
					</div>
					<?php if ($comment) { ?>
						<div class="margin-b45">
							<h3 class="lined-title lg margin-b20"><span><b><?php echo $text_comment; ?></b></span></h3>
							<?php echo $comment; ?>
						</div>
					<?php } ?>
					<?php if ($locations) { ?>
						<h3 class="lined-title lg margin-b15"><span><b><?php echo $text_store; ?></b></span></h3>
						<div class="panel-group" id="accordion">
							<?php foreach ($locations as $location) { ?>
								<div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title"><a href="#collapse-location<?php echo $location['location_id']; ?>" class="accordion-toggle" data-toggle="collapse" data-parent="#accordion"><?php echo $location['name']; ?> <i class="fa fa-caret-down"></i></a></h4>
									</div>
									<div class="panel-collapse collapse" id="collapse-location<?php echo $location['location_id']; ?>">
										<div class="panel-body">
											<?php if ($location['image']) { ?>
												<div class="contact-image margin-b25">
													<img src="<?php echo $location['image']; ?>" alt="<?php echo $location['name']; ?>" title="<?php echo $location['name']; ?>" />
												</div>
											<?php } ?>
											<?php if ($location['comment']) { ?>
												<b><?php echo $text_comment; ?></b><br />
												<?php echo $location['comment']; ?><br /><br /><br />
											<?php } ?>
											<div class="grid-holder margin-b20">
												<div class="item">
													<p class="contact-detail">
														<i class="icon-cursor icon"></i>
														<?php echo $location['name']; ?><br />
														<?php echo $location['address']; ?>
														<?php if ($location['geocode']) { ?>
															<br /><a href="https://maps.google.com/maps?q=<?php echo urlencode($location['geocode']); ?>&hl=<?php echo $geocode_hl; ?>&t=m&z=15" target="_blank" class="inline-link"><i class="fa fa-map-marker"></i> <?php echo $button_map; ?></a>
														<?php } ?>
													</p>
												</div>
												<div class="item">
													<p class="contact-detail">
														<i class="icon-phone icon"></i>
														<?php echo $location['telephone']; ?>
														<?php if ($location['fax']) { ?>
															<br /><?php echo $text_fax; ?>: <?php echo $location['fax']; ?>
														<?php } ?>
													</p>
												</div>
												<?php if ($location['open']) { ?>
													<div class="item">
														<p class="contact-detail">
															<i class="icon-clock icon"></i>
															<?php echo $location['open']; ?>
														</p>
													</div>
												<?php } ?>
											</div>
										</div>
									</div>
								</div>
							<?php } ?>
						</div>
					<?php } ?>
				</div>			
				<div class="col-sm-6">
					<h3 class="lined-title lg margin-b35"><span><b><?php echo $text_contact; ?></b></span></h3>
					<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-vertical">
						<div class="row">
							<div class="form-group col-sm-6 required">
								<label for="input-name"><?php echo $entry_name; ?></label>
								<input type="text" name="name" value="<?php echo $name; ?>" id="input-name" class="form-control" />
								<?php if ($error_name) { ?>
									<div class="text-danger"><?php echo $error_name; ?></div>
								<?php } ?>
							</div>
							<div class="form-group col-sm-6 required">
								<label for="input-email"><?php echo $entry_email; ?></label>
								<input type="text" name="email" value="<?php echo $email; ?>" id="input-email" class="form-control" />
								<?php if ($error_email) { ?>
									<div class="text-danger"><?php echo $error_email; ?></div>
								<?php } ?>
							</div>
						</div>
						<div class="form-group required">
							<label for="input-enquiry"><?php echo $entry_enquiry; ?></label>
							<textarea name="enquiry" rows="5" id="input-enquiry" class="form-control"><?php echo $enquiry; ?></textarea>
							<?php if ($error_enquiry) { ?>
								<div class="text-danger"><?php echo $error_enquiry; ?></div>
							<?php } ?>
						</div>
						<?php echo $captcha; ?>						
                        <?php if ($text_agree) { ?>
                            <?php if ($error_agree) { ?>
								<div class="text-danger"><?php echo $error_agree; ?></div>
							<?php } ?>
                            <div class="buttons">
                              <div class="pull-right"><?php echo $text_agree; ?>
                                <?php if ($agree) { ?>
                                    <input type="checkbox" name="agree" value="1" checked="checked" />
                                <?php } else { ?>
                                    <input type="checkbox" name="agree" value="1" />
                                <?php } ?>
                                &nbsp;
                                <br />
                                <br />
                                <input type="submit" value="<?php echo $button_submit; ?>" class="btn btn-primary" />
                              </div>
                            </div>
                        <?php } else { ?>
                            <div class="buttons">
                              <div class="pull-right">
                                <input type="submit" value="<?php echo $button_submit; ?>" class="btn btn-primary" />
                              </div>
                            </div>
                        <?php } ?>
					</form>
				</div>
				<!-- .col-sm-6 ends -->
			</div>
			<!-- .row ends -->
			<?php echo $content_bottom; ?>
		</div>
		<?php echo $column_right; ?>
	</div>
</div>
<script>
	$(document).ready(function() {
		$(".to_form").click(function() {
		   $('html, body').animate({
			   scrollTop: ($(".form-vertical").offset().top - 200)
		   }, 1000);
		});
	});
</script>
<?php echo $footer; ?>