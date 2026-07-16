<?php echo $header; ?>
<div class="container">
    <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
            <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
    </ul>

    <?php if ($attention) { ?>
        <div class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $attention; ?>
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
    <?php } ?>
    <?php if ($success) { ?>
        <div class="alert alert-success"><i class="fa fa-check"></i> <?php echo $success; ?>
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
    <?php } ?>
    <div class="alert alert-danger" <?php echo ($error_warning) ? '' : ' style="display:none"'; ?>><i class="fa fa-exclamation-circle"></i> <?php echo ($error_warning) ? $error_warning : ''; ?>
        <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>

    <div class="row">

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
            <h1 id="page-title"><?php echo $heading_title; ?><?php if ($weight) { ?> (<?php echo $weight; ?>)<?php } ?></h1>
            <div class="cart-container">
                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="cart-form">
                    <div class="cart-table">
                        <!-- Header -->
                        <div class="cart-item cart-header hidden d-none ">
                            <div class="cart-cell hidden-xs hidden-sm"></div>
                            <div class="cart-cell hidden-xs hidden-sm"></div>
                            <div class="cart-cell"><?php echo $column_name; ?></div>
                            <div class="cart-cell hidden-xs hidden-sm hidden"><?php echo $column_model; ?></div>
                            <div class="cart-cell"><?php echo $column_quantity; ?></div>
                            <div class="cart-cell text-right hidden-xs hidden-sm"><?php echo $column_price; ?></div>
                            <div class="cart-cell text-right"><?php echo $column_total; ?></div>
                        </div>

                        <!-- Products -->
                        <?php foreach ($products as $product) { ?>
                            <div id="product_<?php echo $product['cart_id']; ?>" class="cart-item">
                                <div class="cart-cell data">
                                    <div class="cart-cell-inner image">
                                        <?php if ($product['thumb']) { ?>
                                            <a href="<?php echo $product['href']; ?>">
                                                <img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" />
                                            </a>
                                        <?php } ?>
                                    </div>
                                    <div class="cart-cell-inner name">
                                        <a class="product-name" href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>

                                        <span class="text-danger" <?php echo !$product['stock'] ? '' : ' style="display:none;"'; ?>>***</span>
                                        <div class="product-options">
                                            <?php if ($product['option']) { ?>
                                                <?php foreach ($product['option'] as $option) { ?>
                                                    <small><?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
                                                <?php } ?>
                                            <?php } ?>

                                            <?php if ($product['reward']) { ?><br /><small><?php echo $product['reward']; ?></small><?php } ?>
                                            <?php if ($product['recurring']) { ?><br /><span class="label label-info"><?php echo $text_recurring_item; ?></span> <small><?php echo $product['recurring']; ?></small><?php } ?>

                                            <small class="hidden d-none"><?php echo $column_model; ?>: <?php echo $product['model']; ?></small>
                                            <small class="hidden d-none"><?php echo $column_price; ?>: <?php echo $product['price']; ?></small>
                                        </div>

                                        <div class="price"><?php echo $column_price; ?>: <?php echo $product['price']; ?></div>
                                    </div>
                                </div>
                                <div class="cart-cell price-qty">
                                    <div class="cart-cell-inner quantity">
                                        <a onclick="cart.remove('<?php echo $product['cart_id']; ?>');" class="cart-product_remove">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash" viewBox="0 0 16 16">
                                                <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5m2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5m3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0z" />
                                                <path d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4zM2.5 3h11V2h-11z" />
                                            </svg>
                                        </a>
                                        <div class="number-input">
                                            <button type="button" class="btn-decrement"></button>
                                            <input
                                                type="number"
                                                min="1"
                                                max="999999"
                                                step="1"
                                                name="quantity[<?php echo $product['cart_id']; ?>]"
                                                value="<?php echo $product['quantity']; ?>"
                                                class="form-control qty-form" />
                                            <button type="button" class="btn-increment"></button>
                                        </div>
                                    </div>
                                    <div class="cart-cell-inner total"><?php echo $product['total']; ?></div>
                                </div>
                            </div>
                        <?php } ?>

                        <!-- Vouchers -->
                        <?php foreach ($vouchers as $voucher) { ?>
                            <div class="cart-item">
                                <div class="cart-cell text-center">
                                    <a onclick="voucher.remove('<?php echo $voucher['key']; ?>');" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="product-remove"><i class="fa fa-times"></i></a>
                                </div>
                                <div class="cart-cell" style="flex:2">
                                    <?php echo $voucher['description']; ?><br>
                                    <a class="btn btn-default btn-tiny" style="margin-top:5px;" onclick="voucher.remove('<?php echo $voucher['key']; ?>');"><?php echo $button_remove; ?></a>
                                </div>
                                <div class="cart-cell"></div>
                                <div class="cart-cell">
                                    <div class="input-group btn-block" style="max-width: 200px;">
                                        <input type="number" value="1" disabled="disabled" class="form-control qty-form" />
                                    </div>
                                </div>
                                <div class="cart-cell"></div>
                                <div class="cart-cell text-right"><?php echo $voucher['amount']; ?></div>
                            </div>
                        <?php } ?>
                    </div>

                    <div class="row mt-30 mb-30 hidden d-none">
                        <div class="col-xs-12 text-right">
                            <button type="submit" class="btn btn-primary"><?php echo $button_update; ?></button>
                        </div>
                    </div>
                </form>

                <div class="cart-wrapper">
                    <div class="cart-modules-wrapper hidden d-none">
                        <?php if ($modules) { ?>
                            <?php foreach ($modules as $module) { ?>
                                <div class="cart-module">
                                    <?php echo $module; ?>
                                </div>
                            <?php } ?>
                        <?php } ?>
                    </div>

                    <div class="totals-wrapper">
                        <div class="totals-list">
                            <?php foreach ($totals as $total) { ?>
                                <div id="<?php echo $total['code']; ?>" class="totals-item">
                                    <div class="totals-title"><b><?php echo $total['title']; ?>:</b></div>
                                    <div class="totals-text"><?php echo $total['text']; ?></div>
                                </div>
                            <?php } ?>
                        </div>
                        <a href="<?php echo $checkout; ?>" class="btn btn-primary"><?php echo $button_checkout; ?></a>
                    </div>
                </div>
            </div>

            <?php echo $content_bottom; ?>
        </div>
        <?php echo $column_right; ?>
    </div>
