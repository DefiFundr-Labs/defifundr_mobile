import 'package:defifundr_mobile/app/app.dart';
import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
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
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.black100,
            size: 20,
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
                border: Border.all(color: AppColors.black100, width: 1),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image(
                    color: AppColors.black100,
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
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),

        ),
        child: Padding(

          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Text(
                'Create Your Password',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  height: 32 / 24,
                  color: Color(0xff18181B),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Enter password to keep your account safe and secure.',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  height: 20 / 14,
                  color: Color(0xff71717A),
                ),
              ),
              SizedBox(height: 32),

              // Password Field
              Container(
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.brandHover, width: 1),
                ),
                child: TextField(
                  controller: passwordController,
                  obscureText: obscurePassword,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: Color(0xff71717A),
                      ),
                      onPressed: () =>
                          setState(() => obscurePassword = !obscurePassword),
                    ),
                    labelStyle: TextStyle(
                      fontFamily: 'Inter',
                      color: Color(0xff71717A),
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),

              // Password Requirements
              Row(
                children: [
                  Text(
                    'Must Contain At Least:',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      color: Color(0xff71717A),
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(width: 4),

                  _buildRequirementItem('8 characters', minLength  ),
                ],
              ),
              SizedBox(height: 12),

              // Validation Checks
              Wrap(
                spacing: 16,
                runSpacing: 12,
                children: [
                  _buildRequirementItem('A number', hasNumber),
                  _buildRequirementItem('An uppercase letter', hasUppercase),

                  _buildRequirementItem('A lowercase letter', hasLowercase),
                  _buildRequirementItem('A special character', hasSpecialChar),
                ],
              ),
              SizedBox(height: 32),

              // Confirm Password Field
              Container(
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xFFE2E8F0), width: 1),
                ),
                child: TextField(
                  controller: confirmPasswordController,
                  obscureText: obscureConfirmPassword,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    labelText: 'Confirm password',
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscureConfirmPassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: Color(0xff71717A),
                      ),
                      onPressed: () => setState(() =>
                      obscureConfirmPassword = !obscureConfirmPassword),
                    ),
                    labelStyle: TextStyle(
                      fontFamily: 'Inter',
                      color: Color(0xff71717A),
                      fontSize: 14,
                    ),
                  ),
                ),
              ),

              Spacer(),

              // Submit Button
              GestureDetector(
                onTap: canSubmit ? () {} : null,
                child: Container(
                  width: double.infinity,
                  height: 48,
                  margin: EdgeInsets.only(bottom: 24),
                  decoration: BoxDecoration(
                    color: Color(0xff18181B),
                    borderRadius: BorderRadius.circular(200),
                  ),
                  child: Center(
                    child: Text(
                      'Reset password',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
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

  Widget _buildRequirementItem(String label, bool isMet) {
    bool shouldShowIcon = passwordController.text.isNotEmpty;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: passwordController.text.isEmpty
            ? Color(0xFFF7F7F7)
            : isMet
            ? AppColors.greenFill
            : AppColors.redFill,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: passwordController.text.isEmpty
              ? Color(0xFFE6E6E6)
              : isMet
              ? Color(0xFFB2E6B2)
              : Color(0xFFFFBFBF),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (shouldShowIcon)
            Icon(
              isMet ? Icons.check : Icons.close,
              size: 14,
              color: isMet ? AppColors.greenDefault : AppColors.redDefault,
            ),
          if (shouldShowIcon) SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Inter',
              color: passwordController.text.isEmpty
                  ? Color(0xff71717A)
                  : isMet
                  ? AppColors.greenActive
                  : AppColors.redActive,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

}