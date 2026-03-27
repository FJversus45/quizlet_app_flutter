import 'package:quizlet_app_flutter/core/network/general_response.dart';
import 'package:quizlet_app_flutter/modules/views/flashcards.dart';

abstract class FlashCardSetsService {
  Future<GeneralResponse> createFlashcardSet(
    String subject,
    List<Flashcards> card,
  );
}
