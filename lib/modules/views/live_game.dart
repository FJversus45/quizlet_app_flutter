import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quizlet_app_flutter/core/snackbar.dart';
import 'package:quizlet_app_flutter/modules/model/flashcard.dart';
import 'package:quizlet_app_flutter/modules/model/lobby_model.dart';
import 'package:quizlet_app_flutter/modules/model/leaderboard_entry.dart';
import 'package:quizlet_app_flutter/modules/provider/auth_provider.dart';
import 'package:quizlet_app_flutter/modules/provider/lobby_provider.dart';
import 'package:quizlet_app_flutter/modules/widgets/question_block.dart';

class LiveGame extends StatefulWidget {
  const LiveGame({super.key});

  @override
  State<LiveGame> createState() => _LiveGameState();
}

class _LiveGameState extends State<LiveGame> {
  static const int _questionDurationSeconds = 15;
  static const List<String> _optionLabels = <String>['A', 'B', 'C', 'D'];

  Timer? _timer;
  int _timeRemaining = _questionDurationSeconds;
  int _currentQuestionIndex = 0;
  String? _preparedLobbyId;
  String? _selectedAnswer;
  String? _resolvedAnswer;
  bool? _wasCorrect;
  bool _isSubmitting = false;
  bool _isAdvancing = false;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _prepareGameIfNeeded(Lobby? lobby) {
    if (lobby == null || _preparedLobbyId == lobby.id) {
      return;
    }

    _preparedLobbyId = lobby.id;
    _timer?.cancel();
    _currentQuestionIndex = 0;
    _timeRemaining = _questionDurationSeconds;
    _selectedAnswer = null;
    _resolvedAnswer = null;
    _wasCorrect = null;
    _isSubmitting = false;
    _isAdvancing = false;

    if (lobby.flashcardSet.flashcards.isNotEmpty) {
      _startTimer();
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      if (_timeRemaining <= 1) {
        timer.cancel();
        _handleTimeExpired();
        return;
      }

      setState(() {
        _timeRemaining -= 1;
      });
    });
  }

  void _handleTimeExpired() {
    final lobby = context.read<LobbyNotifier>().currentLobby;
    final flashcards = lobby?.flashcardSet.flashcards ?? const <Flashcard>[];
    if (_currentQuestionIndex >= flashcards.length || _resolvedAnswer != null) {
      return;
    }

    final correctAnswer = _cleanAnswer(flashcards[_currentQuestionIndex].answer);
    setState(() {
      _timeRemaining = 0;
      _selectedAnswer = null;
      _resolvedAnswer = correctAnswer;
      _wasCorrect = false;
    });

    _advanceToNextQuestion(flashcards.length);
  }

  Future<void> _handleAnswerTap(
    LobbyNotifier lobbyNotifier,
    Lobby lobby,
    String answer,
  ) async {
    final flashcards = lobby.flashcardSet.flashcards;
    if (_currentQuestionIndex >= flashcards.length ||
        _resolvedAnswer != null ||
        _isSubmitting ||
        _isAdvancing) {
      return;
    }

    final correctAnswer = _cleanAnswer(flashcards[_currentQuestionIndex].answer);
    final normalizedAnswer = answer.trim();
    final isCorrect = normalizedAnswer == correctAnswer;

    setState(() {
      _selectedAnswer = normalizedAnswer;
      _resolvedAnswer = correctAnswer;
      _wasCorrect = isCorrect;
      _isSubmitting = isCorrect;
    });

    _timer?.cancel();

    if (isCorrect) {
      final res = await lobbyNotifier.submitAnswer(true, lobby.lobbyCode);
      if (!mounted) {
        return;
      }

      if (!res.success) {
        SnackbarHandler.showErrorSnackbar(
          context: context,
          message: res.message,
        );
      }
    }

    if (!mounted) {
      return;
    }

    setState(() {
      _isSubmitting = false;
    });

    _advanceToNextQuestion(flashcards.length);
  }

  Future<void> _advanceToNextQuestion(int totalQuestions) async {
    if (_isAdvancing) {
      return;
    }

    _isAdvancing = true;
    await Future<void>.delayed(const Duration(seconds: 1));
    if (!mounted) {
      return;
    }

    final isLastQuestion = _currentQuestionIndex >= totalQuestions - 1;
    setState(() {
      if (!isLastQuestion) {
        _currentQuestionIndex += 1;
        _timeRemaining = _questionDurationSeconds;
      } else {
        _currentQuestionIndex = totalQuestions;
        _timeRemaining = 0;
      }

      _selectedAnswer = null;
      _resolvedAnswer = null;
      _wasCorrect = null;
      _isSubmitting = false;
      _isAdvancing = false;
    });

    if (!isLastQuestion) {
      _startTimer();
    } else {
      _timer?.cancel();
    }
  }

  List<String> _buildOptions(Lobby lobby, Flashcard currentFlashcard) {
    final correctAnswer = _cleanAnswer(currentFlashcard.answer);
    final answerPool = lobby.flashcardSet.flashcards
        .map((flashcard) => _cleanAnswer(flashcard.answer))
        .where((answer) => answer.isNotEmpty)
        .toSet()
        .toList()
      ..sort();

    if (correctAnswer.isEmpty) {
      return answerPool.take(_optionLabels.length).toList();
    }

    if (!answerPool.contains(correctAnswer)) {
      answerPool.add(correctAnswer);
    }

    if (answerPool.length <= _optionLabels.length) {
      return answerPool;
    }

    final distractors = answerPool.where((answer) => answer != correctAnswer).toList()
      ..shuffle(Random(Object.hash(lobby.id, _currentQuestionIndex, 'pool')));

    final options = <String>[
      correctAnswer,
      ...distractors.take(_optionLabels.length - 1),
    ]..shuffle(Random(Object.hash(lobby.id, _currentQuestionIndex, 'options')));

    return options;
  }

  String _cleanAnswer(String? value) => value?.trim() ?? '';

  bool get _hasAnsweredCurrentQuestion => _resolvedAnswer != null;

  @override
  Widget build(BuildContext context) {
    return Consumer2<LobbyNotifier, AuthProvider>(
      builder: (context, lobbyNotifier, authProvider, _) {
        final lobby = lobbyNotifier.currentLobby;
        _prepareGameIfNeeded(lobby);

        if (lobby == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Live Game')),
            body: Center(
              child: Text(
                'No active lobby found.',
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        }

        final flashcards = lobby.flashcardSet.flashcards;
        final totalQuestions = flashcards.length;
        final isGameFinished = totalQuestions == 0 ||
            _currentQuestionIndex >= totalQuestions;
        final currentFlashcard = isGameFinished
            ? null
            : flashcards[_currentQuestionIndex];
        final options = currentFlashcard == null
            ? const <String>[]
            : _buildOptions(lobby, currentFlashcard);
        final currentUserId = authProvider.currentUser?.id;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              lobby.flashcardSet.subject,
              style: GoogleFonts.montserrat(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.timer_outlined, color: Colors.black),
                          Gap(5),
                          Text(
                            '${_timeRemaining}s',
                            style: GoogleFonts.montserrat(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        totalQuestions == 0
                            ? 'Question 0/0'
                            : 'Question ${isGameFinished ? totalQuestions : _currentQuestionIndex + 1}/$totalQuestions',
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          color: const Color(0xFF838997),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Gap(24),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xFF9958FF),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isGameFinished ? 'Game Finished' : 'Question',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            color: const Color(0xFFE9DDFE),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Gap(12),
                        Text(
                          currentFlashcard?.question ?? 'You have completed this round.',
                          style: GoogleFonts.montserrat(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(20),
                  if (!isGameFinished) ...[
                    for (var index = 0; index < options.length; index++) ...[
                      QuestionBlock(
                        order: _optionLabels[index],
                        question: options[index],
                        onTap: () =>
                            _handleAnswerTap(lobbyNotifier, lobby, options[index]),
                        backgroundColor: _optionBackgroundColor(options[index]),
                        borderColor: _optionBorderColor(options[index]),
                        badgeColor: _optionBadgeColor(options[index]),
                        badgeTextColor: _optionBadgeTextColor(options[index]),
                        textColor: _optionTextColor(options[index]),
                      ),
                      if (index != options.length - 1) Gap(10),
                    ],
                  ] else ...[
                    _buildFinishedState(),
                  ],
                  Gap(20),
                  if (_hasAnsweredCurrentQuestion) _buildAnswerFeedback(),
                  Gap(20),
                  _buildLeaderboardCard(
                    entries: lobby.leaderboardEntries,
                    currentUserId: currentUserId,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFinishedState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F0FF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        'All questions answered. Waiting for the final leaderboard.',
        style: GoogleFonts.montserrat(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF4C1D95),
        ),
      ),
    );
  }

  Widget _buildAnswerFeedback() {
    final wasCorrect = _wasCorrect ?? false;
    final title = wasCorrect ? 'Correct!' : 'Next Question';
    final backgroundColor = wasCorrect
        ? const Color(0xFFF0FDF4)
        : const Color(0xFFFFF1F2);
    final borderColor = wasCorrect
        ? const Color(0xFFBBF7D0)
        : const Color(0xFFFECDD3);
    final textColor = wasCorrect
        ? const Color(0xFF166534)
        : const Color(0xFF9F1239);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 1.5, color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.montserrat(
              fontSize: 18,
              color: textColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          Gap(8),
          Text(
            'Correct answer: ${_resolvedAnswer ?? ''}',
            style: GoogleFonts.montserrat(
              fontSize: 15,
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeaderboardCard({
    required List<LeaderboardEntry> entries,
    required String? currentUserId,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 1, color: const Color(0xFFE5E7EB)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.leaderboard_outlined,
                color: Color(0xFF9958FF),
                size: 24,
              ),
              Gap(10),
              Text(
                'Live Leaderboard',
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Gap(16),
          if (entries.isEmpty)
            Text(
              'Waiting for leaderboard updates.',
              style: GoogleFonts.montserrat(
                fontSize: 15,
                color: const Color(0xFF667085),
                fontWeight: FontWeight.w500,
              ),
            )
          else
            for (final entry in entries) ...[
              _buildLeaderboardRow(entry, currentUserId),
              if (entry != entries.last) Gap(12),
            ],
        ],
      ),
    );
  }

  Widget _buildLeaderboardRow(LeaderboardEntry entry, String? currentUserId) {
    final isCurrentUser = entry.player.id == currentUserId;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: isCurrentUser ? const Color(0xFFF5F3FF) : const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Text(
                  '${entry.rank}.',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: const Color(0xFF6B7280),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gap(10),
                Expanded(
                  child: Text(
                    isCurrentUser
                        ? '${entry.player.fullName} (You)'
                        : entry.player.fullName,
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${entry.score}',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: const Color(0xFF9958FF),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Color _optionBackgroundColor(String option) {
    if (!_hasAnsweredCurrentQuestion) {
      return Colors.white;
    }

    if (option == _resolvedAnswer) {
      return const Color(0xFFF0FDF4);
    }

    if (option == _selectedAnswer && option != _resolvedAnswer) {
      return const Color(0xFFFFF1F2);
    }

    return Colors.white;
  }

  Color _optionBorderColor(String option) {
    if (!_hasAnsweredCurrentQuestion) {
      return const Color(0xFFE5E7EB);
    }

    if (option == _resolvedAnswer) {
      return const Color(0xFF22C55E);
    }

    if (option == _selectedAnswer && option != _resolvedAnswer) {
      return const Color(0xFFF43F5E);
    }

    return const Color(0xFFE5E7EB);
  }

  Color _optionBadgeColor(String option) {
    if (!_hasAnsweredCurrentQuestion) {
      return const Color(0xFFE5E7EB);
    }

    if (option == _resolvedAnswer) {
      return const Color(0xFFDCFCE7);
    }

    if (option == _selectedAnswer && option != _resolvedAnswer) {
      return const Color(0xFFFFE4E6);
    }

    return const Color(0xFFE5E7EB);
  }

  Color _optionBadgeTextColor(String option) {
    if (!_hasAnsweredCurrentQuestion) {
      return const Color(0xFF101838);
    }

    if (option == _resolvedAnswer) {
      return const Color(0xFF166534);
    }

    if (option == _selectedAnswer && option != _resolvedAnswer) {
      return const Color(0xFF9F1239);
    }

    return const Color(0xFF101838);
  }

  Color _optionTextColor(String option) {
    if (!_hasAnsweredCurrentQuestion) {
      return Colors.black;
    }

    if (option == _resolvedAnswer) {
      return const Color(0xFF166534);
    }

    if (option == _selectedAnswer && option != _resolvedAnswer) {
      return const Color(0xFF9F1239);
    }

    return Colors.black;
  }
}
