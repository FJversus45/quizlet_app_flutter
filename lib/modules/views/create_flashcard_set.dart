import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizlet_app_flutter/modules/views/flash_card_sets.dart';
import 'package:quizlet_app_flutter/modules/widgets/custom_text_field.dart';

class CreateFlashcardSet extends StatefulWidget {
  const CreateFlashcardSet({super.key});

  @override
  State<CreateFlashcardSet> createState() => _CreateFlashcardSetState();
}

class _CreateFlashcardSetState extends State<CreateFlashcardSet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          children: [
            SizedBox(width: 15),
            Icon(Icons.arrow_back, size: 30, color: Colors.black),
            SizedBox(width: 10),
          ],
        ),
        title: Text(
          "Create Flashcard Set",
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
            Gap(280),
            CustomTextField(
              labelText: "What's the name of your flashcard set?",
              hintText: "e.g., Spanish Vocabulary",
            ),
            Gap(280),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Expanded(
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FlashCardSets(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF9958FF),
                      padding: EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.all(
                          Radius.circular(8),
                        ),
                      ),
                    ),
                    child: Text(
                      "Continue",
                      style: GoogleFonts.montserrat(
                        color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
