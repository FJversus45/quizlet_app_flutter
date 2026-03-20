import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class PageBlocks extends StatelessWidget {
  const PageBlocks({
    super.key,
    required this.primaryColor,
    required this.secondaryColor,
    required this.text,
    required this.image,
  });
  final dynamic primaryColor;
  final dynamic secondaryColor;
  final String text;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(primaryColor),
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: Column(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color(secondaryColor),
              ),
              child: Padding(
                padding: EdgeInsetsGeometry.all(16),
                child: SvgPicture.asset(image),
              ),
            ),
            Gap(10),
            Center(
              child: Expanded(
                child: Text(
                  text,
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  softWrap: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
