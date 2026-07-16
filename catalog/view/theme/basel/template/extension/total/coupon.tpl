<div id="coupon_module" class="col-sm-6__">
    <h4 class="hidden d-none"><b><?php echo $heading_title; ?></b></h4>
    <div class="coupon-wrapper">
        <label class="control-label hidden d-none" for="input-coupon"><?php echo $entry_coupon; ?></label>
        <input type="text" name="coupon" value="<?php echo $coupon; ?>" placeholder="<?php echo $heading_title; ?>" id="input-coupon" class="coupon-input" />
        <button id="button-coupon" class="coupon-btn" data-loading-text="<?php echo $text_loading; ?>"></button>
    </div>

    <script>
        $('#button-coupon').on('click', function() {
            $.ajax({
                url: 'index.php?route=extension/total/coupon/coupon',
                type: 'post',
                data: 'coupon=' + encodeURIComponent($('input[name=\'coupon\']').val()),
                dataType: 'json',
                beforeSend: function() {
                    $('#button-coupon').button('loading');
                },
                complete: function() {
                    $('#button-coupon').button('reset');
                },
                success: function(json) {
                    $('.alert').remove();

                    if (json['error']) {
                        $('.breadcrumb').after('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');

                        $('html, body').animate({
                            scrollTop: 0
                        }, 'slow');
                    }

                    if (json['redirect']) {
                        location = json['redirect'];
                    }
                }
            });
        });
    </script>
</div>