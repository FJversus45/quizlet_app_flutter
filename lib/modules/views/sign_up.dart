import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizlet_app_flutter/modules/widgets/custom_text_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Gap(50),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Color(0xFF9958FF),
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Expanded(
                  child: SvgPicture.asset("assets/icons/brain.svg"),
                ),
              ),
            ),

            Gap(15),
            Text(
              "Quizlet+",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w800,
                fontSize: 40,
                color: Color(0xFF9958FF),
              ),
            ),
            Gap(10),
            Text(
              "Learn smarter, not harder",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: Color(0xFF697181),
              ),
            ),
            Gap(50),
            CustomTextField(
              labelText: 'Name',
              hintText: "Enter your name",
              controller: nameController,
            ),
            Gap(8),
            CustomTextField(
              labelText: 'Email',
              hintText: "Enter your email",
              controller: emailController,
            ),
            Gap(8),
            CustomTextField(
              labelText: 'Password',
              hintText: "Enter your password",
              controller: passwordController,
            ),

            // Gap(5),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF9958FF),
                    padding: EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.all(
                        Radius.circular(8),
                      ),
                    ),
                  ),
                  child: Text(
                    "Sign Up",
                    style: GoogleFonts.montserrat(color: Color(0xFFFFFFFF)),
                  ),
                ),
              ),
            ),
            Gap(5),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xfffffffff),

                    padding: EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.all(
                        Radius.circular(8),
                      ),
                      side: BorderSide(width: 1.5, color: Color(0xFFE2E4E8)),
                    ),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/icons/google.svg"),
                      Gap(50),
                      Text(
                        "Continue with Google",
                        style: GoogleFonts.montserrat(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Gap(15),
            Text(
              "Already have an account? Log In",
              style: GoogleFonts.montserrat(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Color(0xFF9958FF),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
