import 'package:equatable/equatable.dart';

class Flashcard extends Equatable {
  const Flashcard({
    required this.id,
    required this.question,
    required this.answer,
    this.createdAt,
  });

  final String id;
  final String question;
  final String answer;
  final DateTime? createdAt;

  factory Flashcard.fromJson(Map<String, dynamic> json) {
    return Flashcard(
      id: (json['id'] ?? '').toString(),
      question: (json['question'] ?? '').toString(),
      answer: (json['answer'] ?? '').toString(),
      createdAt: _parseDate(json['createdAt']),
    );
  }

  Map<String, dynamic> toInput() {
    return <String, dynamic>{'question': question, 'answer': answer};
  }

  static DateTime? _parseDate(Object? value) {
    if (value is! String || value.isEmpty) {
      return null;
    }
    return DateTime.tryParse(value);
  }

  @override
  List<Object?> get props => <Object?>[id, question, answer, createdAt];
}
