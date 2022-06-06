<?php

use App\Http\Controllers\API\CategoryController;
use App\Http\Controllers\API\OrderController;
use App\Http\Controllers\API\ProductController;
use App\Http\Controllers\API\barangController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\CostumerRegistriController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::get('products', [barangController::class ,'index']);
Route::get('pesanan', [OrderController::class ,'index']);
Route::get('categories', [CategoryController::class ,'index']);
Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::get('city', [CostumerRegistriController::class, 'getCity']);
Route::get('district', [CostumerRegistriController::class, 'getDistrict']);
// Route::post('cost', 'Ecommerce\CartController@getCourier');

Route::get('Product','App\Http\Controllers\API\barangController@index');
