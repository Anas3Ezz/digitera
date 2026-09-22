import 'package:bloc/bloc.dart';
import 'package:digitira/core/networking/api_result.dart';
import 'package:digitira/feature/auth/cubit/login_state.dart';
import 'package:digitira/feature/auth/data/model/login_request_model.dart';
import 'package:digitira/feature/auth/data/repo/repo.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo _loginRepo;

  LoginCubit(this._loginRepo) : super(LoginState(status: Status.initial));

  Future<void> login(LoginRequestModel loginRequestModel) async{
    emit(state.copyWith(status: Status.loading));
    final response = await _loginRepo.login(loginRequestModel);
    switch (response) {
      case Sucess<dynamic>(data: final message):
      emit(state.copyWith(status: Status.sucess,message: message.toString()));
          case Error<dynamic>(error: final error):
                emit(state.copyWith(status: Status.error,message: error.toString()));
      default:
    }

  }
}
