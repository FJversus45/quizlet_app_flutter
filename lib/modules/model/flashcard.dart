import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Flashcard extends Equatable {
  Flashcard({this.id, this.question, this.answer, this.createdAt});

  String? id;
  String? question;
  String? answer;
  DateTime? createdAt;

  factory Flashcard.fromJson(Map<String, dynamic> json) {
    return Flashcard(
      id: (json['id'] ?? '').toString(),
      question: (json['question'] ?? '').toString(),
      answer: (json['answer'] ?? '').toString(),
      createdAt: _parseDate(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
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
