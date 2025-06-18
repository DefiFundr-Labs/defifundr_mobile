import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsAgreementText extends StatelessWidget {
  const TermsAgreementText({Key? key}) : super(key: key);

  // Function to launch URLs
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: context.theme.textTheme.headlineMedium?.copyWith(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: context.theme.colors.textSecondary,
          ),
          children: [
            const TextSpan(
              text: 'By creating an account, you agree to our ',
            ),
            TextSpan(
              text: 'Terms of Service',
              style: context.theme.textTheme.headlineMedium?.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: context.theme.colors.textSecondary,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () => _launchUrl('https://yourapp.com/terms'),
            ),
            const TextSpan(text: ', '),
            TextSpan(
              text: 'Product T&Cs',
              style: context.theme.textTheme.headlineMedium?.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: context.theme.colors.activeButton,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () => _launchUrl('https://yourapp.com/product-terms'),
            ),
            const TextSpan(text: ', & '),
            TextSpan(
              text: 'Privacy Policy',
              style: context.theme.textTheme.headlineMedium?.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: context.theme.colors.activeButton,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () => _launchUrl('https://yourapp.com/privacy'),
            ),
            const TextSpan(text: '.'),
          ],
        ),
      ),
    );
  }
}
