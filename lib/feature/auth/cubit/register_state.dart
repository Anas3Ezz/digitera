import 'package:digitira/feature/auth/cubit/login_state.dart' show Status;

class RegisterState {
  final Status status;
  final String? message;

  RegisterState({required this.status, this.message});

  RegisterState copyWith({Status? status, String? message}) {
    return RegisterState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
