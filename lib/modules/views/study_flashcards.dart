import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class StudyFlashcards extends StatefulWidget {
  const StudyFlashcards({super.key});

  @override
  State<StudyFlashcards> createState() => _StudyFlashcardsState();
}

class _StudyFlashcardsState extends State<StudyFlashcards> {
  bool isFlipped = false;

  void flippedCard() {
    setState(() {
      isFlipped = !isFlipped;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(width: 15),
                    Icon(Icons.arrow_back, size: 30, color: Colors.black),
                    SizedBox(width: 25),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Spanish Vocabulary",
                          style: GoogleFonts.montserrat(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                        Gap(3),
                        Text(
                          "1/5",
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0XFF808694),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xFFF2E7FE),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SvgPicture.asset("assets/icons/shuffle.svg"),
                ),
              ],
            ),
            Gap(40),
            Expanded(
              child: Center(
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 600),
                  transitionBuilder: (child, animation) {
                    final rotate = Tween(
                      begin: pi,
                      end: 0.0,
                    ).animate(animation);
                    return AnimatedBuilder(
                      animation: rotate,
                      child: child,
                      builder: (context, child) {
                        final isUnder = (ValueKey(isFlipped) != child!.key);
                        final tilt =
                            ((animation.value - 0.5).abs() - 0.5) * 0.003;
                        final value = isUnder
                            ? min(rotate.value, pi / 2)
                            : rotate.value;
                        return Transform(
                          transform: Matrix4.rotationY(value)
                            ..setEntry(3, 0, tilt),
                          alignment: Alignment.center,
                          child: child,
                        );
                      },
                    );
                  },
                  child: isFlipped
                      ? SizedBox(
                          key: ValueKey(false),
                          width: double.infinity,
                          height: 650,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xFF9958FF),
                            ),
                            child: Center(
                              child: Column(
                                children: [
                                  Gap(275),
                                  Text(
                                    'Question',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 16,
                                      color: Color(0XFFe4dcff),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Gap(25),
                                  Text(
                                    "Spanish Word",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 16,
                                      color: Color(0XFFe4dcff),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : SizedBox(
                          key: ValueKey(true),
                          width: double.infinity,
                          height: 650,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xFF9958FF),
                            ),
                            child: Center(
                              child: Column(
                                children: [
                                  Gap(275),
                                  Text(
                                    'Answer',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 16,
                                      color: Color(0XFFe4dcff),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Gap(25),
                                  Text(
                                    "Yes",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 16,
                                      color: Color(0XFFe4dcff),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                ),
              ),
            ),
            Gap(30),
            TextButton(
              onPressed: flippedCard,
              child: Text(
                "Tap card to flip",
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  color: Color(0xFF757c8a),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Gap(30),
            Center(
              child: Row(
                children: [
                  SizedBox(
                    width: 184,

                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFf9f9fa),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 16,
                              height: 16,
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Color(0XFF9aa0a9),
                              ),
                            ),
                            Gap(5),
                            Text(
                              "Previous",
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                color: Color(0xFF9aa0a9),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Gap(10),
                  SizedBox(
                    width: 185,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF9958FF),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Gap(20),
                              Text(
                                "Next",
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  color: Color(0xFFFFFFFF),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Gap(5),
                              SizedBox(
                                width: 16,
                                height: 16,
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
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
          ],
        ),
      ),
    );
  }
}
