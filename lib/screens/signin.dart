import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final Widget svgEmail = SvgPicture.asset(
      'assets/icons/email.svg',
      width: 21,
      height: 17,
      colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
    );
    final Widget svgGoogle = SvgPicture.asset(
      'assets/icons/google.svg',
      width: 23,
      height: 22,
    );
    return Scaffold(
      backgroundColor: Colors.white,
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
                style: GoogleFonts.hankenGrotesk(
                  textStyle: TextStyle(
                    color: Color(0xff000000),
                    fontSize: 25.7,
                    letterSpacing: -0.37,
                    height: 30.85 / 25.7,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 8),

              Text(
                'Securely access your account and manage payroll with ease.',
                style: GoogleFonts.hankenGrotesk(
                  textStyle: TextStyle(
                    color: Color(0xff626F84),
                    fontSize: 15,
                    letterSpacing: 0.0,
                    height: 21 / 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Email field with icon
              Container(
                width: 347,
                height: 64,
                decoration: BoxDecoration(
                  color: Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'user email goes here via the controller',
                    hintStyle: GoogleFonts.hankenGrotesk(
                      textStyle: TextStyle(
                        color: Color(0xff626F84),
                        fontSize: 13,
                        letterSpacing: 0.0,
                        height: 15 / 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    prefixIcon: SvgPicture.asset(
                      'assets/icons/user.svg', width: 16, height: 16,
                      //colorFilter: ColorFilter.mode(,
                      colorFilter: const ColorFilter.mode(
                          Color(0xff505780), BlendMode.srcIn),
                    ),
                    //contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                  ),
                ),
              ),
              const SizedBox(height: 16),

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
              const SizedBox(height: 24),

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
              // Google button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.black12),
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
              // Apple button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.black12),
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
