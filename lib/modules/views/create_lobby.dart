import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizlet_app_flutter/modules/views/active_lobby.dart';

class CreateLobby extends StatefulWidget {
  const CreateLobby({super.key});

  @override
  State<CreateLobby> createState() => _CreateLobbyState();
}

class _CreateLobbyState extends State<CreateLobby> {
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
          "Create Lobby",
          style: GoogleFonts.montserrat(
            fontSize: 30,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(40),
              Text(
                "Select a Flashcard Set",
                style: GoogleFonts.montserrat(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Gap(65),
              Center(
                child: Column(
                  children: [
                    Text(
                      "You haven't created any flashcard sets yet",
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        color: Color(0xFF626978),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Gap(10),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 80,
                      ),
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
                        child: Text(
                          "Create Your First Set",
                          style: GoogleFonts.montserrat(
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    Gap(70),
                  ],
                ),
              ),
              Text(
                "Options",
                style: GoogleFonts.montserrat(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Gap(30),
              Padding(
                padding: EdgeInsetsGeometry.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Host participates in game",
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    Checkbox(
                      value: false,
                      onChanged: (value) => value != value,
                    ),
                  ],
                ),
              ),
              Gap(180),

              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
                child: Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ActiveLobby(),
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
                        "Create Lobby",
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
      ),
    );
  }
}
