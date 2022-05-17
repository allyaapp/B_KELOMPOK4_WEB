<?php $__env->startSection('title', 'Dashboard'); ?>

<?php $__env->startSection('content_header'); ?>
    <h1>Pesanan</h1>
<?php $__env->stopSection(); ?>

<?php $__env->startSection('content'); ?>
<main class="main">
    <ol class="breadcrumb">
        <li class="breadcrumb-item">Home</li>
        <li class="breadcrumb-item active">Orders</li>
    </ol>
    <div class="container-fluid">
        <div class="animated fadeIn">
            <div class="row">
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-header">
                            <h4 class="card-title">
                                Daftar Pesanan
                            </h4>
                        </div>
                        <div class="card-body">
                            <?php if(session('success')): ?>
                                <div class="alert alert-success"><?php echo e(session('success')); ?></div>
                            <?php endif; ?>

                            <?php if(session('error')): ?>
                                <div class="alert alert-danger"><?php echo e(session('error')); ?></div>
                            <?php endif; ?>

                            <form action="" method="get">
                                <div class="input-group mb-3 col-md-6 float-right">
                                    <select name="status" class="form-control mr-3">
                                        <option value="">Pilih Status</option>
                                        <option value="0">Baru</option>
                                        <option value="1">Confirm</option>
                                        <option value="2">Proses</option>
                                        <option value="3">Dikirim</option>
                                        <option value="4">Selesai</option>
                                    </select>
                                    <input type="text" name="q" class="form-control" placeholder="Cari..." value="<?php echo e(request()->q); ?>">
                                    <div class="input-group-append">
                                        <button class="btn btn-secondary" type="submit">Cari</button>
                                    </div>
                                </div>
                            </form>
                            <div class="table-responsive">
                                <table class="table table-hover table-bordered">
                                    <thead>
                                        <tr>
                                            <th>InvoiceID</th>
                                            <th>Pelanggan</th>
                                            <th>Subtotal</th>
                                            <th>Tanggal</th>
                                            <th>Status</th>
                                            <th>Aksi</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php $__empty_1 = true; $__currentLoopData = $orders; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $row): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); $__empty_1 = false; ?>
                                        <tr>
                                            <td><strong><?php echo e($row->invoice); ?></strong></td>
                                            <td>
                                                <strong><?php echo e($row->customer_name); ?></strong><br>
                                                <label><strong>Telp:</strong> <?php echo e($row->customer_phone); ?></label><br>
                                                <label><strong>Alamat:</strong> <?php echo e($row->customer_address); ?> <?php echo e($row->customer->district->name); ?> - <?php echo e($row->citie->name); ?>, <?php echo e($row->citie->postal_code); ?></label>
                                            </td>
                                            <td>Rp <?php echo e(number_format($row->subtotal)); ?></td>
                                            <td><?php echo e($row->created_at->format('d-m-Y')); ?></td>
                                            <td>
                                                <?php if($row->status == 0): ?>
                                                    <span class="badge badge-secondary">Baru</span>
                                                <?php elseif($row->status == 1): ?>
                                                    <span class="badge badge-primary">Dikonfirmasi</span>
                                                <?php elseif($row->status == 2): ?>
                                                    <span class="badge badge-info">Proses</span>
                                                <?php elseif($row->status == 3): ?>
                                                    <span class="badge badge-warning">Dikirim</span>
                                                <?php elseif($row->status == 4): ?>
                                                    <span class="badge badge-success">Selesai</span>
                                                <?php endif; ?>
                                            </td>
                                            <td>
                                                <?php if($row->status == 0): ?>

                                                    <button class="btn btn-secondary btn-sm">Baru</button><br><br>
                                                    <a class="btn btn-danger" href="/costumer/pdf/<?php echo e($row->id); ?> ">View invoice</a>
                                                <?php elseif($row->status == 1): ?>
                                                    <button class="btn btn-primary btn-sm">Dikonfirmasi</button><br>
                                                    <form action="update/<?php echo e($row->id); ?> " method="post">
                                                        <?php echo csrf_field(); ?>
                                                        <input type="hidden" name="status" value="2">
                                                        <button class="btn btn-success btn-sm" type="submit">Update ke Proses</button>
                                                    </form>
                                                <?php elseif($row->status == 2): ?>
                                                    <form action="update/<?php echo e($row->id); ?> " method="post">
                                                        <?php echo csrf_field(); ?>
                                                        <input type="hidden" name="status" value="3">
                                                        <button class="btn btn-info btn-sm" type="submit">Update ke Dikirim</button>
                                                    </form>
                                                <?php elseif($row->status == 3): ?>
                                                    <button class="btn btn-danger btn-sm" type="submit">Tunggu custommer update ke Selesai</button>
                                                <?php elseif($row->status == 4): ?>
                                                    <form action="destroy/<?php echo e($row->id); ?>" method="post">
                                                        <?php echo csrf_field(); ?>
                                                        <?php echo method_field('DELETE'); ?>

                                                        <button class="btn btn-warning btn-sm" disabled>selesai</button>
                                                        <button class="btn btn-danger btn-sm">Hapus</button>
                                                    </form>
                                                <?php endif; ?>
                                            </td>
                                        </tr>
                                        <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); if ($__empty_1): ?>
                                        <tr>
                                            <td colspan="6" class="text-center">Tidak ada data</td>
                                        </tr>
                                        <?php endif; ?>
                                    </tbody>
                                </table>
                            </div>
                            <?php echo $orders->links(); ?>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>
<?php $__env->stopSection(); ?>

<?php echo $__env->make('adminlte::page', \Illuminate\Support\Arr::except(get_defined_vars(), ['__data', '__path']))->render(); ?><?php /**PATH C:\xampp\New folder\htdocs\Aplikasi_Penjualan\resources\views/orders/index.blade.php ENDPATH**/ ?>