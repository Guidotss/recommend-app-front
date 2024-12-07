part of 'register_cubit.dart';

enum RegisterFormStatus { initial, loading, success, failure }

class RegisterFormState {
  final RegisterFormStatus status;
  final String? errorMessage;
  final String? name;
  final String? lastName;
  final String? email;
  final String? password;

  const RegisterFormState({
    this.status = RegisterFormStatus.initial,
    this.errorMessage,
    this.name,
    this.lastName,
    this.email,
    this.password,
  });

  RegisterFormState copyWith({
    RegisterFormStatus? status,
    String? errorMessage,
    String? name,
    String? lastName,
    String? email,
    String? password,
  }) =>
      RegisterFormState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        name: name ?? this.name,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        password: password ?? this.password,
      );

  @override
  List<Object?> get props =>
      [status, errorMessage, name, lastName, email, password];
}

final class RegisterFormInitial extends RegisterFormState {}
