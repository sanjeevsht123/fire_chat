import 'package:fire/core/push_notification/push_notification.dart';
import 'package:fire/feature/auth/presentation/bloc/sign_in_cubit.dart';
import 'package:fire/feature/auth/presentation/bloc/sign_up_cubit.dart';
import 'package:fire/feature/auth/presentation/pages/login_page.dart';
import 'package:fire/feature/landing/presentation/pages/landing_page.dart';
import 'package:fire/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await PushNotification.initializeMessaging();
  configureDependencies();
  runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => getIt<SignInCubit>(),
          ),
          BlocProvider(
            create: (context) => getIt<SignUpCubit>(),
          ),
        ],
        child: MyApp(),
      ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          home: LandingPage(),
        );
      },
    );
  }
}
