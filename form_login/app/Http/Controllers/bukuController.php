<?php

namespace App\Http\Controllers;

use App\buku;
use Illuminate\Http\Request;
use PHP_Token_USE_FUNCTION;

class bukuController extends Controller
{
    public function index(){
        return view('layouts/buku');
    }

    public function kirim(){
        $buku = buku::all();
        return view('nn', compact('buku') );
    }

    public function create()
    {
        $model = new buku;
        return view('tabah.create', compact(
            'model'
        ));
    }    

    public function hapus($id){
        $buku = buku::find($id);
        $buku->delete();
        return redirect('buku');
    }
}
