import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quizlet_app_flutter/modules/provider/auth_provider.dart';
import 'package:quizlet_app_flutter/modules/provider/flashcard_provider.dart';
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
    return Consumer2<AuthProvider, FlashcardProvider>(
      builder: (context, auth, flash, _) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(20),
                  Text(
                    "Welcome back, ${auth.currentUser?.fullName ?? 'Guest User'}!",
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
                            MaterialPageRoute(
                              builder: (context) => JoinLobby(),
                            ),
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
                            MaterialPageRoute(
                              builder: (context) => AIStudyMode(),
                            ),
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
                                  // no recent activity if flash.flashcardset is empty
                                  if (flash.flashcardSets.isEmpty) ...[
                                    Text(
                                      "No recent activity",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF6A7282),
                                      ),
                                    ),
                                  ] else ...[
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: flash.flashcardSets.length,
                                      itemBuilder: (context, index) {
                                        final flashcardSet =
                                            flash.flashcardSets[index];
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 10,
                                          ),
                                          child: Container(
                                            height: 80,
                                            width: double.infinity,
                                            padding: EdgeInsets.all(16),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: Color(0xFFF7F2FC),
                                            ),
                                            child: Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      flashcardSet.subject,
                                                      style:
                                                          GoogleFonts.montserrat(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors.black,
                                                          ),
                                                    ),
                                                    Gap(5),
                                                    Text(
                                                      "Created on ${flashcardSet.createdAt.toString().split(' ')[0]}",
                                                      style:
                                                          GoogleFonts.montserrat(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Color(
                                                              0xFF6A7282,
                                                            ),
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                                Gap(40),
                                                Align(
                                                  alignment:
                                                      AlignmentGeometry.center,
                                                  child: Text(
                                                    "${flashcardSet.flashcards.length} cards",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Color(
                                                            0xFF9710F9,
                                                          ),
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
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
      },
    );
  }
}
