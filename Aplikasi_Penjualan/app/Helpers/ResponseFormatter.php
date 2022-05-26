<?php

namespace App\Helpers;

class ResponseFormatter
{
  protected static $response = [
   
      'code' => 200,
      'message' => 'success',
      'data' => null
  ];

  public static function createAPI($code = null, $message= null ,$data= null){
    self::$response['code'] = $code;
    self::$response['message'] = $message;
    self::$response['data'] = $data;

    return response()->json(self::$response, self::$response['code']);
  }

  // public static function success($data = null, $message = null)
  // {
  //   self::$response['meta']['message'] = $message;
  //   self::$response['data'] = $data;

  //   return response()->json(self::$response, self::$response['code']);
  // }

  // public static function error($data = null, $message = null, $code = 400)
  // {
  //   self::$response['meta']['status'] = 'error';
  //   self::$response['meta']['code'] = $code;
  //   self::$response['meta']['message'] = $message;
  //   self::$response['data'] = $data;

  //   return response()->json(self::$response, self::$response['meta']['code']);
  // }

}