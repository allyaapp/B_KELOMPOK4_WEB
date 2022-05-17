<?php $__env->startSection('title'); ?>
    Produk
<?php $__env->stopSection(); ?>

<?php $__env->startSection('css'); ?>
    <link rel="stylesheet" href="<?php echo e(asset('assets/vendors/linericon/style.css')); ?>">
    <link rel="stylesheet" href="<?php echo e(asset('assets/vendors/nouislider/nouislider.min.css')); ?>">
<?php $__env->stopSection(); ?>

<?php $__env->startSection('produk'); ?>
active
<?php $__env->stopSection(); ?>

<?php $__env->startSection('main'); ?>
<section class="blog-banner-area" id="category">
    <div class="container h-100">
        <div class="blog-banner">
            <div class="text-center">
                <h1><?php echo e($product->name); ?></h1>
                <nav aria-label="breadcrumb" class="banner-breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="<?php echo e(route('front.index')); ?>">Home</a></li>
                        <li class="breadcrumb-item active" aria-current="page"><?php echo e($product->name); ?></li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</section>

<div class="product_image_area">
    <div class="container">
        <div class="row s_product_inner">
            <div class="col-lg-6">
                <div class="owl-carousel owl-theme s_Product_carousel">
                    <div class="single-prd-item">
                        <img class="img-fluid" src="<?php echo e(asset('storage/products/' . $product->image)); ?>" alt="<?php echo e($product->name); ?>">
                    </div>
                </div>
            </div>
            <div class="col-lg-5 offset-lg-1">
                <div class="s_product_text">
                    <h3><?php echo e($product->name); ?></h3>
                    <h2>Rp. <?php echo e(number_format($product->price)); ?></h2>
                    <ul class="list">
                        <li><a class="active" href="#"><span>Kategori</span> : <?php echo e($product->category->name); ?></a></li>
                        <li><a href="#"><span>Stok</span> : <?php echo e($product->stock); ?></a></li>
                        <li>
                            <?php if(Auth::guard('costumer')->check()): ?>
                                <form action="<?php echo e(route('home.addcart')); ?>" method="post">
                                    <?php echo csrf_field(); ?>
                                    <label for="qty"><span>Quantity</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</label>
                                        <div class="product_count">
                                            <input type="hidden" name="customer_id" value="<?php echo e(Auth::guard('costumer')->user()->id); ?>">
                                            <input type="hidden" name="product_id" value="<?php echo e($product->id); ?>">
                                            <input type="hidden" name="cart_price" value="<?php echo e($product->price); ?>">
                                            <input type="hidden" name="cart_weight" value="<?php echo e($product->weight); ?>">
                                                <input type="text" name="qty" id="sst" maxlength="12" value="1" title="Quantity:" class="input-text qty">
                                                <button onclick="var result = document.getElementById('sst'); var sst = result.value; if( !isNaN( sst )) result.value++;return false;"
                                                class="increase items-count" type="button"><i class="lnr lnr-chevron-up"></i></button>
                                                <button onclick="var result = document.getElementById('sst'); var sst = result.value; if( !isNaN( sst ) &amp;&amp; sst > 0 ) result.value--;return false;"
                                                class="reduced items-count" type="button"><i class="lnr lnr-chevron-down"></i></button>
                                        </div>
                                    <hr>
                                        <button class="button primary-btn" type="submit">Add to cart</button>
                                        <?php if(session('success')): ?>
                                        <div class="alert alert-success mt-2"><?php echo e(session('success')); ?></div>
                                        <?php endif; ?>
                                </form>
                            <?php else: ?>
                                <label for="qty"><span>Quantity</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</label>
                                <div class="product_count">
                                        <input type="text" name="qty" id="sst" maxlength="12" value="1" title="Quantity:" class="input-text qty">
                                        <button onclick="var result = document.getElementById('sst'); var sst = result.value; if( !isNaN( sst )) result.value++;return false;"
                                        class="increase items-count" type="button"><i class="lnr lnr-chevron-up"></i></button>
                                        <button onclick="var result = document.getElementById('sst'); var sst = result.value; if( !isNaN( sst ) &amp;&amp; sst > 0 ) result.value--;return false;"
                                        class="reduced items-count" type="button"><i class="lnr lnr-chevron-down"></i></button>
                                </div>

                        </li>
                            <hr>
                            <a class="button primary-btn" href=" <?php echo e(route('costumer.login')); ?> " >Add to cart</a>
                            <?php endif; ?>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

<section class="product_description_area">
    <div class="container">
        <ul class="nav nav-tabs" id="myTab" role="tablist">
            <li class="nav-item">
                <a class="nav-link active" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true">Description</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="profile"
                 aria-selected="false">Specification</a>
            </li>
        </ul>
        <div class="tab-content" id="myTabContent">
            <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
                <?php echo $product->description; ?>

            </div>
            <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
                <div class="table-responsive">
                    <table class="table">
                        <tbody>
                            <tr>
                                <td>
                                    <h5>Berat</h5>
                                </td>
                                <td>
                                    <h5><?php echo e($product->weight); ?> gr</h5>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <h5>Harga</h5>
                                </td>
                                <td>
                                    <h5>Rp. <?php echo e(number_format($product->price)); ?></h5>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <h5>Stok</h5>
                                </td>
                                <td>
                                    <h5><?php echo e(($product->stock)); ?></h5>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <h5>Kategori</h5>
                                </td>
                                <td>
                                    <h5><?php echo e($product->category->name); ?></h5>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</section>


<?php $__env->stopSection(); ?>

<?php $__env->startSection('js'); ?>
    <script src="<?php echo e(asset('assets/vendors/nice-select/jquery.nice-select.min.js')); ?>"></script>
<?php $__env->stopSection(); ?>

<?php echo $__env->make('layouts.layout', \Illuminate\Support\Arr::except(get_defined_vars(), ['__data', '__path']))->render(); ?><?php /**PATH C:\xampp\New folder\htdocs\Aplikasi_Penjualan\resources\views/costumer/show.blade.php ENDPATH**/ ?>