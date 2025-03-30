import 'package:defifundr_mobile/core/constants/fonts.dart';
import 'package:defifundr_mobile/core/shared/textfield/app_text_field.dart';
import 'package:defifundr_mobile/core/themes/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final Widget svgEmail = SvgPicture.asset(
      'assets/icons/Message.svg',
      width: 21,
      height: 17,
    );
    final Widget svgGoogle = SvgPicture.asset(
      'assets/icons/google.svg',
      width: 23,
      height: 22,
    );
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Image(
                width: 29.5,
                height: 50.9,
                image: AssetImage('assets/images/defi_icon.png'),
              ),
              const SizedBox(height: 16),
              Text(
                'Sign in to DefiFundr',
                style: DefiFundrFonts.h2(context).copyWith(
                    fontSize: 26,
                    color: AppColors.black100,
                    fontWeight: FontWeight.w600),
              ),

              Text(
                'Securely access your account and manage payroll with ease.',
                style: DefiFundrFonts.b3(context).copyWith(
                  fontSize: 15,
                  color: AppColors.lightgrey626,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 40),
              AppTextField(
                prefixIcon: ClipRRect(
                  child: SizedBox(
                    height: 16,
                    width: 16,
                    child: Center(
                      child: SvgPicture.asset('assets/icons/user.svg'),
                    ),
                  ),
                ),
                label: 'test@defiFundr.com',
                controller: emailController,
              ),
              const SizedBox(height: 7),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot password?',
                    style: GoogleFonts.hankenGrotesk(
                      textStyle: TextStyle(
                        color: Color(0xff121212),
                        fontSize: 10,
                        letterSpacing: 0.0,
                        height: 1.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 54),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      svgEmail,
                      SizedBox(width: 12),
                      Text(
                        'Continue with Email',
                        style: GoogleFonts.hankenGrotesk(
                          textStyle: TextStyle(
                            color: Color(0xffFFFFFF),
                            fontSize: 14,
                            letterSpacing: 0.0,
                            height: 16.8 / 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.black200),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      svgGoogle,
                      const SizedBox(width: 12),
                      Text(
                        'Continue with Google',
                        style: GoogleFonts.hankenGrotesk(
                          textStyle: TextStyle(
                            color: Color(0xff212F20),
                            fontSize: 13,
                            letterSpacing: 0.0,
                            height: 15.6 / 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.black200),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                          width: 18.53,
                          height: 22,
                          image: AssetImage(
                            'assets/images/apple.png',
                          )),
                      SizedBox(width: 12),
                      Center(
                        child: Text(
                          'Sign in with Apple',
                          style: GoogleFonts.hankenGrotesk(
                            textStyle: TextStyle(
                              color: Color(0xff212F20),
                              fontSize: 14,
                              letterSpacing: 0.0,
                              height: 16.8 / 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 32.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account? ',
                        style: GoogleFonts.hankenGrotesk(
                          textStyle: TextStyle(
                            color: Color(0xff77869E),
                            fontSize: 12.08,
                            letterSpacing: 0.0,
                            height: 14.25 / 12.08,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'Sign up',
                          style: GoogleFonts.hankenGrotesk(
                            textStyle: TextStyle(
                              color: Color(0xff212F20),
                              fontSize: 12.08,
                              letterSpacing: 0.0,
                              height: 14.25 / 12.08,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Bottom indicator
              Center(
                child: Container(
                  width: 40,
                  height: 5,
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(2.5),
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
