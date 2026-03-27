import 'package:quizlet_app_flutter/core/network/general_response.dart';

abstract class LobbyService {
  Future<GeneralResponse> createLobby(String subject);

  Future<GeneralResponse> joinLobby(String lobbyCode);

  Stream<Map<String, dynamic>> watchLobbyLeaderboard(String lobbyCode);
}
