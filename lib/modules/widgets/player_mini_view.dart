import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class PlayerMiniView extends StatelessWidget {
  const PlayerMiniView({
    super.key,
    required this.role,
    required this.name,
    required this.perspective,
  });
  final String role;
  final String name;
  final String perspective;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(18),
              decoration: ShapeDecoration(
                shape: CircleBorder(),
                color: Color(0xFF9958FF),
              ),
              child: Text(
                'G',
                style: GoogleFonts.montserrat(
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
            Gap(12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gap(3),
                Text(
                  role,
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    color: Color(0xFF9958FF),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
        Text(
          "($perspective)",
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w500,
            color: Color(0xFF575E6B),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
