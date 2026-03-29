import 'package:quizlet_app_flutter/core/network/general_response.dart';
import 'package:quizlet_app_flutter/modules/model/flashcard.dart';

abstract class FlashCardSetsService {
  Future<GeneralResponse> createFlashcardSet(
    String subject,
    List<Flashcard> card,
  );

  Future<GeneralResponse> getAllFlashcardSet();
}
