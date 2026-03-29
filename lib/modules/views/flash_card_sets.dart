import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quizlet_app_flutter/modules/provider/auth_provider.dart';
import 'package:quizlet_app_flutter/modules/provider/flashcard_provider.dart';
import 'package:quizlet_app_flutter/modules/views/flashcards.dart';
import 'package:quizlet_app_flutter/modules/views/ready_practice.dart';
import 'package:quizlet_app_flutter/modules/widgets/flash_card_sets_mini_view.dart';

class FlashCardSets extends StatefulWidget {
  const FlashCardSets({super.key});

  @override
  State<FlashCardSets> createState() => _FlashCardSetsState();
}

class _FlashCardSetsState extends State<FlashCardSets> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<FlashcardProvider, AuthProvider>(
      builder: (context, provider, auth, _) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "My Flashcard Sets",
                        style: GoogleFonts.montserrat(
                          fontSize: 27,
                          fontWeight: FontWeight.w700,
                          color: Color(0Xff000000),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Color(0xFF9958FF),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: SvgPicture.asset("assets/icons/plus.svg"),
                      ),
                    ],
                  ),
                  Gap(40),
                  // Expanded(child: ListView.builder(
                  //   itemCount: ,
                  //   itemBuilder: (context, index){
                  //   final flashCardSet =
                  //   return ListTile(
                  //     onTap: (){

                  //     },
                  //   )
                  // }))
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: provider.flashcardSets.length,
                    itemBuilder: (context, index) {
                      final flash = provider.flashcardSets[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Flashcards(flashcardSet: flash),
                            ),
                          );
                        },
                        child: FlashCardSetsMiniView(
                          title: flash.subject,
                          numberOfCards: flash.flashcards.length,
                          // divide the fullname in two and use the first part as the name of the creator
                          creatorName: auth.currentUser!.fullName.split(" ")[0],
                        ),
                      );
                    },
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
