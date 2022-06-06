@extends('adminlte::page')

@section('title', 'Dashboard')

@section('content_header')
    <h1>Create admin</h1>
@stop

@section('content')
<main class="main">
    <ol class="breadcrumb">
        <li class="breadcrumb-item">Home</li>
        <li class="breadcrumb-item active">Admin</li>
    </ol>
    <div class="container-fluid">
        <div class="animated fadeIn">
          
          	<!-- TAMBAHKAN ENCTYPE="" KETIKA MENGIRIMKAN FILE PADA FORM -->
            <form action="{{ url('simpan/admin') }}" method="post" enctype="multipart/form-data" >
                @csrf
                <div class="row">
                    <div class="col-md-8 " style="align-self:center;">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">Tambah admin</h4>
                                
                            </div>
                            <div class="card-body">
                                <div class="form-group">
                                    <label for="name">Nama</label>
                                    <input type="text" name="name" class="form-control" required>
                                    <p class="text-danger">{{ $errors->first('name') }}</p>
                                </div>
                                <div class="form-group">
                                    <label for="name">Email</label>
                                    <input type="text" name="email" class="form-control"  required>
                                    <p class="text-danger">{{ $errors->first('email') }}</p>
                                </div>
                                <div class="form-group">
                                    <label for="name">Password</label>
                                    <input type="text" name="password" class="form-control" required>
                                    <p class="text-danger">{{ $errors->first('password') }}</p>
                                </div>
                                
                                <div class="form-group">
                                    <button type="submit" class="btn btn-primary btn-succes">Simpan</button>
                                </div>
                            </div>
                        </div>
                    </div>
      
                    </div>
                               
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</main>
@stop

@section('css')
    <link rel="stylesheet" href="/css/admin_custom.css">
@stop

@section('js')
    <script src="https://cdn.ckeditor.com/4.13.0/standard/ckeditor.js"></script>
    <script>
        //TERAPKAN CKEDITOR PADA TEXTAREA DENGAN ID DESCRIPTION
        CKEDITOR.replace('description');
    </script>
    <script> console.log('Hi!'); </script>
@stop
