<?php if ($error_warning) { ?>
    <div class="alert alert-danger"><?php echo $error_warning; ?></div>
<?php } ?>
<?php if ($shipping_methods) { ?>
    <?php if ($shipping) { ?>
        <div class="quickcheckout-content">
            <?php foreach ($shipping_methods as $key => $shipping_method) { ?>
                <?php if (!$shipping_method['error']) { ?>
                    <?php foreach ($shipping_method['quote'] as $quote) { ?>
                        <div class="quickcheckout-method">
                            <?php if ($quote['code'] == $code) { ?>
                                <input type="radio" name="shipping_method" value="<?php echo $quote['code']; ?>" id="<?php echo $quote['code']; ?>" checked="checked" />
                            <?php } else { ?>
                                <input type="radio" name="shipping_method" value="<?php echo $quote['code']; ?>" id="<?php echo $quote['code']; ?>" />
                            <?php } ?>
                            <label for="<?php echo $quote['code']; ?>" data-address="<?php echo isset($quote['address']) ? htmlspecialchars($quote['address'], ENT_QUOTES, 'UTF-8') : ''; ?>">
                                <?php if (!empty($shipping_logo[$key])) { ?>
                                    <img src="<?php echo $shipping_logo[$key]; ?>" alt="<?php echo $shipping_method['title']; ?>" title="<?php echo $shipping_method['title']; ?>" />
                                <?php } ?>
                                <?php echo $quote['title']; ?>
                            </label>
                        </div>
                    <?php } ?>
                <?php } else { ?>
                    <div class="error"><?php echo $shipping_method['error']; ?></div>
                <?php } ?>
            <?php } ?>
        </div>
    <?php } else { ?>
        <select name="shipping_method" class="form-control">
            <?php foreach ($shipping_methods as $shipping_method) { ?>
                <?php if (!$shipping_method['error']) { ?>
                    <?php foreach ($shipping_method['quote'] as $quote) { ?>
                        <?php if ($quote['code'] == $code) { ?>
                            <?php $code = $quote['code']; ?>
                            <?php $exists = true; ?>
                            <option value="<?php echo $quote['code']; ?>" selected="selected">
                            <?php } else { ?>
                            <option value="<?php echo $quote['code']; ?>">
                            <?php } ?>
                            <?php echo $quote['title']; ?>&nbsp;&nbsp;(<?php echo $quote['text']; ?>) </option>
                        <?php } ?>
                    <?php } ?>
                <?php } ?>
        </select><br />
    <?php } ?>
    <?php if ($delivery && (!$delivery_delivery_time || $delivery_delivery_time == '1' || $delivery_delivery_time == '3')) { ?>
        <div <?php echo $delivery_required ? ' class="required"' : ''; ?> style="position:relative">
            <label id="delivery_label" class="control-label"><strong><?php echo $text_delivery; ?></strong></label>
            <label id="pickup_label" class="control-label hidden"><strong><?php echo $text_pickup_date; ?></strong></label>
            <?php if ($delivery_delivery_time == '1') { ?>
                <input type="text" name="delivery_date" value="<?php echo $delivery_date; ?>" class="form-control date" readonly="true" style="background:#ffffff;" />
            <?php } else { ?>
                <input type="text" name="delivery_date" value="<?php echo $delivery_date; ?>" class="form-control date" readonly="true" style="background:#ffffff;" />
            <?php } ?>
            <?php if ($delivery_delivery_time == '3') { ?><br />
                <select name="delivery_time" class="form-control"><?php foreach ($delivery_times as $quickcheckout_delivery_time) { ?>
                        <?php if (!empty($quickcheckout_delivery_time[$language_id])) { ?>
                            <?php if ($delivery_time == $quickcheckout_delivery_time[$language_id]) { ?>
                                <option value="<?php echo $quickcheckout_delivery_time[$language_id]; ?>" selected="selected"><?php echo $quickcheckout_delivery_time[$language_id]; ?></option>
                            <?php } else { ?>
                                <option value="<?php echo $quickcheckout_delivery_time[$language_id]; ?>"><?php echo $quickcheckout_delivery_time[$language_id]; ?></option>
                            <?php } ?>
                        <?php } ?>
                    <?php } ?>
                </select>
            <?php } ?>
        </div>
    <?php } elseif ($delivery_delivery_time && $delivery_delivery_time == '2') { ?>
        <input type="text" name="delivery_date" value="" class="hide" />
        <select name="delivery_time" class="hide">
            <option value=""></option>
        </select>
        <strong><?php echo $text_estimated_delivery; ?></strong><br />
        <?php echo $estimated_delivery; ?><br />
        <?php echo $estimated_delivery_time; ?>
    <?php } else { ?>
        <input type="text" name="delivery_date" value="" class="hide" />
        <select name="delivery_time" class="hide">
            <option value=""></option>
        </select>
    <?php } ?>
    <br />
<?php } ?>

