
import 'dart:ui';

import 'package:defifundr_mobile/core/constants/app_texts.dart';
import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SigninWithEmail extends StatefulWidget {
  const SigninWithEmail({super.key});

  @override
  State<SigninWithEmail> createState() => _SigninWithEmailState();
}

class _SigninWithEmailState extends State<SigninWithEmail> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 250, 250, 250),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  AppAssets.logo,
                  width: 29.5,
                  height: 50.9,
                ),
                SizedBox(height: 16),
                Text(
                'Sign in to DefiFundr',
                style: TextStyle(
                    color: Color(0xff000000),
                    fontSize: 25.7,
                    letterSpacing: -0.37,
                    height: 30.85 / 25.7,
                    fontWeight: FontWeight.w600,
                    fontFamily: GoogleFonts.hankenGrotesk().fontFamily,
                ),
                ),
                SizedBox(height: 3),
                Text(
                  'Securely access your account and manage payroll with ease.', style: TextStyle(
                    color: Color(0xff626F84),
                    fontSize: 15,
                    letterSpacing: 0.0,
                    height: 21 / 15,
                    fontWeight: FontWeight.w500,  
                    fontFamily: GoogleFonts.hankenGrotesk().fontFamily,
                  ),
                ),
                SizedBox(height: 30),

              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: SvgPicture.asset(AppAssets.person, fit: BoxFit.scaleDown,),
                  hintText: 'test@defiFundr.com',
                  hintStyle: GoogleFonts.hankenGrotesk(
                      textStyle: TextStyle(
                        color: Color(0xff626F84),
                        fontSize: 13,
                        letterSpacing: 0.0,
                        height: 15 / 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  fillColor: Color.fromRGBO(255, 255, 255, 1),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),

                SizedBox(height: 10),
              TextField(
                obscureText: _obscurePassword,
                controller: _passwordController,
                decoration: InputDecoration(
                  prefixIcon: SvgPicture.asset(AppAssets.lockIcon, fit: BoxFit.scaleDown,),
                  suffixIcon: SvgPicture.asset(AppAssets.crossEye, fit: BoxFit.scaleDown,),
                  hintText: AppTexts.enterPassword,
                  hintStyle: GoogleFonts.hankenGrotesk(
                      textStyle: TextStyle(
                        color: Color(0xff626F84),
                        fontSize: 13,
                        letterSpacing: 0.0,
                        height: 15 / 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  fillColor: Color.fromRGBO(255, 255, 255, 1),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),

                SizedBox(height: 10),
            
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                      AppTexts.passWordForgot,
                      style: TextStyle(
                          color: Color(0xff121212),
                          fontSize: 10,
                          letterSpacing: 0.0,
                          height: 1.5,
                          fontWeight: FontWeight.w600,
                          fontFamily: GoogleFonts.hankenGrotesk().fontFamily,
                        ),
                      ),
                    ),

                    SizedBox(height: 25),

                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    minimumSize: const Size(double.infinity, 49),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      color: const Color(0xffFFFFFF),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: GoogleFonts.hankenGrotesk().fontFamily,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppTexts.dontHaveAccount,
                        style: TextStyle(
                          color: Color(0xff77869E),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: GoogleFonts.hankenGrotesk().fontFamily,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                          AppTexts.signUp,
                          style: TextStyle(
                            color: Color(0xff121212),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            fontFamily: GoogleFonts.hankenGrotesk().fontFamily,
                          ),
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
