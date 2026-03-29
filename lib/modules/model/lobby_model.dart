import 'package:equatable/equatable.dart';
import 'package:quizlet_app_flutter/modules/model/flashcard_set.dart';
import 'package:quizlet_app_flutter/modules/model/leaderboard_entry.dart';
import 'package:quizlet_app_flutter/modules/model/user.dart';

class Lobby extends Equatable {
  const Lobby({
    required this.id,
    required this.lobbyCode,
    required this.lobbyStatus,
    required this.createdBy,
    required this.flashcardSet,
    required this.participatingPlayers,
    required this.leaderboardEntries,
  });

  final String id;
  final String lobbyCode;
  final String lobbyStatus;
  final User createdBy;
  final FlashcardSet flashcardSet;
  final List<User> participatingPlayers;
  final List<LeaderboardEntry> leaderboardEntries;

  Lobby copyWith({
    String? id,
    String? lobbyCode,
    String? lobbyStatus,
    User? createdBy,
    FlashcardSet? flashcardSet,
    List<User>? participatingPlayers,
    List<LeaderboardEntry>? leaderboardEntries,
  }) {
    return Lobby(
      id: id ?? this.id,
      lobbyCode: lobbyCode ?? this.lobbyCode,
      lobbyStatus: lobbyStatus ?? this.lobbyStatus,
      createdBy: createdBy ?? this.createdBy,
      flashcardSet: flashcardSet ?? this.flashcardSet,
      participatingPlayers: participatingPlayers ?? this.participatingPlayers,
      leaderboardEntries: leaderboardEntries ?? this.leaderboardEntries,
    );
  }

  Lobby mergeLeaderboardUpdate(Map<String, dynamic> json) {
    final updatedEntries = _parseLeaderboardEntries(json);
    final updatedPlayers = _playersFromEntries(updatedEntries);

    return copyWith(
      id: _readString(
        json,
        'id',
        fallback: _readString(json, 'lobbyId', fallback: id),
      ),
      lobbyCode: _readString(json, 'lobbyCode', fallback: lobbyCode),
      lobbyStatus: _readString(json, 'lobbyStatus', fallback: lobbyStatus),

      leaderboardEntries: updatedEntries.isEmpty
          ? leaderboardEntries
          : updatedEntries,

      participatingPlayers: updatedPlayers.isEmpty
          ? participatingPlayers
          : updatedPlayers,
    );
  }

  factory Lobby.fromJson(Map<String, dynamic> json) {
    final playersJson =
        (json['participatingPlayers'] as List<dynamic>? ?? <dynamic>[])
            .whereType<Map<String, dynamic>>()
            .toList();
    final entries = _parseLeaderboardEntries(json);

    return Lobby(
      id: _readString(json, 'id', fallback: _readString(json, 'lobbyId')),
      lobbyCode: _readString(json, 'lobbyCode'),
      lobbyStatus: _readString(json, 'lobbyStatus', fallback: 'WAITING'),
      createdBy: User.fromJson(
        json['createdBy'] as Map<String, dynamic>? ?? <String, dynamic>{},
      ),
      flashcardSet: FlashcardSet.fromJson(
        json['flashCardSet'] as Map<String, dynamic>? ?? <String, dynamic>{},
      ),
      participatingPlayers: playersJson.map(User.fromJson).toList(),
      leaderboardEntries: entries,
    );
  }

  static List<LeaderboardEntry> _parseLeaderboardEntries(
    Map<String, dynamic> json,
  ) {
    final rawEntries =
        (json['entries'] as List<dynamic>?) ??
        (json['leaderboard']?['entries'] as List<dynamic>?) ??
        const <dynamic>[];

    final leaderboardJson = rawEntries.whereType<Map<String, dynamic>>().toList();

    return leaderboardJson.map(LeaderboardEntry.fromJson).toList()
      ..sort((a, b) => a.rank.compareTo(b.rank));
  }

  static List<User> _playersFromEntries(List<LeaderboardEntry> entries) {
    final seenIds = <String>{};
    final players = <User>[];

    for (final entry in entries) {
      final player = entry.player;

      if (player.fullName.isEmpty || !seenIds.add(player.fullName)) {
        continue;
      }
      players.add(player);
    }

    return players;
  }

  static String _readString(
    Map<String, dynamic> json,
    String key, {
    String fallback = '',
  }) {
    final value = json[key];
    if (value is String && value.isNotEmpty) {
      return value;
    }
    return fallback;
  }

  @override
  List<Object?> get props => <Object?>[
    id,
    lobbyCode,
    lobbyStatus,
    createdBy,
    flashcardSet,
    participatingPlayers,
    leaderboardEntries,
  ];
}
