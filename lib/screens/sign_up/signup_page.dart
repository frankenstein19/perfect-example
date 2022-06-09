
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:perfectexample/screens/login/login_page.dart';
import 'package:perfectexample/screens/sign_up/signup_bloc.dart';
import 'package:perfectexample/utils/app_colors.dart';
import 'package:perfectexample/utils/custom_outlined_button.dart';
import 'package:perfectexample/utils/utils.dart';
import '../../utils/action_button.dart';
import '../dashboard/dashboard_page.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignUp();
}

class _SignUp extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    context.read<SignUpBloc>().onLoginSuccess = onSuccess;
    context.read<SignUpBloc>().showMessage = createSnackBar;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(slivers: [
          SliverFillRemaining(
            child:Column(
              children: [
                Expanded(
                    child: Stack(
                      children: [
                        SvgPicture.asset("assets/login_background.svg",
                            fit: BoxFit.fill),
                        const Padding(
                          padding: EdgeInsets.all(20),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Create \nAccount",
                                style: TextStyle(
                                    color: AppColors.backgroundColor,
                                    fontSize: 32,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.start,
                              )),
                        )
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      BlocBuilder<SignUpBloc, SignUpState>(
                        builder: (context, state) {
                          return TextField(
                            key: const Key("emailInput"),
                            decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.email),
                                suffixIcon: state.email.isEmailValid
                                    ? const Icon(Icons.done)
                                    : null,
                                hintText: "Email",
                                helperText:
                                "A complete, valid email e.g. joe@gmail.com",
                                errorText:
                                !state.email.isEmailValid&&state.verifyData
                                    ? "Please ensure the email entered is valid"
                                    : null),
                            onChanged: (v) {
                              context.read<SignUpBloc>().add(EmailChanged(v));
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BlocBuilder<SignUpBloc, SignUpState>(
                        builder: (context, state) {
                          return TextField(
                            key: const Key("passwordInput"),
                            obscureText: true,
                            decoration: InputDecoration(
                                suffixIcon: state.password.isPasswordValid
                                    ? const Icon(Icons.done)
                                    : null,
                                prefixIcon: const Icon(Icons.lock),
                                hintText: "Password",
                                helperText: "Password must be 8 more letters",
                                errorText:
                                !state.password.isPasswordValid&&state.verifyData
                                    ? "Please ensure the password entered is valid"
                                    : null),
                            onChanged: (v) {
                              context.read<SignUpBloc>().add(PasswordChanged(v));
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BlocBuilder<SignUpBloc, SignUpState>(
                        builder: (context, state) {
                          return TextField(
                            key: const Key("repasswordInput"),
                            obscureText: true,
                            decoration: InputDecoration(
                                suffixIcon: state.password.isNotEmpty&&state.password==state.rePassword
                                    ? const Icon(Icons.done)
                                    : null,
                                prefixIcon: const Icon(Icons.lock),
                                hintText: "Confirm Password",
                                helperText: "Reenter the password",
                                errorText:
                                state.password!=state.rePassword&&state.verifyData
                                    ? "Please ensure the password and confirm password are same"
                                    : null),
                            onChanged: (v) {
                              context.read<SignUpBloc>().add(RePasswordChanged(v));
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BlocBuilder<SignUpBloc, SignUpState>(
                        builder: (context, state) {
                          return ActionButton(
                            text: "Sign Up",
                            state: state.state,
                            onPress: (){
                              context.read<SignUpBloc>().add(OnSignUp());
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(child: Container(height: 1,color: Colors.blueGrey)),
                          const SizedBox(width: 15,),
                          const Text("OR",style: TextStyle(color: Colors.blueGrey ),),
                          const SizedBox(width: 15,),
                          Expanded(child: Container(height: 1,color: Colors.blueGrey)),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomOutlineButton(text: "LogIn", onPress: (){
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (_) => const LoginPage()));
                      }),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
        ),
      ),
    );
  }

  void onSuccess() => Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (_) => const DashboardPage()));

  void createSnackBar(String message) {
    final snackBar =  SnackBar(content:  Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
