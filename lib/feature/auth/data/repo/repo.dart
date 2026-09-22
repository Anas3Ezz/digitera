import 'package:digitira/core/networking/api_constant.dart';
import 'package:digitira/core/networking/api_error_handler.dart';
import 'package:digitira/core/networking/api_result.dart';
import 'package:digitira/feature/auth/data/model/login_request_model.dart';
import 'package:digitira/feature/auth/data/model/register_request_model.dart';
import 'package:dio/dio.dart';

class LoginRepo{
  final Dio _dio;
  LoginRepo(this._dio);


Future<ApiResult> login(LoginRequestModel loginRequestModel)async{
  try {
    final response = await _dio.post(ApiConstants.login,
    data: loginRequestModel.toJson()
    );

    return Sucess(response.data['message']);
    
  }on DioException catch (e) {
    return Error(ApiErrorHandler.handle(e).message);

  }
}
}

class RegisterRepo{
  final Dio _dio;
  RegisterRepo(this._dio);

Future<ApiResult> register(RegisterRequestModel registerRequestModel)async{
  try {
    final response = await _dio.post(ApiConstants.register,
    data: registerRequestModel.toJson()
    );

    return Sucess(response.data['message']);

  }on DioException catch (e) {
    return Error(ApiErrorHandler.handle(e).message);

  }
}
}