import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizlet_app_flutter/modules/widgets/question_block.dart';

class LiveGame extends StatefulWidget {
  const LiveGame({super.key});

  @override
  State<LiveGame> createState() => _LiveGameState();
}

class _LiveGameState extends State<LiveGame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.timer_outlined, color: Colors.black),
                      Gap(5),
                      Text(
                        "0s",
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Question 1/5",
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color: Color(0xFF838997),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Gap(30),

              SizedBox(
                width: double.infinity,
                height: 250,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xFF9958FF),
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Gap(100),

                        Text(
                          "Hello",
                          style: GoogleFonts.montserrat(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Gap(20),
              QuestionBlock(
                order: 'A',
                question:
                    'This is too long for me to write but I need to see if the softwrap actually works',
              ),
              Gap(10),
              QuestionBlock(
                order: 'B',
                question:
                    'This is too long for me to write but I need to see if the softwrap actually works',
              ),
              Gap(10),
              QuestionBlock(
                order: 'C',
                question:
                    'This is too long for me to write but I need to see if the softwrap actually works',
              ),
              Gap(10),
              QuestionBlock(
                order: 'D',
                question:
                    'This is too long for me to write but I need to see if the softwrap actually works',
              ),
              Gap(30),
              SizedBox(
                width: double.infinity,
                height: 180,
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0Xfffef2f2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 1.5, color: Color(0xFFffc9c9)),
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          "Time's up!",
                          style: GoogleFonts.montserrat(
                            fontSize: 20,
                            color: Color(0xFF872022),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Gap(20),
                        Expanded(
                          child: Text(
                            "Correct answer: the correct answer is a very correct answer which unfortunately was not selected by you as you must have not seen it fit as a correct answer but u were probably wrong cause it seems like it was the correct answer.",
                            style: GoogleFonts.montserrat(
                              color: Color(0XFFca2127),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Gap(20),
              SizedBox(
                width: double.infinity,
                height: 120,
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.leaderboard_outlined,
                              color: Color(0xFF9958FF),
                              size: 24,
                            ),
                            Gap(10),
                            Text(
                              "Live Leaderboard",
                              style: GoogleFonts.montserrat(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Gap(25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "1.",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    color: Color(0xFF79808f),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Gap(5),
                                Text(
                                  "Guest User",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "0",
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                color: Color(0xFF9958FF),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Gap(20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF9958FF),
                    padding: EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.all(
                        Radius.circular(16),
                      ),
                    ),
                  ),
                  child: Text(
                    "Next Question",
                    style: GoogleFonts.montserrat(color: Color(0xFFFFFFFF)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
