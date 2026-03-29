import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quizlet_app_flutter/core/loading_overlay_scaffold.dart';
import 'package:quizlet_app_flutter/core/snackbar.dart';
import 'package:quizlet_app_flutter/modules/provider/lobby_provider.dart';
import 'package:quizlet_app_flutter/modules/views/active_lobby.dart';
import 'package:quizlet_app_flutter/modules/views/create_lobby.dart';
import 'package:quizlet_app_flutter/modules/widgets/custom_text_field.dart';

class JoinLobby extends StatefulWidget {
  const JoinLobby({super.key});

  @override
  State<JoinLobby> createState() => _JoinLobbyState();
}

class _JoinLobbyState extends State<JoinLobby> {
  final lobbyCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<LobbyNotifier>(
      builder: (context, lobbyNotifier, _) {
        return LoadingOverlayScaffold(
          isLoading: lobbyNotifier.isBusy,
          child: Scaffold(
            appBar: AppBar(
              leading: Row(
                children: [
                  SizedBox(width: 15),
                  Icon(Icons.arrow_back, size: 30, color: Colors.black),
                  SizedBox(width: 10),
                ],
              ),
              title: Text(
                "Multiplayer",
                style: GoogleFonts.montserrat(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Gap(40),
                  Center(
                    child: Container(
                      width: 160,
                      height: 160,
                      padding: EdgeInsets.all(40),
                      decoration: ShapeDecoration(
                        shape: CircleBorder(),
                        color: Color(0xFF9958FF),
                      ),
                      child: SvgPicture.asset('assets/icons/users.svg'),
                    ),
                  ),
                  Gap(40),
                  Text(
                    "Join a Lobby",
                    style: GoogleFonts.montserrat(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  Gap(20),
                  Text(
                    'Enter the lobby code to join with your friends',
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF6A7296),
                    ),
                  ),
                  Gap(25),
                  CustomTextField(
                    labelText: "Lobby Code",
                    hintText: "ABC123",
                    controller: lobbyCodeController,
                  ),
                  Gap(5),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          await lobbyNotifier
                              .joinLobby(lobbyCodeController.text.trim())
                              .then((res) async {
                                if (res.success) {
                                  SnackbarHandler.showSuccessSnackbar(
                                    context: context,
                                    message: "Lobby joined successfully",
                                  );

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ActiveLobby(),
                                    ),
                                  );
                                } else {
                                  SnackbarHandler.showErrorSnackbar(
                                    context: context,
                                    message: res.message,
                                  );
                                }
                              });
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
                          "Join Lobby",
                          style: GoogleFonts.montserrat(
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Gap(15),
                  Divider(),
                  Gap(15),

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateLobby(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFFFFFF),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(
                            width: 1.5,
                            color: Color(0xFF9958FF),
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: Row(
                            children: [
                              Gap(50),
                              SizedBox(
                                width: 16,
                                height: 16,
                                child: Icon(
                                  Icons.add,
                                  color: Color(0xFF9958FF),
                                  size: 20,
                                ),
                              ),
                              Gap(5),
                              Text(
                                "Create New Lobby",
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
