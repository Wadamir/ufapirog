<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right">
				<button type="submit" form="form-xdtgmnotify" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
				<a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a>
			</div>
			<h1 style="display:block;font-size: 20px;"><?php echo $heading_title; ?></h1>
			<ul class="breadcrumb">
				<?php foreach ($breadcrumbs as $breadcrumb) { ?>
				<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
				<?php } ?>
			</ul>
		</div>
	</div>
	<div class="container-fluid">
		<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-xdtgmnotify" class="form-horizontal">
			<?php if ($error_warning) { ?>
				<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
					<button type="button" class="close" data-dismiss="alert">&times;</button>
				</div>
			<?php } ?>
			<?php if ($error_bot) { ?>
				<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_bot; ?>
					<button type="button" class="close" data-dismiss="alert">&times;</button>
				</div>
			<?php } ?>
			<?php if ($error_chat) { ?>
				<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_chat; ?>
					<button type="button" class="close" data-dismiss="alert">&times;</button>
				</div>
			<?php } ?>			
			<ul class="nav nav-tabs" style="margin-bottom:0;">
				<li class="active"><a href="#settings_main" data-toggle="tab"><?php echo $settings_main; ?></a></li>
				<li><a href="#text_tab_help" data-toggle="tab"><?php echo $text_tab_help; ?></a></li>
			</ul>
			<div class="tab-content">
				<div id="settings_main" class="tab-pane fade in active">
					<div class="col-xs-12" style="border: 1px solid #ddd; border-top: none;">
						<div class="form-group">
							<div class="col-md-6 col-xs-12">
								<label class="control-label" for="input-bot_field"><?php echo $entry_bot; ?></label>
								<input type="text" name="xdtgmnotify[bot]" placeholder="<?php echo $entry_bot; ?>" value="<?php echo isset($xdtgmnotify['bot']) ? $xdtgmnotify['bot'] : ''; ?>" id="input-bot_field" class="form-control" />
							</div>
							<div class="col-md-6 col-xs-12">
								<label class="control-label" for="input-chat_field"><?php echo $entry_chat; ?></label>
								<input type="text" name="xdtgmnotify[chat]" placeholder="<?php echo $entry_chat; ?>" value="<?php echo isset($xdtgmnotify['chat']) ? $xdtgmnotify['chat'] : ''; ?>" id="input-chat_field" class="form-control" />
							</div>
						</div>					
						<div class="form-group">
							<label class="col-sm-3 control-label"><?php echo $entry_xdtgmnotify_status; ?></label>
							<div class="col-sm-9">
								<select name="module_xdtgmnotify_status" class="form-control">
									<?php if ($module_xdtgmnotify_status == '1') { ?>
										<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
										<option value="0"><?php echo $text_disabled; ?></option>
									<?php } else { ?>
										<option value="1"><?php echo $text_enabled; ?></option>
										<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
									<?php } ?>
								</select>
							</div>
						</div>
					</div>
				</div>
				<div id="text_tab_help" class="tab-pane fade">
					<div class="col-xs-12" style="border: 1px solid #ddd; border-top: none;">
						<div class="h4 text-primary" style="margin-bottom:0;">
							<strong><?php echo $text_tab_help_title; ?></strong>
						</div>
						<div class="text_help" style="margin-top:2em;"><?php echo $text_help; ?></div>
						<hr />
						<div class="form-group">
							<label class="col-sm-3 control-label"><?php echo $entry_log_status; ?></label>
							<div class="col-sm-9">
								<select name="xdtgmnotify[log]" class="form-control">
									<?php if ($xdtgmnotify['log'] == '1') { ?>
										<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
										<option value="0"><?php echo $text_disabled; ?></option>
									<?php } else { ?>
										<option value="1"><?php echo $text_enabled; ?></option>
										<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
									<?php } ?>
								</select>
							</div>
						</div>	
						<div class="form-group">
							<div class="col-sm-12">
								<div class="well well-sm">
									<fieldset>
										<div class="panel-body">
											<textarea wrap="off" rows="15" readonly class="form-control"><?php echo $tgm_log ?></textarea>
										</div>
									</fieldset>
								</div>
							</div>
						</div>							
					</div>
				</div>
			</div>
		</form>
	</div>
	<script type="text/javascript"><!--
		$('#language a:first').tab('show');
		//-->
	</script>
</div>
<?php echo $footer; ?>