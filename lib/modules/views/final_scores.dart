import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizlet_app_flutter/modules/views/home_view.dart';

class FinalScores extends StatefulWidget {
  const FinalScores({super.key});

  @override
  State<FinalScores> createState() => _FinalScoresState();
}

class _FinalScoresState extends State<FinalScores> {
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
          "Game Over!",
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
                  color: Color(0xFFf4b800),
                ),
                child: Icon(Icons.leaderboard, color: Colors.white),
              ),
            ),
            Gap(20),
            Text(
              "Final Scores",
              style: GoogleFonts.montserrat(
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.w800,
              ),
            ),
            Gap(10),
            Text(
              "Great game everyone",
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
                      backgroundColor: Color(0xFFf4b800),
                      padding: EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.all(
                          Radius.circular(8),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "#1",
                              style: GoogleFonts.montserrat(
                                fontSize: 25,
                                color: Color(0xFFffffff),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Gap(15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Guest User",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    color: Color(0xFFffffff),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Gap(3),
                                Text(
                                  "You",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    color: Color(0xFFffffff),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          "100",
                          style: GoogleFonts.montserrat(
                            fontSize: 25,
                            color: Color(0xFFffffff),
                            fontWeight: FontWeight.w700,
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
                        MaterialPageRoute(builder: (context) => HomeView()),
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
                    child: Text(
                      "Back to Home",
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        color: Color(0xFF9958FF),
                        fontWeight: FontWeight.w600,
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
