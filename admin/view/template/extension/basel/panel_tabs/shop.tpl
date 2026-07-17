<legend><?= $text_tab_shop ?></legend>

<div class="form-field new-form-group radio-switcher">
    <p class="radio-switcher-title">
        <span class="title"><?= $entry_theme_status ?></span>
    </p>

    <div class="form-group">
        <label class="col-sm-2 control-label" for="setting-theme-default-theme_default_directory">
            <span data-toggle="tooltip" title="" data-original-title="<?= $help_theme_status ?>"><?= $entry_theme_status ?></span>
        </label>
        <div class="col-sm-10">
            <label class="smp-switch" for="setting-theme-default-theme_default_directory">
                <input type="checkbox" role="switch" name="settings[theme_default][theme_default_directory]" value="1" id="setting-theme-default-theme_default_directory" />
                <span class="smp-switch-slider">
                    <span class="smp-switch-state smp-switch-state-on"><?= $text_enabled ?></span>
                    <span class="smp-switch-state smp-switch-state-off"><?= $text_disabled ?></span>
                </span>
            </label>
            <input type="hidden" name="settings[theme_default][theme_default_directory]" value="<?= $theme_default_directory ?>" />
        </div>
    </div>
    <script>
        $(document).ready(function() {
            var $checkbox = $('#setting-theme-default-theme_default_directory');
            var $hiddenInput = $('input[name="settings[theme_default][theme_default_directory]"][type="hidden"]');

            // Set the initial state of the checkbox based on the hidden input value
            if ($hiddenInput.val() === 'basel') {
                $checkbox.prop('checked', true);
            } else {
                $checkbox.prop('checked', false);
            }

            // Update the hidden input value when the checkbox state changes
            $checkbox.change(function() {
                if ($(this).is(':checked')) {
                    $hiddenInput.val('basel');
                } else {
                    $hiddenInput.val('default');
                }
            });
        });
    </script>
</div>

<input
    type="hidden"
    name="settings[config][config_theme]"
    value="default" />

<input
    type="hidden"
    name="settings[basel_version][basel_theme_version]"
    value="1.2.8.0" />

<?php
$contact_fields = $basel_contacts;
?>

<legend class="sub"><?= $text_contacts ?></legend>

<?php foreach ($contact_fields as $key) { ?>

    <?php
    $label_var = 'entry_' . $key;
    $tooltip_var = 'entry_' . $key . '_tooltip';

    $label = isset($$label_var) ? $$label_var : $key;
    $tooltip = isset($$tooltip_var) ? $$tooltip_var : '';
    $value = isset($$key) ? $$key : '';
    ?>

    <div class="form-group new-form-group">

        <label class="col-sm-2 control-label" for="setting-basel-<?= $key ?>">
            <?php if ($tooltip && trim($tooltip) !== '') { ?>
                <span class="title"><?= $label ?></span>
            <?php } else { ?>
                <?= $label ?>
            <?php } ?>

            <?php if ($tooltip && trim($tooltip) !== '') { ?>
                <i
                    class="bi bi-question-circle-fill"
                    data-toggle="tooltip"
                    title="<?= $tooltip ?>"></i>
            <?php } ?>
        </label>
        <div class="col-sm-10">
            <input
                class="form-control"
                name="settings[basel][<?= $key ?>]"
                value="<?= $value ?>"
                id="setting-basel-<?= $key ?>" />
        </div>
    </div>

<?php } ?>