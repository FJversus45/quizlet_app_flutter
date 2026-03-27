import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizlet_app_flutter/modules/views/active_lobby.dart';
import 'package:quizlet_app_flutter/modules/views/flash_card_sets.dart';

class ReadyPractice extends StatefulWidget {
  const ReadyPractice({super.key});

  @override
  State<ReadyPractice> createState() => _ReadyPracticeState();
}

class _ReadyPracticeState extends State<ReadyPractice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Gap(180),
            Center(
              child: Container(
                width: 100,
                height: 100,
                padding: EdgeInsets.all(30),
                decoration: ShapeDecoration(
                  shape: CircleBorder(),
                  color: Color(0xFF9958FF),
                ),
                child: SvgPicture.asset('assets/icons/book.svg'),
              ),
            ),
            Gap(20),
            Text(
              "Ready to learn?",
              style: GoogleFonts.montserrat(
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.w800,
              ),
            ),
            Gap(10),
            Text(
              "Choose how you want to study",
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
                      backgroundColor: Color(0xFF9958FF),
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ActiveLobby()),
                      );
                    },
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
                          "Take Quiz",
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
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FlashCardSets()),
                );
              },
              child: Text(
                "Go Back",
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  color: Color(0xFF4A5565),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