<script type="text/javascript">
    <!--
    // Store original address1 values for both shipping and payment
    var originalShippingAddress1 = $('#input-shipping-address-1').val();
    var originalPaymentAddress1 = $('#input-payment-address-1').val();

    // Function to toggle and fill address fields based on shipping method
    function toggleAddressFields() {
        var shippingMethod = $('input[name=\'shipping_method\']:checked').val() || $('select[name=\'shipping_method\']').val();
        var isPickup = shippingMethod && (shippingMethod.indexOf('pickup') !== -1);

        // Address fields only (city is managed by module settings)
        var shippingAddressField = $('#input-shipping-address-1');
        var paymentAddressField = $('#input-payment-address-1');

        // Labels for delivery type
        var deliveryLabel = $('#delivery_label');
        var pickupLabel = $('#pickup_label');

        if (isPickup) {
            // Get pickup address from data-address attribute of the label
            var label = $('label[for="' + shippingMethod + '"]');
            var pickupAddress = label.data('address') || '';

            // Shipping address field
            shippingAddressField.val(pickupAddress);
            shippingAddressField.prop('disabled', true).addClass('disabled');

            // Payment address field
            paymentAddressField.val(pickupAddress);
            paymentAddressField.prop('disabled', true).addClass('disabled');

            // Show pickup label, hide delivery label
            deliveryLabel.addClass('hidden');
            pickupLabel.removeClass('hidden');
        } else {
            // Enable and restore original values
            shippingAddressField.prop('disabled', false).removeClass('disabled');
            shippingAddressField.val(originalShippingAddress1);

            paymentAddressField.prop('disabled', false).removeClass('disabled');
            paymentAddressField.val(originalPaymentAddress1);

            // Show delivery label, hide pickup label
            deliveryLabel.removeClass('hidden');
            pickupLabel.addClass('hidden');
        }
    }

    $('#shipping-method input[name=\'shipping_method\'], #shipping-method select[name=\'shipping_method\']').on('change', function() {
        // Toggle address fields first
        toggleAddressFields();

        <?php if (!$logged) { ?>
            if ($('#payment-address input[name=\'shipping_address\']:checked').val()) {
                var post_data = $('#payment-address input[type=\'text\'], #payment-address input[type=\'checkbox\']:checked, #payment-address input[type=\'radio\']:checked, #payment-address input[type=\'hidden\'], #payment-address select, #shipping-method input[type=\'text\'], #shipping-method input[type=\'checkbox\']:checked, #shipping-method input[type=\'radio\']:checked, #shipping-method input[type=\'hidden\'], #shipping-method select, #shipping-method textarea');
            } else {
                var post_data = $('#shipping-address input[type=\'text\'], #shipping-address input[type=\'checkbox\']:checked, #shipping-address input[type=\'radio\']:checked, #shipping-address input[type=\'hidden\'], #shipping-address select, #shipping-method input[type=\'text\'], #shipping-method input[type=\'checkbox\']:checked, #shipping-method input[type=\'radio\']:checked, #shipping-method input[type=\'hidden\'], #shipping-method select, #shipping-method textarea');
            }

            $.ajax({
                url: 'index.php?route=quickcheckout/shipping_method/set',
                type: 'post',
                data: post_data,
                dataType: 'html',
                cache: false,
                success: function(html) {
                    <?php if ($cart) { ?>
                        loadCart();
                    <?php } ?>

                    <?php if ($shipping_reload) { ?>
                        reloadPaymentMethod();
                    <?php } ?>
                },
                <?php if ($debug) { ?>
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    }
                <?php } ?>
            });
        <?php } else { ?>
            if ($('#shipping-address input[name=\'shipping_address\']:checked').val() == 'new') {
                var url = 'index.php?route=quickcheckout/shipping_method/set';
                var post_data = $('#shipping-address input[type=\'text\'], #shipping-address input[type=\'checkbox\']:checked, #shipping-address input[type=\'radio\']:checked, #shipping-address input[type=\'hidden\'], #shipping-address select, #shipping-method input[type=\'text\'], #shipping-method input[type=\'checkbox\']:checked, #shipping-method input[type=\'radio\']:checked, #shipping-method input[type=\'hidden\'], #shipping-method select, #shipping-method textarea');
            } else {
                var url = 'index.php?route=quickcheckout/shipping_method/set&address_id=' + $('#shipping-address select[name=\'address_id\']').val();
                var post_data = $('#shipping-method input[type=\'text\'], #shipping-method input[type=\'checkbox\']:checked, #shipping-method input[type=\'radio\']:checked, #shipping-method input[type=\'hidden\'], #shipping-method select, #shipping-method textarea');
            }

            $.ajax({
                url: url,
                type: 'post',
                data: post_data,
                dataType: 'html',
                cache: false,
                success: function(html) {
                    <?php if ($cart) { ?>
                        loadCart();
                    <?php } ?>

                    <?php if ($shipping_reload) { ?>
                        if ($('#payment-address input[name=\'payment_address\']').val() == 'new') {
                            reloadPaymentMethod();
                        } else {
                            reloadPaymentMethodById($('#payment-address select[name=\'address_id\']').val());
                        }
                    <?php } ?>
                },
                <?php if ($debug) { ?>
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    }
                <?php } ?>
            });
        <?php } ?>
    });

    $(document).ready(function() {
        // Initial check on page load - fill/disable fields if pickup is pre-selected

        $('#shipping-method input[name=\'shipping_method\']:checked, #shipping-method select[name=\'shipping_method\']').trigger('change');
    });

    <?php if ($delivery && $delivery_delivery_time == '1') { ?>
        $(document).ready(function() {
            // Parse enabledHours from PHP
            var hoursStr = '<?php echo $hours; ?>';
            var enabledHours = hoursStr ? hoursStr.split(',').map(Number) : [0, 23];
            var maxHour = Math.max.apply(null, enabledHours);
            var minHour = Math.min.apply(null, enabledHours);

            // Calculate minimum time: current time + 5 minutes, rounded to next 5-minute interval
            var now = new Date();
            now.setMinutes(now.getMinutes() + 5);

            var minutes = now.getMinutes();
            var roundedMinutes = Math.ceil(minutes / 5) * 5;

            if (roundedMinutes >= 60) {
                now.setHours(now.getHours() + 1);
                roundedMinutes = 0;
            }

            now.setMinutes(roundedMinutes);
            now.setSeconds(0);

            // Check if the resulting hour exceeds maxHour
            if (now.getHours() > maxHour) {
                // Set to next day at minHour:00
                now.setDate(now.getDate() + 1);
                now.setHours(minHour);
                now.setMinutes(0);
            }

            var minDateTime = moment(now).format('YYYY-MM-DD HH:mm');

            $('input[name=\'delivery_date\']').datetimepicker({
                format: 'YYYY-MM-DD HH:mm',
                locale: 'ru',
                minDate: minDateTime,
                maxDate: '<?php echo $delivery_max; ?>',
                disabledDates: [<?php echo $delivery_unavailable; ?>],
                enabledHours: [<?php echo $hours; ?>],
                ignoreReadonly: true,
                <?php if ($delivery_days_of_week != '') { ?>
                    daysOfWeekDisabled: [<?php echo $delivery_days_of_week; ?>]
                <?php } ?>
            });
        });
    <?php } elseif ($delivery && ($delivery_delivery_time == '3' || $delivery_delivery_time == '0')) { ?>
        $('input[name=\'delivery_date\']').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'ru',
            minDate: '<?php echo $delivery_min; ?>',
            maxDate: '<?php echo $delivery_max; ?>',
            disabledDates: [<?php echo $delivery_unavailable; ?>],
            ignoreReadonly: true,
            <?php if ($delivery_days_of_week != '') { ?>
                daysOfWeekDisabled: [<?php echo $delivery_days_of_week; ?>]
            <?php } ?>
        });
    <?php } ?>
    //
    -->
</script>