</div>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        const cartForm = document.querySelector('form[action="<?php echo $action; ?>"]');
        const cartQtyInputs = cartForm.querySelectorAll('input[name^="quantity["]');

        // Listen to any input change
        cartQtyInputs.forEach(function(cartQtyInput) {
            cartQtyInput.addEventListener('change', function() {
                console.log('Quantity changed: ' + this.value);
                cartUpdate();
            });
        });

        // Function to update cart via AJAX
        const cartUpdate = function() {
            const formData = new FormData(cartForm);
            console.log('Updating cart with data:', Array.from(formData.entries()));
            fetch('index.php?route=checkout/cart/ajaxUpdate', { // URL: index.php?route=checkout/cart/edit
                    method: 'POST',
                    body: formData,
                    headers: {
                        'X-Requested-With': 'XMLHttpRequest'
                    }
                })
                .then(response => response.json())
                .then(data => {
                    // Example: update total price element
                    console.log('Cart updated', data);
                    if (data.error_warning) {
                        // Find existing alert
                        let alertDiv = document.querySelector('.alert-danger');

                        // If not exists - create it
                        if (!alertDiv) {
                            alertDiv = document.createElement('div');
                            alertDiv.className = 'alert alert-danger';

                            // Add icon
                            let icon = document.createElement('i');
                            icon.className = 'fa fa-exclamation-circle';
                            alertDiv.appendChild(icon);
                            alertDiv.appendChild(document.createTextNode(' ')); // spacing

                            // Add text container
                            let textNode = document.createElement('span');
                            textNode.className = 'alert-text';
                            alertDiv.appendChild(textNode);

                            // Add close button
                            let closeBtn = document.createElement('button');
                            closeBtn.type = 'button';
                            closeBtn.className = 'close';
                            closeBtn.setAttribute('data-dismiss', 'alert');
                            closeBtn.innerHTML = '&times;';
                            alertDiv.appendChild(closeBtn);

                            // Insert before cartForm
                            cartForm.parentNode.insertBefore(alertDiv, cartForm);
                        }

                        // Update message text
                        let textNode = alertDiv.querySelector('.alert-text');
                        if (textNode) {
                            textNode.textContent = data.error_warning;
                        }

                        // Show alert
                        alertDiv.style.display = '';

                        // Scroll to top
                        window.scrollTo({
                            top: 0,
                            behavior: 'smooth'
                        });
                    } else {
                        // Hide alert if exists
                        let alertDiv = document.querySelector('.alert-danger');
                        if (alertDiv) {
                            alertDiv.style.display = 'none';
                        }
                    }
                    if (data.products) {
                        for (const [cart_id, product] of Object.entries(data.products)) {
                            const productRow = document.getElementById('product_' + cart_id);
                            if (productRow) {
                                // Update quantity input
                                const qtyInput = productRow.querySelector('input[name="quantity[' + cart_id + ']"]');
                                if (qtyInput) {
                                    qtyInput.value = product.quantity;
                                }
                                // Update total price
                                const totalDiv = productRow.querySelector('.cart-cell-inner.total');
                                if (totalDiv) {
                                    totalDiv.textContent = product.total;
                                }
                                // Show stock warning if out of stock
                                const stockWarning = productRow.querySelector('.text-danger');
                                if (stockWarning) {
                                    if (!product.stock) {
                                        stockWarning.style.display = '';
                                    } else {
                                        stockWarning.style.display = 'none';
                                    }
                                }
                            }
                        }
                    }
                    if (data.totals) {
                        for (const [code, total] of Object.entries(data.totals)) {
                            const totalRow = document.getElementById(code);
                            if (totalRow) {
                                const totalTextDiv = totalRow.querySelector('.totals-text');
                                if (totalTextDiv) {
                                    totalTextDiv.textContent = total.text;
                                }
                            }
                        }
                    }
                })
                .catch(err => console.error('Cart update error:', err));
        };
    });
</script>
<?php echo $footer; ?>