<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;

class AdminController extends Controller
{
    public function index()
    {
        $products = User::orderBy('created_at', 'DESC')->paginate(8);

        return view('/admin', compact('products'));
    }
}
