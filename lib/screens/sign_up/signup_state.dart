part of 'signup_bloc.dart';



class SignUpState extends Equatable {
  const SignUpState(
      {this.email = '',
      this.password = '',
      this.rePassword = '',
      this.state = LoginButtonState.enable,
      this.canLogin = false,
      this.verifyData = false});

  final String email;
  final String password;
  final String rePassword;
  final LoginButtonState state;
  final bool canLogin;
  final bool verifyData;

  SignUpState copyWith(
      {String? email,
      String? password,
      String? rePassword,
      LoginButtonState? state,
      bool? canLogin,
      bool? verifyData}) {
    return SignUpState(
        email: email ?? this.email,
        password: password ?? this.password,
        rePassword: rePassword ?? this.rePassword,
        state: state ?? this.state,
        verifyData: verifyData ?? this.verifyData,
        canLogin: canLogin ?? this.canLogin);
  }

  @override
  List<Object?> get props =>
      [email, password, rePassword, state, canLogin, verifyData];
}
