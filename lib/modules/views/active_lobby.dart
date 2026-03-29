import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quizlet_app_flutter/core/snackbar.dart';
import 'package:quizlet_app_flutter/modules/provider/auth_provider.dart';
import 'package:quizlet_app_flutter/modules/provider/flashcard_provider.dart';
import 'package:quizlet_app_flutter/modules/provider/lobby_provider.dart';
import 'package:quizlet_app_flutter/modules/views/live_game.dart';
import 'package:quizlet_app_flutter/modules/widgets/player_mini_view.dart';

class ActiveLobby extends StatefulWidget {
  const ActiveLobby({super.key});

  @override
  State<ActiveLobby> createState() => _ActiveLobbyState();
}

class _ActiveLobbyState extends State<ActiveLobby> {
  bool _hasNavigatedToLiveGame = false;

  void _maybeNavigateToLiveGame(String? lobbyStatus) {
    if (_hasNavigatedToLiveGame || lobbyStatus?.toUpperCase() != 'ACTIVE') {
      return;
    }

    _hasNavigatedToLiveGame = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LiveGame()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<LobbyNotifier, AuthProvider>(
      builder: (context, lobbyNotifier, authProvider, _) {
        _maybeNavigateToLiveGame(lobbyNotifier.currentLobby?.lobbyStatus);

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
              "Lobby",
              style: GoogleFonts.montserrat(
                fontSize: 30,
                fontWeight: FontWeight.w800,
                color: Colors.black,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(30),
                  SizedBox(
                    width: double.infinity,
                    height: 215,
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xFF7a56ff),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                padding: EdgeInsets.all(16),
                                decoration: ShapeDecoration(
                                  shape: CircleBorder(),
                                  color: Color(0xFF7b66f8),
                                ),
                                child: SvgPicture.asset(
                                  'assets/icons/users.svg',
                                ),
                              ),
                              Gap(15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Lobby Code",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFFcdbfe7),
                                    ),
                                  ),
                                  Gap(8),
                                  Text(
                                    lobbyNotifier.currentLobby?.lobbyCode ??
                                        "ABC123",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                              Gap(130),
                              Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Color(0xFF7b66f8),
                                ),
                                child: SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: SvgPicture.asset(
                                    'assets/icons/copy.svg',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Gap(15),
                          SizedBox(
                            width: double.infinity,
                            height: 107,
                            child: Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Color(0xFF7b66f8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Flashcard Set",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFFcdbfe7),
                                    ),
                                  ),
                                  Gap(3),
                                  Text(
                                    lobbyNotifier
                                            .currentLobby
                                            ?.flashcardSet
                                            .subject ??
                                        "Unknown Set",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Gap(3),
                                  Text(
                                    "${lobbyNotifier.currentLobby?.flashcardSet.flashcards.length ?? 0} cards",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFFcdbfe7),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Gap(35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Players",
                        style: GoogleFonts.montserrat(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xFFEBE1F7),
                        ),
                        child: Text(
                          "1 player",
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF9958FF),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(35),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount:
                        lobbyNotifier
                            .currentLobby
                            ?.participatingPlayers
                            .length ??
                        0,
                    itemBuilder: (context, index) {
                      final player = lobbyNotifier
                          .currentLobby!
                          .participatingPlayers[index];
                      final role =
                          player.id == lobbyNotifier.currentLobby?.createdBy.id
                          ? "Host"
                          : "Player";
                      final perspective =
                          player.fullName == authProvider.currentUser?.fullName
                          ? "You"
                          : "Other";

                      return PlayerMiniView(
                        role: role,
                        name: player.fullName,
                        perspective: perspective,
                      );
                    },
                  ),
                  Gap(200),

                  if (lobbyNotifier.currentLobby?.createdBy.fullName ==
                      authProvider.currentUser?.fullName) ...[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            await lobbyNotifier
                                .startLobby(
                                  lobbyNotifier.currentLobby!.lobbyCode,
                                )
                                .then((res) async {
                                  if (res.success) {
                                    SnackbarHandler.showSuccessSnackbar(
                                      context: context,
                                      message: "game started successfully",
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
                            "Start Game",
                            style: GoogleFonts.montserrat(
                              color: Color(0xFFFFFFFF),
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
