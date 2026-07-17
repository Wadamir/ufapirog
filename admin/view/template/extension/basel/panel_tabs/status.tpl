<legend><?= $text_status ?></legend>

<div class="form-group">
    <label class="col-sm-2 control-label">
        <span data-toggle="tooltip" title="<?= $help_theme_status ?>"><?= $entry_theme_status ?></span>
    </label>

    <div class="col-sm-10 toggle-btn">
        <label>
            <input
                type="radio"
                name="settings[theme_default][theme_default_directory]"
                value="default"
                <?= $theme_default_directory == 'default' ? 'checked="checked"' : '' ?> />
            <span><?= $text_disabled ?></span>
        </label>

        <label>
            <input
                type="radio"
                name="settings[theme_default][theme_default_directory]"
                value="basel"
                <?= $theme_default_directory == 'basel' ? 'checked="checked"' : '' ?> />
            <span><?= $text_enabled ?></span>
        </label>
    </div>

    <input
        type="hidden"
        name="settings[config][config_theme]"
        value="theme_default" />

    <input
        type="hidden"
        name="settings[basel_version][basel_theme_version]"
        value="1.2.8.0" />
</div>