


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordValidationScreen extends StatefulWidget {
  const PasswordValidationScreen({super.key});

  @override
  State<PasswordValidationScreen> createState() =>
      _PasswordValidationScreenState();
}

class _PasswordValidationScreenState extends State<PasswordValidationScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  bool get minLength => passwordController.text.length >= 8;
  bool get hasUppercase => passwordController.text.contains(RegExp(r'[A-Z]'));
  bool get hasLowercase => passwordController.text.contains(RegExp(r'[a-z]'));
  bool get hasNumber => passwordController.text.contains(RegExp(r'[0-9]'));
  bool get hasSpecialChar =>
      passwordController.text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  bool get passwordsMatch =>
      passwordController.text == confirmPasswordController.text &&
          confirmPasswordController.text.isNotEmpty;

  bool get isPasswordValid =>
      minLength &&
          hasUppercase &&
          hasLowercase &&
          hasNumber &&
          hasSpecialChar;
  bool get canSubmit => isPasswordValid && passwordsMatch;

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Image(
            color: Color(0xff18181B),
            height: 17.4.h,
            width: 8.75.w,
            image: AssetImage('assets/images/back.png'),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 32,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: Color(0xff18181B), width: 1),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image(
                    color: Color(0xff18181B),
                    height: 16.h,
                    width: 16.w,
                    image: AssetImage('assets/images/headphone.png'),
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Need Help?',
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        color: Color(0xff18181B),
                        letterSpacing: 0,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        height: 16 / 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Create Your Password',
              style: TextStyle(
                fontFamily: 'HankenGrotesk',
                fontWeight: FontWeight.w700,
                fontSize: 24.sp,
                height: 32 / 24,
                color: Color(0xff18181B),
                letterSpacing: 0,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Enter password to keep your account safe and secure.',
              style: TextStyle(
                fontFamily: 'HankenGrotesk',
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                height: 20 / 14,
                color: Color(0xff71717A),
                letterSpacing: 0,
              ),
            ),
            const SizedBox(height: 24),

            // Password Field
            TextField(
              controller: passwordController,
              obscureText: obscurePassword,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                labelText: 'Password',
                contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                suffixIcon: IconButton(
                  icon: Icon(obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined),
                  onPressed: () =>
                      setState(() => obscurePassword = !obscurePassword),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Password Requirements
            Row(
              children: [
                Text(
                  'Must Contain At Least:',
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      color: Color(0xff71717A),
                      letterSpacing: 0,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      height: 16 / 12,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  '8 characters',
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      color: passwordController.text.isEmpty
                          ? Color(0xff71717A)
                          : minLength
                          ? Color(0xff16a34A)
                          : Color(0xffDC2626),
                      letterSpacing: 0,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      height: 16 / 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Validation Checks
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              childAspectRatio: 5,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              mainAxisSpacing: 4,
              children: [
                requiredItem('An uppercase letter', hasUppercase),
                requiredItem('A number', hasNumber),
                requiredItem('A lowercase letter', hasLowercase),
                requiredItem('A special character', hasSpecialChar),
              ],
            ),
            const SizedBox(height: 24),

            // Confirm Password Field
            TextField(
              controller: confirmPasswordController,
              obscureText: obscureConfirmPassword,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                labelText: 'Confirm password',
                contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                suffixIcon: IconButton(
                  icon: Icon(obscureConfirmPassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined),
                  onPressed: () => setState(() =>
                  obscureConfirmPassword = !obscureConfirmPassword),
                ),
              ),
            ),

            Expanded(child: SizedBox()),

            /// Submit Button
            GestureDetector(
              onTap: canSubmit ? () {} : null,
              child: Container(
                width: double.infinity,
                height: 48,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color:  Color(0xff18181B),
                  borderRadius: BorderRadius.circular(200),
                ),
                child: Center(
                  child: Text(
                    'Reset password',
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        color: Colors.white,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        height: 24 / 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget requiredItem(String label, bool isMet) {
    bool shouldShowIcon = passwordController.text.isNotEmpty;

    return Row(
      children: [
        if (shouldShowIcon)
          Icon(
            isMet ? Icons.check_circle : Icons.cancel,
            size: 16,
            color: isMet ? Color(0xff16a34A) : Color(0xffDC2626),
          ),
        SizedBox(width: shouldShowIcon ? 4 : 0),
        Text(
          label,
          style: GoogleFonts.inter(
            textStyle: TextStyle(
              color: passwordController.text.isEmpty
                  ? Color(0xff71717A)
                  : isMet
                  ? Color(0xff16a34A)
                  : Color(0xffDC2626),
              letterSpacing: 0,
              fontWeight: FontWeight.w600,
              fontSize: 12,
              height: 16 / 12,
            ),
          ),
        ),
      ],
    );
  }
}