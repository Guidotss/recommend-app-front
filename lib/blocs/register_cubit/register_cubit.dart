import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterFormState> {
  RegisterCubit() : super(const RegisterFormState());

  void updateName(String value) {
    emit(state.copyWith(name: value));
  }

  void updateLastName(String value) {
    emit(state.copyWith(lastName: value));
  }

  void updateEmail(String value) {
    emit(state.copyWith(email: value));
  }

  void updatePassword(String value) {
    emit(state.copyWith(password: value));
  }

  void register() {
    emit(state.copyWith(status: RegisterFormStatus.loading));
    try {
      print("name: ${state.name}");
      print("lastName: ${state.lastName}");
      print("email: ${state.email}");
      print("password: ${state.password}");
    } catch (err) {
      emit(state.copyWith(
          status: RegisterFormStatus.failure, errorMessage: err.toString()));
    }
  }
}
