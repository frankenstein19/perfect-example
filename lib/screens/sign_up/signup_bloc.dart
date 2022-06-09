import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfectexample/screens/login/login_bloc.dart';
import 'package:perfectexample/utils/utils.dart';

part 'signup_event.dart';

part 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(const SignUpState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<RePasswordChanged>(_onRePasswordChanged);
    on<OnSignUp>(_onSignUp);
  }

  VoidCallback? onLoginSuccess;
  void Function(String)? showMessage;

  void _onEmailChanged(EmailChanged event, Emitter<SignUpState> emit) {
    final email = event.email;
    emit(state.copyWith(
        email: email.isNotEmpty ? email : event.email,
        canLogin:
            email.isNotEmpty && state.password.isNotEmpty ? true : false));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<SignUpState> emit) {
    final password = event.password;
    emit(state.copyWith(
        password: password.isNotEmpty ? password : event.password,
        canLogin:
            password.isNotEmpty && state.email.isNotEmpty ? true : false));
  }

  void _onRePasswordChanged(
      RePasswordChanged event, Emitter<SignUpState> emit) {
    final password = event.password;
    emit(state.copyWith(
        rePassword: password.isNotEmpty ? password : event.password,
        canLogin:
            password.isNotEmpty && state.email.isNotEmpty ? true : false));
  }

  Future<void> _onSignUp(OnSignUp event, Emitter<SignUpState> emit) async {
    if (!state.email.isEmailValid ||
        !state.password.isPasswordValid ||
        state.password != state.rePassword) {
      emit(state.copyWith(
          state: LoginButtonState.enable, canLogin: false, verifyData: true));
      return;
    }

    emit(state.copyWith(
        email: state.email,
        password: state.password,
        state: LoginButtonState.progress,
        canLogin: false));
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );
      if ((credential.user?.email ?? "").isNotEmpty == true &&
          onLoginSuccess != null) {
        onLoginSuccess!();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        if (showMessage != null) {
          showMessage!('The password provided is too weak.');
        }
      } else if (e.code == 'email-already-in-use') {
        if (showMessage != null) {
          showMessage!('The account already exists for that email.');
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    emit(state.copyWith(
        state: LoginButtonState.enable,
        canLogin: false,
        email: '',
        password: '',
        rePassword: '',
        verifyData: false));
  }
}
