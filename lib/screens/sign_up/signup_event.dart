
part of 'signup_bloc.dart';
abstract class SignUpEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class EmailChanged extends SignUpEvent{
  final String email;
  EmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class PasswordChanged extends SignUpEvent{
  final String password;
  PasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class RePasswordChanged extends SignUpEvent{
  final String password;
  RePasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}
class OnSignUp extends SignUpEvent{

  @override
  List<Object> get props => [];
}