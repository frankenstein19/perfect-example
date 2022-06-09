import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfectexample/repository/movie_repository.dart';
import 'package:perfectexample/screens/dashboard/dashboard_page.dart';
import 'package:perfectexample/screens/login/login_page.dart';
import 'package:perfectexample/utils/app_colors.dart';

import 'screens/dashboard/product_bloc.dart';
import 'screens/login/login_bloc.dart';
import 'screens/sign_up/signup_bloc.dart';

Future<void> main() async {
WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: AppColors.primaryColor
    ));

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => LoginBloc()),
        BlocProvider(
            create: (_) => SignUpBloc()),
        BlocProvider(
            create: (_) => ProductBloc(MovieRepository())),
      ],
      child: MaterialApp(
        theme: ThemeData(
            primarySwatch: AppColors.primarySwatch,
            scaffoldBackgroundColor: AppColors.backgroundColor),
        home: checkCurrentUser(),
      ),
    );
  }
}

Widget checkCurrentUser() {
  Widget? widget;
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    widget = const LoginPage();
  } else {
    widget = const DashboardPage();
  }
  return widget;
}
