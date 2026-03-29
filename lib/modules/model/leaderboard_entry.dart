import 'package:equatable/equatable.dart';
import 'package:quizlet_app_flutter/modules/model/user.dart';

class LeaderboardEntry extends Equatable {
  const LeaderboardEntry({
    required this.id,
    required this.score,
    required this.rank,
    required this.correctAnswers,
    required this.incorrectAnswers,
    required this.streak,
    required this.player,
  });

  final String id;
  final int score;
  final int rank;
  final int correctAnswers;
  final int incorrectAnswers;
  final int streak;
  final User player;

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) {
    return LeaderboardEntry(
      id: (json['id'] ?? '').toString(),
      score: (json['score'] as num?)?.toInt() ?? 0,
      rank: (json['rank'] as num?)?.toInt() ?? 0,
      correctAnswers: (json['correctAnswers'] as num?)?.toInt() ?? 0,
      incorrectAnswers: (json['incorrectAnswers'] as num?)?.toInt() ?? 0,
      streak: (json['streak'] as num?)?.toInt() ?? 0,
      player: User.fromJson(
        json['player'] as Map<String, dynamic>? ?? <String, dynamic>{},
      ),
    );
  }

  @override
  List<Object?> get props => <Object?>[
    id,
    score,
    rank,
    correctAnswers,
    incorrectAnswers,
    streak,
    player,
  ];
}
