<div class="widget<?php if ($menu_type == 1) { ?> hidden-sm hidden-xs horizontal-menu contrast-bg<?php } ?>">
    <div class="main-menu<?php if ($menu_type != 1) { ?> vertical vertical-menu-bg<?php } ?>">
    <?php if ($menu_type != 1) { ?><h4 class="menu-heading"><b><?php echo $heading_title; ?></b></h4><?php } ?>
        <ul class="categories<?php if ($menu_type != '1') { ?> vertical-menu-bg <?php } ?>">
            <?php foreach($menu as $key=> $row) { ?>
            <?php require('catalog/view/theme/basel/template/common/menus/mega_menu.tpl'); ?>
            <?php } ?>
        </ul>
    </div>
</div>