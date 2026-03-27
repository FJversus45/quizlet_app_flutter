import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizlet_app_flutter/modules/views/a_i_flashcard_generated.dart';
import 'package:quizlet_app_flutter/modules/widgets/custom_text_field.dart';

class AIStudyMode extends StatefulWidget {
  const AIStudyMode({super.key});

  @override
  State<AIStudyMode> createState() => _AIStudyModeState();
}

class _AIStudyModeState extends State<AIStudyMode> {
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
          "AI Study Mode",
          style: GoogleFonts.montserrat(
            fontSize: 30,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: Column(
          children: [
            Gap(120),

            Center(
              child: Container(
                width: 100,
                height: 100,
                padding: EdgeInsets.all(30),
                decoration: ShapeDecoration(
                  shape: CircleBorder(),
                  color: Color(0xFFE98AC6),
                ),
                child: SvgPicture.asset('assets/icons/sparkles.svg'),
              ),
            ),
            Gap(20),
            Text(
              "Learn anything with AI",
              style: GoogleFonts.montserrat(
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.w800,
              ),
            ),
            Gap(10),
            Text(
              "Enter a topic and we'll generate flashcards for you",
              style: GoogleFonts.montserrat(
                fontSize: 18,
                color: Color(0xFF626978),
                fontWeight: FontWeight.w500,
              ),
            ),
            Gap(60),
            CustomTextField(
              labelText: "What do you want to learn",
              hintText: "e.g., Photosynthesis, World War II, Calculus",
            ),
            Gap(10),
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
                          builder: (context) => AIFlashcardGenerated(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFE98AC6),
                      padding: EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.all(
                          Radius.circular(8),
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 16,
                          height: 16,
                          child: SvgPicture.asset("assets/icons/sparkles.svg"),
                        ),
                        Gap(5),
                        Text(
                          "Generate Flashcards",
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            color: Color(0xFFffffff),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
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
