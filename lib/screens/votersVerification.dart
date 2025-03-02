import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class VoterCardScreen extends StatefulWidget {
  const VoterCardScreen({super.key});

  @override
  State<VoterCardScreen> createState() => _VoterCardScreenState();
}

class _VoterCardScreenState extends State<VoterCardScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Image(
                      height: 24,
                      width: 24,
                      image: AssetImage('assets/images/back.png'),
                    ),
                  ),
                  Container(
                    width: 107,
                    height: 34,
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color:   Color(0xffBBBABB),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color:   Color(0xffBBBABB), width: 1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image(

                            image: AssetImage('assets/images/headphone.png'),
                          width: 15,height: 15,),
                          const SizedBox(width: 4),
                           Text(
                            'Need Help?',
                            style: GoogleFonts.hankenGrotesk(
                              textStyle: TextStyle(
                                color: Color(0xff000000),
                                fontSize: 13,
                                letterSpacing: 0.0,
                                height: 15 / 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Image(

              image: AssetImage('assets/images/idcard.png'),
              width: 341,height: 206,),
            const SizedBox(height: 36),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    'Verify using your voters card',
                    style: GoogleFonts.hankenGrotesk(
                      textStyle: TextStyle(
                        color: Color(0xff000000),
                        fontSize: 25.7,
                        letterSpacing: -0.37,
                        height:30.84 / 25.7,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
               Text(
                    'Enter your voters card number below',
                    style: GoogleFonts.hankenGrotesk(
                      textStyle: TextStyle(
                        color: Color(0xff2D333C),
                        fontSize: 12,
                        letterSpacing: 0.0,
                        height: 16.8 / 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    width: 347,
                    height: 64,
                    decoration: BoxDecoration(
                      color: Color(0xffFFFFFF),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TextField(

                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Voters Card Number',
                        hintStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: Color(0xffA6B7D4),
                            fontSize: 13,
                            letterSpacing: 0.0,
                            height: 19.5 / 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        prefixIcon: SvgPicture.asset(
                          'assets/icons/user.svg', width: 16, height: 16,

                          colorFilter: const ColorFilter.mode(
                              Color(0xff505780), BlendMode.srcIn),
                        ),

                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const SizedBox(height: 150),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: ElevatedButton(
                      onPressed: () {

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Continue',
                        style: GoogleFonts.hankenGrotesk(
                          textStyle: TextStyle(
                            color: Color(0xffFFFFFF),
                            fontSize: 14,
                            letterSpacing: 0.0,
                            height: 15.4 / 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
