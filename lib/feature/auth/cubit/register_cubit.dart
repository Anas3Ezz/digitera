import 'package:bloc/bloc.dart';
import 'package:digitira/core/networking/api_result.dart';
import 'package:digitira/feature/auth/cubit/login_state.dart' show Status;
import 'package:digitira/feature/auth/cubit/register_state.dart';
import 'package:digitira/feature/auth/data/model/register_request_model.dart';
import 'package:digitira/feature/auth/data/repo/repo.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterRepo _registerRepo;

  RegisterCubit(this._registerRepo) : super(RegisterState(status: Status.initial));

  Future<void> register(RegisterRequestModel registerRequestModel) async {
    emit(state.copyWith(status: Status.loading));
    final response = await _registerRepo.register(registerRequestModel);
    switch (response) {
      case Sucess<dynamic>(data: final message):
        emit(state.copyWith(status: Status.sucess, message: message.toString()));
      case Error<dynamic>(error: final error):
        emit(state.copyWith(status: Status.error, message: error.toString()));
      default:
    }
  }
}
