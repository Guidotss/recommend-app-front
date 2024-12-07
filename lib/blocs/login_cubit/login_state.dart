part of 'login_cubit.dart';

enum LoginFormStatus { initial, loading, success, failure }

class LoginFormState {
  final LoginFormStatus status;
  final String? errorMessage;
  final String? email;
  final String? password;

  LoginFormState({
    this.status = LoginFormStatus.initial,
    this.errorMessage,
    this.email,
    this.password,
  });

  LoginFormState copyWith({
    LoginFormStatus? status,
    String? errorMessage,
    String? email,
    String? password,
  }) =>
      LoginFormState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        email: email ?? this.email,
        password: password ?? this.password,
      );

  @override
  List<Object?> get props => [status, errorMessage, email, password];
}

class LoginInitial extends LoginFormState {}
