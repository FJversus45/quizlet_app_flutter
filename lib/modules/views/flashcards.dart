import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quizlet_app_flutter/core/loading_overlay_scaffold.dart';
import 'package:quizlet_app_flutter/core/snackbar.dart';
import 'package:quizlet_app_flutter/modules/model/flashcard_set.dart';
import 'package:quizlet_app_flutter/modules/model/flashcard.dart';
import 'package:quizlet_app_flutter/modules/provider/flashcard_provider.dart';
import 'package:quizlet_app_flutter/modules/views/flash_card_sets.dart';

class Flashcards extends StatefulWidget {
  final FlashcardSet flashcardSet;
  const Flashcards({super.key, required this.flashcardSet});

  @override
  State<Flashcards> createState() => _FlashcardsState();
}

class _FlashcardsState extends State<Flashcards> {
  bool isFlipped = false;
  int currentIndex = 0;

  late TextEditingController _questionController;
  late TextEditingController _answerController;

  // ─── Provider helpers ────────────────────────────────────────────────────

  /// The live FlashcardSet that lives inside the provider.
  FlashcardSet _liveSet(FlashcardProvider provider) =>
      provider.flashcardSets.firstWhere((s) => s.id == widget.flashcardSet.id);

  /// The live card list from the provider.
  List<Flashcard> _cards(FlashcardProvider provider) =>
      _liveSet(provider).flashcards;

  // ─── Lifecycle ───────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    _questionController = TextEditingController();
    _answerController = TextEditingController();

    // Defer so context (and provider) is available.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<FlashcardProvider>();

      // 1. Register the set in the provider if it isn't there yet.
      final exists = provider.flashcardSets.any(
        (s) => s.id == widget.flashcardSet.id,
      );
      if (!exists) {
        provider.flashcardSets.add(widget.flashcardSet);
        provider.notifyListeners();
      }

      // 2. Seed one blank card so the counter starts at 1/1, not 1/0.
      final cards = _cards(provider);
      if (cards.isEmpty) {
        cards.add(
          Flashcard(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            question: '',
            answer: '',
          ),
        );
        provider.notifyListeners();
      }

