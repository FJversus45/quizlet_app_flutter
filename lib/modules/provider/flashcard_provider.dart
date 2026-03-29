import 'dart:async';
import 'package:quizlet_app_flutter/core/network/general_response.dart';
import 'package:quizlet_app_flutter/core/shared_notifier/base_change_notifier.dart';
import 'package:quizlet_app_flutter/modules/model/flashcard.dart';
import 'package:quizlet_app_flutter/modules/model/flashcard_set.dart';
import 'package:quizlet_app_flutter/modules/model/lobby_model.dart';

class FlashcardProvider extends BaseChangeNotifier {
  final List<FlashcardSet> flashcardSets = [];

  Future<GeneralResponse> getAllFlashcardSets() async {
    try {
      setLoading = true;
      notifyListeners();

      final res = await flashCardSetsService.getAllFlashcardSet();
      if (res.success) {
        final flascardsets = res.data as List<FlashcardSet>;
        flashcardSets.clear();
        flashcardSets.addAll(flascardsets);
        notifyListeners();
        return GeneralResponse(
          success: true,
          data: flashcardSets,
          message: 'Flashcard sets retrieved successfully',
        );
      } else {
        return GeneralResponse(success: false, message: res.message);
      }
    } catch (e) {
      handleError(e.toString());
      return GeneralResponse(
        success: false,
        message: 'Failed to retrieve flashcard sets',
      );
    } finally {
      setLoading = false;
      notifyListeners();
    }
  }

  Future<GeneralResponse> createFlashcardSet(
    String subject,
    List<Flashcard> cards,
  ) async {
    try {
      setLoading = true;
      notifyListeners();

      final res = await flashCardSetsService.createFlashcardSet(subject, cards);
      if (res.success) {
        await getAllFlashcardSets();
        notifyListeners();
        return GeneralResponse(
          success: true,
          message: 'Flashcard set created successfully',
        );
      } else {
        return GeneralResponse(success: false, message: res.message);
      }
    } catch (e) {
      handleError(e.toString());
      return GeneralResponse(
        success: false,
        message: 'Failed to create flashcard set',
      );
    } finally {
      setLoading = false;
      notifyListeners();
    }
  }

  // Future<GeneralResponse> joinLobby(String lobbyCode) async {
  //   try {
  //     _isBusy = true;
  //     _errorMessage = null;
  //     notifyListeners();

  //     final res = await lobbyService.joinLobby(lobbyCode);
  //     if (res.success) {
  //       final createdLobby = res.data as Lobby;
  //       _currentLobby = createdLobby;
  //       await _startLobbyUpdates(createdLobby.lobbyCode);
  //       return GeneralResponse(
  //         success: true,
  //         data: createdLobby,
  //         message: 'Lobby created successfully',
  //       );
  //     } else {
  //       return GeneralResponse(success: false, message: res.message);
  //     }
  //   } catch (e) {
  //     _errorMessage = e.toString().replaceFirst('Exception: ', '');
  //     return GeneralResponse(success: false, message: 'Failed to create lobby');
  //   } finally {
  //     _isBusy = false;
  //     notifyListeners();
  //   }
  // }

  // Future<GeneralResponse> startLobby(String lobbyCode) async {
  //   try {
  //     _isBusy = true;
  //     _errorMessage = null;
  //     notifyListeners();

  //     final res = await lobbyService.startLobby(lobbyCode);
  //     if (res.success) {
  //       return GeneralResponse(
  //         success: true,
  //         message: 'Lobby started successfully',
  //       );
  //     } else {
  //       return GeneralResponse(success: false, message: res.message);
  //     }
  //   } catch (e) {
  //     _errorMessage = e.toString().replaceFirst('Exception: ', '');
  //     return GeneralResponse(success: false, message: 'Failed to start lobby');
  //   } finally {
  //     _isBusy = false;
  //     notifyListeners();
  //   }
  // }
}
