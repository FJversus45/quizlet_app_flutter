import 'dart:async';

import 'package:quizlet_app_flutter/core/network/general_response.dart';
import 'package:quizlet_app_flutter/core/shared_notifier/base_change_notifier.dart';
import 'package:quizlet_app_flutter/modules/model/lobby_model.dart';

class LobbyNotifier extends BaseChangeNotifier {
  Lobby? _currentLobby;
  bool _isBusy = false;
  String? _errorMessage;
  StreamSubscription<Map<String, dynamic>>? _lobbyUpdatesSubscription;

  Lobby? get currentLobby => _currentLobby;
  bool get isBusy => _isBusy;
  String? get errorMessage => _errorMessage;

  Future<void> subscribeToCurrentLobby() async {
    final lobbyCode = _currentLobby?.lobbyCode;
    if (lobbyCode == null || lobbyCode.isEmpty) {
      return;
    }

    await _startLobbyUpdates(lobbyCode);
  }

  Future<void> _startLobbyUpdates(String lobbyCode) async {
    await _stopLobbyUpdates();
    _lobbyUpdatesSubscription = lobbyService
        .watchLobbyLeaderboard(lobbyCode)
        .listen(
          (payload) {
            final currentLobby = _currentLobby;
            if (currentLobby == null) {
              return;
            }

            _currentLobby = currentLobby.mergeLeaderboardUpdate(payload);
            _errorMessage = null;
            notifyListeners();
          },
          onError: (Object error, StackTrace stackTrace) {
            _errorMessage = error.toString().replaceFirst('Exception: ', '');
            notifyListeners();
          },
        );
  }

  Future<void> _stopLobbyUpdates() async {
    await _lobbyUpdatesSubscription?.cancel();
    _lobbyUpdatesSubscription = null;
  }

  Future<GeneralResponse> createLobby({required String flashcardSetId}) async {
    try {
      _isBusy = true;
      _errorMessage = null;
      notifyListeners();

      final res = await lobbyService.createLobby(flashcardSetId);
      if (res.success) {
        final createdLobby = res.data as Lobby;
        _currentLobby = createdLobby;
        await _startLobbyUpdates(createdLobby.lobbyCode);
        return GeneralResponse(
          success: true,
          data: createdLobby,
          message: 'Lobby created successfully',
        );
      } else {
        return GeneralResponse(success: false, message: res.message);
      }
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      return GeneralResponse(success: false, message: 'Failed to create lobby');
    } finally {
      _isBusy = false;
      notifyListeners();
    }
  }

  Future<GeneralResponse> joinLobby(String lobbyCode) async {
    try {
      _isBusy = true;
      _errorMessage = null;
      notifyListeners();

      final res = await lobbyService.joinLobby(lobbyCode);
      if (res.success) {
        final createdLobby = res.data as Lobby;
        _currentLobby = createdLobby;
        await _startLobbyUpdates(createdLobby.lobbyCode);
        return GeneralResponse(
          success: true,
          data: createdLobby,
          message: 'Lobby created successfully',
        );
      } else {
        return GeneralResponse(success: false, message: res.message);
      }
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      return GeneralResponse(success: false, message: 'Failed to create lobby');
    } finally {
      _isBusy = false;
      notifyListeners();
    }
  }

  Future<GeneralResponse> startLobby(String lobbyCode) async {
    try {
      _isBusy = true;
      _errorMessage = null;
      notifyListeners();

      final res = await lobbyService.startLobby(lobbyCode);
      if (res.success) {
        return GeneralResponse(
          success: true,
          message: 'Lobby started successfully',
        );
      } else {
        return GeneralResponse(success: false, message: res.message);
      }
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      return GeneralResponse(success: false, message: 'Failed to start lobby');
    } finally {
      _isBusy = false;
      notifyListeners();
    }
  }

  Future<GeneralResponse> submitAnswer(bool isCorrect, String lobbyCode) async {
    try {
      final res = await lobbyService.submitAnswer(isCorrect, lobbyCode, 100);
      if (res.success) {
        return GeneralResponse(success: true, message: "You're correct");
      } else {
        return GeneralResponse(success: false, message: res.message);
      }
    } catch (e) {
      return GeneralResponse(
        success: false,
        message: 'Failed to submit answer',
      );
    }
  }
}
