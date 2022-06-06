<?php

namespace App\Http\Controllers;

use App\Models\Customer;
use Illuminate\Foundation\Auth\AuthenticatesUsers;
use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;


class CostumersController extends Controller
{
    use AuthenticatesUsers;

    protected $redirectTo =  '/costumer/home';

    public function __construct()
    {
      $this->middleware('guest')->except('logout');
    }

    public function guard()
    {
     return Auth::guard('costumer');
    }

    public function showLoginForm(){
        if (Auth::guard('costumer')->check()) {
            return redirect('/costumer/home');
        }
        else {
            return view('costumerAuth.login');
        }
    }
    // public function tampil()
    // {
    //     // return view('admin/admin', [
    //     //     'user' => User::all()
    //     // ]);
    //     $user = Customer::all();
    //     return view('customer.customer' , compact('customer'));
    // }

    private function loginFailed(){
        return redirect()
            ->back()
            ->withInput()
            ->with('error','Login failed, please try again!');
    }

}
