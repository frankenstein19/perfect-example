

import 'package:flutter/material.dart';
import 'package:perfectexample/utils/app_colors.dart';

import '../screens/login/login_bloc.dart';

class ActionButton extends StatelessWidget{
  final LoginButtonState state;
  final String text;
  final VoidCallback onPress;

  const ActionButton({this.state=LoginButtonState.enable,required this.text,required this.onPress,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: double.infinity,
      child: ElevatedButton(
          onPressed: onPress,
          child: state == LoginButtonState.progress
              ? const CircularProgressIndicator(
            valueColor:AlwaysStoppedAnimation<Color>(AppColors.backgroundColor),
          )
              :  Text(text)),
    );

  }

}