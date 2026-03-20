import 'package:flutter/material.dart';
import 'package:quizlet_app_flutter/modules/views/a_i_flashcard_generated.dart';
import 'package:quizlet_app_flutter/modules/views/a_i_study_mode.dart';
import 'package:quizlet_app_flutter/modules/views/active_lobby.dart';
import 'package:quizlet_app_flutter/modules/views/create_flashcard_set.dart';
import 'package:quizlet_app_flutter/modules/views/create_lobby.dart';
import 'package:quizlet_app_flutter/modules/views/flash_card_sets.dart';
import 'package:quizlet_app_flutter/modules/views/home_view.dart';
import 'package:quizlet_app_flutter/modules/views/join_lobby.dart';
import 'package:quizlet_app_flutter/modules/views/practice_flashcards.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const PracticeFlashcards(),
    );
  }
}
