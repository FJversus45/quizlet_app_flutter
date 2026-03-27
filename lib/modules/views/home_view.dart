import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizlet_app_flutter/modules/views/a_i_study_mode.dart';
import 'package:quizlet_app_flutter/modules/views/create_flashcard_set.dart';
import 'package:quizlet_app_flutter/modules/views/join_lobby.dart';
import 'package:quizlet_app_flutter/modules/views/practice_flashcards.dart';
import 'package:quizlet_app_flutter/modules/widgets/page_blocks.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(20),
              Text(
                "Welcome back, Guest User!",
                style: GoogleFonts.montserrat(
                  fontSize: 40,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gap(5),
              Text(
                "Ready to start learning?",
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  color: Color(0xFF6A7282),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Gap(40),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateFlashcardSet(),
                        ),
                      );
                    },
                    child: PageBlocks(
                      primaryColor: 0xFFA63AFF,
                      secondaryColor: 0xFFB65DFF,
                      text: "Create Flashcard Set",
                      image: "assets/icons/plus.svg",
                    ),
                  ),
                  Gap(10),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => JoinLobby()),
                      );
                    },
                    child: PageBlocks(
                      primaryColor: 0xFF2475FF,
                      secondaryColor: 0xFF4E8FFF,
                      text: "Join Lobby",
                      image: "assets/icons/users.svg",
                    ),
                  ),
                ],
              ),
              Gap(10),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PracticeFlashcards(),
                        ),
                      );
                    },
                    child: PageBlocks(
                      primaryColor: 0xFF00B5A2,
                      secondaryColor: 0xFF33C0B1,
                      text: 'Practice Flashcards',
                      image: "assets/icons/book.svg",
                    ),
                  ),
                  Gap(10),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AIStudyMode()),
                      );
                    },
                    child: PageBlocks(
                      primaryColor: 0xFFF42C95,
                      secondaryColor: 0xFFF553A7,
                      text: "AI Study Mode",
                      image: 'assets/icons/sparkles.svg',
                    ),
                  ),
                ],
              ),
              Gap(40),
              SizedBox(
                width: double.infinity,
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Align(
                          alignment: AlignmentGeometry.centerLeft,
                          child: Text(
                            "Recent Activity",
                            style: GoogleFonts.montserrat(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsGeometry.all(16),
                          child: Column(
                            children: [
                              Container(
                                height: 80,
                                width: double.infinity,
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Color(0xFFF7F2FC),
                                ),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Spanish Vocabulary",
                                          style: GoogleFonts.montserrat(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Gap(5),
                                        Text(
                                          "Last studied 2 hours ago",
                                          style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF6A7282),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Gap(40),
                                    Align(
                                      alignment: AlignmentGeometry.center,
                                      child: Text(
                                        "5 cards",
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF9710F9),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Gap(10),
                              Container(
                                height: 80,
                                width: double.infinity,
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Color(0xFFEEF5FE),
                                ),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Biology Quiz",
                                          style: GoogleFonts.montserrat(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Gap(5),
                                        Text(
                                          "Completed yesterday",
                                          style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF6A7282),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Gap(40),
                                    Align(
                                      alignment: AlignmentGeometry.center,
                                      child: Text(
                                        "Score 85%",
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF155dfc),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
