import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizlet_app_flutter/modules/widgets/alternate_flash_sets_mini_view.dart';
import 'package:quizlet_app_flutter/modules/widgets/custom_text_field.dart';

class PracticeFlashcards extends StatefulWidget {
  const PracticeFlashcards({super.key});

  @override
  State<PracticeFlashcards> createState() => _PracticeFlashcardsState();
}

class _PracticeFlashcardsState extends State<PracticeFlashcards> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Practice Flashcards",
          style: GoogleFonts.montserrat(
            fontSize: 30,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Gap(10),
            CustomTextField(
              prefixIcon: Icon(Icons.search, size: 22),
              hintText: "Search flashcard sets...",
            ),
            Gap(20),
            AlternateFlashSetsMiniView(
              title: "abn",
              numberOfCards: 53,
              creatorName: "fola",
            ),
          ],
        ),
      ),
    );
  }
}
