import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginFormState> {
  LoginCubit() : super(LoginFormState());

  void updateEmail(String value) {
    emit(state.copyWith(email: value));
  }

  void updatePassword(String value) {
    emit(state.copyWith(password: value));
  }

  void login() {
    try {
      emit(state.copyWith(status: LoginFormStatus.loading));
      print("email: ${state.email}");
      print("password: ${state.password}");
    } catch (error) {
      print(error);
      emit(state.copyWith(status: LoginFormStatus.failure));
    }
  }
}