      // 3. Populate controllers from card 0.
      _loadCard(provider, 0);
    });
  }

  @override
  void dispose() {
    _questionController.dispose();
    _answerController.dispose();
    super.dispose();
  }

  // ─── Card helpers ────────────────────────────────────────────────────────

  /// Flush controller text back into the provider's card object.
  void _saveCurrentCard(FlashcardProvider provider) {
    final cards = _cards(provider);
    if (cards.isEmpty || currentIndex >= cards.length) return;
    cards[currentIndex].question = _questionController.text.trim();
    cards[currentIndex].answer = _answerController.text.trim();
    provider.notifyListeners();
  }

  /// Pull a card from the provider into the controllers.
  void _loadCard(FlashcardProvider provider, int index) {
    final cards = _cards(provider);
    if (cards.isEmpty || index >= cards.length) return;
    _questionController.text = cards[index].question ?? '';
    _answerController.text = cards[index].answer ?? '';
  }

  // ─── Navigation ──────────────────────────────────────────────────────────

  void flippedCard() => setState(() => isFlipped = !isFlipped);

  void goToPrevious(FlashcardProvider provider) {
    if (currentIndex <= 0) return;
    _saveCurrentCard(provider);
    setState(() {
      currentIndex--;
      isFlipped = false;
    });
    _loadCard(provider, currentIndex);
  }

  void goToNext(FlashcardProvider provider) {
    final cards = _cards(provider);

    if (currentIndex < cards.length - 1) {
      // Move to the next existing card.
      _saveCurrentCard(provider);
      setState(() {
        currentIndex++;
        isFlipped = false;
      });
      _loadCard(provider, currentIndex);
    } else {
      // On the last card — save it, then append a new blank card.
      _saveCurrentCard(provider);

      cards.add(
        Flashcard(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          question: '',
          answer: '',
        ),
      );
      provider.notifyListeners();

      setState(() {
        currentIndex = cards.length - 1;
        isFlipped = false;
      });

      _questionController.clear();
      _answerController.clear();
    }
  }

  // ─── Build ───────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Consumer<FlashcardProvider>(
      builder: (context, provider, _) {
        // Guard: provider may not have the set on the very first frame.
        final setExists = provider.flashcardSets.any(
          (s) => s.id == widget.flashcardSet.id,
        );
        if (!setExists) return const Scaffold(body: SizedBox.shrink());

        final cards = _cards(provider);
        final total = cards.length;

        return LoadingOverlayScaffold(
          isLoading: provider.isLoading,
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 15),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(
                              Icons.arrow_back,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 25),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.flashcardSet.subject,
                                style: GoogleFonts.montserrat(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black,
                                ),
                              ),
                              const Gap(3),
                              Text(
                                "${currentIndex + 1} / $total",
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0XFF808694),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF2E7FE),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: SvgPicture.asset("assets/icons/shuffle.svg"),
                      ),
                    ],
                  ),
                  const Gap(40),

                  // ── Flip card ────────────────────────────────────────────
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 600),
                        transitionBuilder: (child, animation) {
                          final rotate = Tween(
                            begin: pi,
                            end: 0.0,
                          ).animate(animation);
                          return AnimatedBuilder(
                            animation: rotate,
                            child: child,
                            builder: (context, child) {
                              final isUnder = ValueKey(isFlipped) != child!.key;
                              final tilt =
                                  ((animation.value - 0.5).abs() - 0.5) * 0.003;
                              final value = isUnder
                                  ? min(rotate.value, pi / 2)
                                  : rotate.value;
                              return Transform(
                                transform: Matrix4.rotationY(value)
                                  ..setEntry(3, 0, tilt),
                                alignment: Alignment.center,
                                child: child,
                              );
                            },
                          );
                        },
                        child: isFlipped
                            // Back face → Answer
                            ? _CardFace(
                                key: const ValueKey(true),
                                label: 'Answer',
                                controller: _answerController,
                                hintText: 'Type answer here',
                              )
                            // Front face → Question
                            : _CardFace(
                                key: const ValueKey(false),
                                label: 'Question',
                                controller: _questionController,
                                hintText: 'Type question here',
                              ),
                      ),
                    ),
                  ),

                  const Gap(30),

                  // ── Controls ─────────────────────────────────────────────
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: flippedCard,
                          child: Text(
                            "Tap card to flip",
                            style: GoogleFonts.montserrat(
                              fontSize: 18,
                              color: const Color(0xFF757c8a),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const Gap(30),
                        Row(
                          children: [
                            // ── Previous ──
                            Expanded(
                              child: ElevatedButton(
                                onPressed: currentIndex > 0
                                    ? () => goToPrevious(provider)
                                    : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFf9f9fa),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.arrow_back_ios,
                                        size: 16,
                                        color: Color(0XFF9aa0a9),
                                      ),
                                      const Gap(5),
                                      Text(
                                        "Previous",
                                        style: GoogleFonts.montserrat(
                                          fontSize: 16,
                                          color: const Color(0xFF9aa0a9),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const Gap(10),
                            // ── Next ──
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => goToNext(provider),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF9958FF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Next",
                                        style: GoogleFonts.montserrat(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const Gap(5),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Gap(20),
                        // ── Finish ──
                        SizedBox(
                          width: double.infinity,
                          height: 70,
                          child: ElevatedButton(
                            onPressed: () async {
                              _saveCurrentCard(provider);
                              debugPrint(
                                "Final flashcard set: ${_cards(provider)}",
                              );
                              await provider
                                  .createFlashcardSet(
                                    widget.flashcardSet.subject,
                                    _cards(provider),
                                  )
                                  .then((res) async {
                                    if (res.success) {
                                      SnackbarHandler.showSuccessSnackbar(
                                        context: context,
                                        message:
                                            "Flashcard set created successfully",
                                      );
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => FlashCardSets(),
                                        ),
                                      );
                                    } else {
                                      SnackbarHandler.showErrorSnackbar(
                                        context: context,
                                        message: res.message,
                                      );
                                    }
                                  });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF9958FF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "Finish",
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// ─── Reusable card-face widget ───────────────────────────────────────────────

class _CardFace extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hintText;

  const _CardFace({
    super.key,
    required this.label,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 650,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xFF9958FF),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: const Color(0XFFe4dcff),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Gap(25),
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hintText,
                    hintStyle: GoogleFonts.montserrat(
                      fontSize: 16,
                      color: const Color(0XFFe4dcff).withOpacity(0.5),
                    ),
                  ),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: const Color(0XFFe4dcff),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
