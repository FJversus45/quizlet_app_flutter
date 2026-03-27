import 'package:equatable/equatable.dart';
import 'package:quizlet_app_flutter/modules/model/flashcard.dart';

class FlashcardSet extends Equatable {
  const FlashcardSet({
    required this.id,
    required this.subject,
    required this.numberOfCards,
    required this.flashcards,
    this.userId,
    this.createdAt,
  });

  final String id;
  final String subject;
  final int numberOfCards;
  final List<Flashcard> flashcards;
  final String? userId;
  final DateTime? createdAt;

  factory FlashcardSet.fromJson(Map<String, dynamic> json) {
    final flashcardsJson = (json['flashcards'] as List<dynamic>? ?? <dynamic>[])
        .whereType<Map<String, dynamic>>()
        .toList();

    return FlashcardSet(
      id: (json['id'] ?? '').toString(),
      subject: (json['subject'] ?? '').toString(),
      numberOfCards:
          (json['numberOfCards'] as num?)?.toInt() ?? flashcardsJson.length,
      flashcards: flashcardsJson.map(Flashcard.fromJson).toList(),
      userId: json['userId'] is String ? json['userId'] as String : null,
      createdAt: _parseDate(json['createdAt']),
    );
  }

  String get creatorName => userId != null ? 'User $userId' : 'Unknown creator';

  static DateTime? _parseDate(Object? value) {
    if (value is! String || value.isEmpty) {
      return null;
    }
    return DateTime.tryParse(value);
  }

  @override
  List<Object?> get props => <Object?>[
    id,
    subject,
    numberOfCards,
    flashcards,
    userId,
    createdAt,
  ];
}
