import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/extensions/l10n_extension.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class SocialMediaScreen extends StatelessWidget {
  const SocialMediaScreen({super.key});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      backgroundColor: isLight ? colors.bgB1 : colors.bgB0,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppBar(context),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8.h),
                    Text(
                      context.l10n.followUsOnSocialMedia,
                      style: context.theme.textTheme.headlineLarge?.copyWith(
                        fontSize: 24.sp,
                        color: colors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      context.l10n.followUsSubtitle,
                      style: context.theme.textTheme.headlineMedium?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: colors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: isLight ? colors.bgB0 : colors.bgB1,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _SocialItem(
                            icon: _FacebookIcon(),
                            title: 'Facebook',
                            onTap: () => _launchUrl(
                                'https://facebook.com/defifundr'),
                          ),
                          Divider(
                            height: 1,
                            thickness: 0.5,
                            indent: 64.w,
                            endIndent: 16.w,
                            color: colors.bgB2,
                          ),
                          _SocialItem(
                            icon: _SvgSocialIcon(
                              assetPath: Assets.icons.instagramLogo,
                              backgroundColor: const Color(0xFFE1306C),
                            ),
                            title: 'Instagram',
                            onTap: () => _launchUrl(
                                'https://instagram.com/defifundr'),
                          ),
                          Divider(
                            height: 1,
                            thickness: 0.5,
                            indent: 64.w,
                            endIndent: 16.w,
                            color: colors.bgB2,
                          ),
                          _SocialItem(
                            icon: _LinkedInIcon(),
                            title: 'LinkedIn',
                            onTap: () => _launchUrl(
                                'https://linkedin.com/company/defifundr'),
                          ),
                          Divider(
                            height: 1,
                            thickness: 0.5,
                            indent: 64.w,
                            endIndent: 16.w,
                            color: colors.bgB2,
                          ),
                          _SocialItem(
                            icon: _SvgSocialIcon(
                              assetPath: Assets.icons.xLogo,
                              backgroundColor: const Color(0xFF000000),
                            ),
                            title: 'X (prv Twitter)',
                            onTap: () =>
                                _launchUrl('https://x.com/defifundr'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final colors = context.theme.colors;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child: IconButton(
          icon: SvgPicture.asset(
            Assets.icons.arrowBack,
            colorFilter: ColorFilter.mode(colors.textPrimary, BlendMode.srcIn),
            width: 24.w,
            height: 24.w,
          ),
          onPressed: () => context.router.maybePop(),
        ),
      ),
    );
  }
}

class _SocialItem extends StatelessWidget {
  final Widget icon;
  final String title;
  final VoidCallback onTap;

  const _SocialItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.h),
        child: Row(
          children: [
            icon,
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                title,
                style: fonts.textBaseMedium.copyWith(
                  color: colors.textPrimary,
                ),
              ),
            ),
            Icon(
              Icons.north_east,
              color: colors.textTertiary,
              size: 18.w,
            ),
          ],
        ),
      ),
    );
  }
}

class _SvgSocialIcon extends StatelessWidget {
  final String assetPath;
  final Color backgroundColor;

  const _SvgSocialIcon({
    required this.assetPath,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36.w,
      height: 36.w,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Center(
        child: SvgPicture.asset(
          assetPath,
          width: 20.w,
          height: 20.w,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
      ),
    );
  }
}

class _FacebookIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36.w,
      height: 36.w,
      decoration: BoxDecoration(
        color: const Color(0xFF1877F2),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Center(
        child: Text(
          'f',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            fontFamily: 'serif',
          ),
        ),
      ),
    );
  }
}

class _LinkedInIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36.w,
      height: 36.w,
      decoration: BoxDecoration(
        color: const Color(0xFF0A66C2),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Center(
        child: Text(
          'in',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
