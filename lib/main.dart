import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quizlet_app_flutter/core/shared_notifier/app_provider.dart';
import 'package:quizlet_app_flutter/modules/views/a_i_flashcard_generated.dart';
import 'package:quizlet_app_flutter/modules/views/flashcards.dart';
import 'package:quizlet_app_flutter/modules/views/live_game.dart';
import 'package:quizlet_app_flutter/modules/views/login_view.dart';
import 'package:quizlet_app_flutter/modules/views/practice_flashcards.dart';
import 'package:quizlet_app_flutter/modules/views/profile.dart';
import 'package:quizlet_app_flutter/modules/views/ready_practice.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: appProviders,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        useInheritedMediaQuery: true,
        builder: (context, child) => GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            ),
            home: const LoginView(),
          ),
        ),
      ),
    );
  }
}
