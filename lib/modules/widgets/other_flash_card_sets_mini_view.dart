import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class OtherFlashCardSetsMiniView extends StatelessWidget {
  const OtherFlashCardSetsMiniView({
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
      height: 85,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white,
          border: Border.all(color: Color(0xFFC9CBCE), width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: Color(0xFF000000),
              ),
            ),
            Gap(3),
            Text(
              '$numberOfCards cards by $creatorName',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF6A7282),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
