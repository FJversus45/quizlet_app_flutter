import 'package:quizlet_app_flutter/core/network/general_response.dart';

abstract class LobbyService {
  Future<GeneralResponse> createLobby(String flashcardSetId);

  Future<GeneralResponse> joinLobby(String lobbyCode);

  Future<GeneralResponse> startLobby(String lobbyCode);

  Future<GeneralResponse> submitAnswer(
    bool isCorrect,
    String lobbyCode,
    int scoreDelta,
  );

  Stream<Map<String, dynamic>> watchLobbyLeaderboard(String lobbyCode);
}
