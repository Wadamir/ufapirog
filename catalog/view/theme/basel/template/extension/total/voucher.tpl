<div id="voucher_module" class="col-sm-6__">
    <h4 class="hidden d-none"><b><?php echo $heading_title; ?></b></h4>
    <div class="coupon-wrapper">
        <label class="control-label hidden d-none" for="input-voucher"><?php echo $entry_voucher; ?></label>
        <input type="text" name="voucher" value="<?php echo $voucher; ?>" placeholder="<?php echo $heading_title; ?>" id="input-voucher" class="coupon-input" />
        <button type="submit" id="button-voucher" class="coupon-btn"></button>
    </div>

    <script>
        <!--
        $('#button-voucher').on('click', function() {
            $.ajax({
                url: 'index.php?route=extension/total/voucher/voucher',
                type: 'post',
                data: 'voucher=' + encodeURIComponent($('input[name=\'voucher\']').val()),
                dataType: 'json',
                beforeSend: function() {
                    $('#button-voucher').button('loading');
                },
                complete: function() {
                    $('#button-voucher').button('reset');
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
        //
        -->
    </script>
</div>