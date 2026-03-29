import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionBlock extends StatelessWidget {
  const QuestionBlock({
    super.key,
    required this.order,
    required this.question,
    this.onTap,
    this.backgroundColor,
    this.borderColor,
    this.badgeColor,
    this.badgeTextColor,
    this.textColor,
  });
  final String order;
  final String question;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? badgeColor;
  final Color? badgeTextColor;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 120,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: backgroundColor ?? Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                width: 1.5,
                color: borderColor ?? const Color(0xFFe5e7eb),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: badgeColor ?? const Color(0Xffe5e7eb),
                  ),
                  child: Text(
                    order,
                    style: GoogleFonts.montserrat(
                      color: badgeTextColor ?? const Color(0xFF101838),
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Gap(10),
                Expanded(
                  child: Text(
                    question,
                    style: GoogleFonts.montserrat(
                      color: textColor ?? Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    softWrap: true,
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
