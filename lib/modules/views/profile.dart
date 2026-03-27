import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizlet_app_flutter/modules/views/login_view.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
                "Profile",
                style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gap(50),
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      padding: EdgeInsets.all(30),
                      decoration: ShapeDecoration(
                        shape: CircleBorder(),
                        color: Color(0xFF9958FF),
                      ),
                      child: Center(
                        child: Text(
                          'G',
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 26,
                          ),
                        ),
                      ),
                    ),
                    Gap(20),
                    Text(
                      "Guest User",
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Gap(10),
                    Text(
                      "Member since March 2026",
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        color: Color(0xFF626978),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Gap(40),
              Row(
                children: [
                  Container(
                    width: 115,
                    height: 115,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xFF9958FF),
                    ),
                    child: Padding(
                      padding: EdgeInsetsGeometry.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 22,
                            height: 22,
                            child: SvgPicture.asset('assets/icons/book.svg'),
                          ),
                          Gap(10),
                          Center(
                            child: Column(
                              children: [
                                Text(
                                  '1',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                                  softWrap: true,
                                ),
                                Gap(5),
                                Text(
                                  'Flashcard Sets',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                  softWrap: true,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Gap(15),
                  Container(
                    width: 115,
                    height: 115,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xFF1b65f6),
                    ),
                    child: Padding(
                      padding: EdgeInsetsGeometry.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 22,
                            height: 22,
                            child: SvgPicture.asset('assets/icons/target.svg'),
                          ),
                          Gap(10),
                          Center(
                            child: Column(
                              children: [
                                Text(
                                  '1',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                                  softWrap: true,
                                ),
                                Gap(5),
                                Text(
                                  'Total Cards',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                  softWrap: true,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Gap(15),
                  Container(
                    width: 115,
                    height: 115,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xFF00a494),
                    ),
                    child: Padding(
                      padding: EdgeInsetsGeometry.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 22,
                            height: 22,
                            child: SvgPicture.asset('assets/icons/trophy.svg'),
                          ),
                          Gap(10),
                          Center(
                            child: Column(
                              children: [
                                Text(
                                  '12',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                                  softWrap: true,
                                ),
                                Gap(5),
                                Text(
                                  'Quizzes Taken',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                  softWrap: true,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Gap(40),
              Text(
                "Settings",
                style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gap(15),
              SizedBox(
                width: double.infinity,
                height: 85,
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Colors.white,
                    border: Border.all(color: Color(0xFFC9CBCE), width: 1.5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Edit Profile",
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF000000),
                        ),
                      ),
                      Gap(3),
                      Text(
                        "Update your information",
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF6A7282),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Gap(10),
              SizedBox(
                width: double.infinity,
                height: 85,
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Colors.white,
                    border: Border.all(color: Color(0xFFC9CBCE), width: 1.5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Notifications",
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF000000),
                        ),
                      ),
                      Gap(3),
                      Text(
                        "Manage your preferences",
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF6A7282),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Gap(10),
              SizedBox(
                width: double.infinity,
                height: 85,
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Colors.white,
                    border: Border.all(color: Color(0xFFC9CBCE), width: 1.5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Privacy",
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF000000),
                        ),
                      ),
                      Gap(3),
                      Text(
                        "Control your data",
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF6A7282),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Gap(20),
              SizedBox(
                height: 70,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginView()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFf9f9fa),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(color: Color(0xFFb52027), width: 1.5),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 16,
                            height: 16,
                            child: Icon(Icons.logout, color: Color(0XFFb52027)),
                          ),
                          Gap(5),
                          Text(
                            "Log Out",
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              color: Color(0xFFb52027),
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
      ),
    );
  }
}
