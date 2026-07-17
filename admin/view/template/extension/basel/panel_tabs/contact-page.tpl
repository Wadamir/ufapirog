<legend><?= $text_tab_contact_page ?></legend>
<?php /*
<legend class="sub"><?= $text_show_contact_page ?></legend>
$matrix_rows = array();
foreach ($basel_contacts as $contact) {
    $label_var = 'entry_' . $contact;
    $label = isset($$label_var) ? $$label_var : $contact;
    $matrix_rows[$contact] = $label;
}

$matrix_columns = array();
foreach ($basel_resolutions as $resolution) {
    $label_var = 'text_show_' . $resolution;
    $label = isset($$label_var) ? $$label_var : $resolution;
    $matrix_columns[$resolution] = $label;
}
?>

<table class="table table-bordered__ matrix-table" style="max-width: 600px;">
    <thead>
        <tr>
            <th></th>
            <?php foreach ($matrix_columns as $column_label) { ?>
                <th class="text-center"><?= $column_label ?></th>
            <?php } ?>

        </tr>
    </thead>

    <tbody>

        <?php foreach ($matrix_rows as $row_key => $row_label) { ?>
            <tr>
                <th scope="row"><?= $row_label ?></th>

                <?php foreach ($matrix_columns as $column_key => $column_label) { ?>

                    <?php
                    $setting_key = $row_key . '_contact_page_' . $column_key;
                    $setting_value = isset($$setting_key) ? $$setting_key : 0;
                    ?>

                    <td class="text-center">

                        <input
                            type="hidden"
                            name="settings[basel][<?= $setting_key ?>]"
                            value="0" />

                        <input
                            type="checkbox"
                            name="settings[basel][<?= $setting_key ?>]"
                            value="1"
                            <?= $setting_value ? 'checked="checked"' : '' ?> />

                    </td>

                <?php } ?>

            </tr>
        <?php } ?>

    </tbody>
</table>
*/ ?>

<legend class="sub"><?= $text_contact_map ?></legend>
<div class="form-group new-form-group">
    <label class="col-sm-2 control-label"><?= $entry_map_layout ?></label>
    <div class="col-sm-10">
        <select name="settings[basel][basel_map_style]" class="form-control">
            <option value="0" <?php echo ($basel_map_style == '0') ? 'selected="selected"' : ''; ?>><?= $text_disabled ?></option>
            <option value="full_width" <?php echo ($basel_map_style == 'full_width') ? 'selected="selected"' : ''; ?>><?= $text_full_width ?></option>
        </select>
    </div>
</div>

<div class="form-group new-form-group">
    <label class="col-sm-2 control-label"><?= $entry_yandex_map; ?></label>
    <div class="col-sm-10">
        <input class="form-control" name="settings[basel][basel_yandex_map]" value="<?= !empty($basel_yandex_map) ? $basel_yandex_map : ''; ?>" />
    </div>
</div>

<br />

<div class="col-sm-offset-1">
    <div class="bs-callout bs-callout-info bs-callout-sm">
        <h4><?= $text_how_use_yandex_map; ?></h4>
        <p><?= $text_yandex_map_instruction; ?></p>
    </div>
</div>

<?php /*
<div class="form-group">
    <label class="col-sm-2 control-label">Map layout</label>
    <div class="col-sm-10">
    <select name="settings[basel][basel_map_style]" class="form-control">
    <option value="0"<?php if($basel_map_style == '0'){echo ' selected="selected"';} ?>>Disabled</option>
    <option value="full_width"<?php if($basel_map_style == 'full_width'){echo ' selected="selected"';} ?>>Full width</option>
    <option value="inline"<?php if($basel_map_style == 'inline'){echo ' selected="selected"';} ?>>Boxed</option>
	</select>
    </div>                   
</div>

<div class="form-group">
    <label class="col-sm-2 control-label">Location Latitude</label>
    <div class="col-sm-10">
    <input class="form-control" name="settings[basel][basel_map_lat]" value="<?php echo isset($basel_map_lat) ? $basel_map_lat : ''; ?>" />
    </div>                   
</div>

<div class="form-group">
    <label class="col-sm-2 control-label">Location Longitude</label>
    <div class="col-sm-10">
    <input class="form-control" name="settings[basel][basel_map_lon]" value="<?php echo isset($basel_map_lon) ? $basel_map_lon : ''; ?>" />
    </div>                   
</div>


<div class="form-group">
    <label class="col-sm-2 control-label">Map API key</label>
    <div class="col-sm-10">
    <input class="form-control" name="settings[basel][basel_map_api]" value="<?php echo isset($basel_map_api) ? $basel_map_api : ''; ?>" />
    </div>                   
</div>

<div class="col-sm-offset-2">
<div class="bs-callout bs-callout-info bs-callout-sm">
<h4>How to find your Latitude & Longitude</h4>
<p>1. Navigate to your location at <a href="http://maps.google.com/" target="_blank">http://maps.google.com/</a></p>
<p>2. Right click on your location, and select What's Here?</p>
<p style="margin-bottom:20px;">3. You will see a box at the bottom of the map with your address along with it's latitude/longitudeb</p>

<h4>How to get the Map API key?</h4>
<p>Please follow the instructions here <a href="https://developers.google.com/maps/documentation/javascript/get-api-key" target="_blank">https://developers.google.com/maps/documentation/javascript/get-api-key</a></p>
</div>
</div>
*/ ?>