import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class AIFlashcardGenerated extends StatefulWidget {
  const AIFlashcardGenerated({super.key});

  @override
  State<AIFlashcardGenerated> createState() => _AIFlashcardGeneratedState();
}

class _AIFlashcardGeneratedState extends State<AIFlashcardGenerated> {
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
          "Flashcards Generated!",
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
              "All set!",
              style: GoogleFonts.montserrat(
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.w800,
              ),
            ),
            Gap(10),
            Text(
              "Your AI-generated flashcards are ready",
              style: GoogleFonts.montserrat(
                fontSize: 18,
                color: Color(0xFF626978),
                fontWeight: FontWeight.w500,
              ),
            ),
            Gap(30),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Expanded(
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
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
                          child: SvgPicture.asset("assets/icons/book.svg"),
                        ),
                        Gap(5),
                        Text(
                          "Study Flashcards",
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

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Expanded(
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFFFFFF),
                      padding: EdgeInsets.all(16),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.all(
                          Radius.circular(8),
                        ),
                        side: BorderSide(width: 1.5, color: Color(0xFF9958FF)),
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 16,
                          height: 16,
                          child: SvgPicture.asset("assets/icons/play.svg"),
                        ),
                        Gap(5),
                        Text(
                          "Start Quiz",
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            color: Color(0xFF9958FF),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Gap(20),
            Text(
              "Generate Another",
              style: GoogleFonts.montserrat(
                fontSize: 16,
                color: Color(0xFF4A5565),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
