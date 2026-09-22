import 'package:digitira/core/networking/api_constant.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';



class DioFactory {
 static late Dio _dio;

static getDio(){

  _dio= Dio(BaseOptions(
 baseUrl: ApiConstants.baseUrl,
  ));


 _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: kDebugMode,
    
      )
    );
    return _dio;
}


}