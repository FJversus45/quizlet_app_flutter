import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class FlashCardSetsMiniView extends StatelessWidget {
  const FlashCardSetsMiniView({
    super.key,
    required this.title,
    required this.numberOfCards,
    required this.creatorName,
  });
  final String title;
  final int numberOfCards;
  final String creatorName;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Gap(5),
              Text(
                "$numberOfCards cards by $creatorName",
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  color: Color(0xFF717988),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Gap(12),
              Center(
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF9958FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 16,
                              height: 16,
                              child: SvgPicture.asset("assets/icons/book.svg"),
                            ),
                            Gap(5),
                            Text(
                              "Study",
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Gap(10),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFFFFFF),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(
                            width: 1.5,
                            color: Color(0xFF9958FF),
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 16,
                              height: 16,
                              child: SvgPicture.asset("assets/icons/play.svg"),
                            ),
                            Gap(5),
                            Text(
                              "Quiz",
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                color: Color(0xFF9958FF),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
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
  }
}
