import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quizlet_app_flutter/core/loading_overlay_scaffold.dart';
import 'package:quizlet_app_flutter/core/snackbar.dart';
import 'package:quizlet_app_flutter/modules/provider/auth_provider.dart';
import 'package:quizlet_app_flutter/modules/provider/flashcard_provider.dart';
import 'package:quizlet_app_flutter/modules/views/home_view.dart';
import 'package:quizlet_app_flutter/modules/views/sign_up.dart';
import 'package:quizlet_app_flutter/modules/widgets/custom_text_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, FlashcardProvider>(
      builder: (context, auth, flashcard, _) {
        return LoadingOverlayScaffold(
          isLoading: auth.isLoading,
          child: Scaffold(
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
                        onPressed: () async {
                          await auth
                              .login(
                                emailController.text,
                                passwordController.text,
                              )
                              .then((res) async {
                                if (res.success) {
                                  SnackbarHandler.showSuccessSnackbar(
                                    context: context,
                                    message: "Login Successful",
                                  );
                                  await flashcard.getAllFlashcardSets();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomeView(),
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
                          backgroundColor: Color(0xFF9958FF),
                          padding: EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.all(
                              Radius.circular(8),
                            ),
                          ),
                        ),
                        child: Text(
                          "Log In",
                          style: GoogleFonts.montserrat(
                            color: Color(0xFFFFFFFF),
                          ),
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
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomeView()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffffffff),

                          padding: EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.all(
                              Radius.circular(8),
                            ),
                            side: BorderSide(
                              width: 1.5,
                              color: Color(0xFFE2E4E8),
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset("assets/icons/google.svg"),
                            Gap(50),
                            Text(
                              "Continue with Google",
                              style: GoogleFonts.montserrat(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Gap(15),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUp()),
                      );
                    },
                    child: Text(
                      "Don't have an account, Sign Up",
                      style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF9958FF),
                      ),
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
