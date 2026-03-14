import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SnackbarHandler {
  static void showErrorSnackbar({
    required BuildContext context,
    String? message,
    Widget? icon,
  }) {
    return showTopSnackBar(
      Overlay.of(context),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
      Material(
        type: MaterialType.transparency,
        child: Container(
          // width: MediaQuery.sizeOf(context).width,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.red),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              icon ?? const Icon(Icons.error, color: Colors.white),
              const Gap(12),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.sizeOf(context).width * .7,
                ),
                child: ClipRRect(
                  child: Text(
                    message ?? "An error occurred",
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void showSuccessSnackbar({
    required BuildContext context,
    String? message,
    Widget? icon,
  }) {
    return showTopSnackBar(
      Overlay.of(context),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
      Material(
        type: MaterialType.transparency,
        child: Container(
          // width: MediaQuery.sizeOf(context).width,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blue),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              icon ?? const Icon(Icons.check_circle, color: Colors.white),
              const Gap(12),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.sizeOf(context).width * .7,
                ),
                child: ClipRRect(
                  child: Text(
                    message ?? "Successful",
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
