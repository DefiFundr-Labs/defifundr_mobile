import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/extensions/l10n_extension.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class HelpFeedbackScreen extends StatelessWidget {
  const HelpFeedbackScreen({super.key});

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
                      context.l10n.helpFeedback,
                      style: context.theme.textTheme.headlineLarge?.copyWith(
                        fontSize: 24.sp,
                        color: colors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      context.l10n.helpFeedbackSubtitle,
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
                          _HelpItem(
                            iconPath: Assets.icons.question,
                            title: context.l10n.helpCenter,
                            subtitle:
                                context.l10n.helpCenterSubtitle,
                            trailingType: _HelpItemTrailing.externalLink,
                            onTap: () =>
                                _launchUrl('https://defifundr.com/help'),
                          ),
                          _buildDivider(colors),
                          _HelpItem(
                            iconPath: Assets.icons.headset,
                            title: context.l10n.chatWithUs,
                            subtitle:
                                context.l10n.chatWithUsSubtitle,
                            trailingType: _HelpItemTrailing.chevron,
                            onTap: () {},
                          ),
                          _buildDivider(colors),
                          _HelpItem(
                            iconPath: Assets.icons.questionSvg,
                            title: context.l10n.leaveFeedback,
                            subtitle:
                                context.l10n.leaveFeedbackSubtitle,
                            trailingType: _HelpItemTrailing.chevron,
                            onTap: () {},
                          ),
                          _buildDivider(colors),
                          _HelpItem(
                            iconPath: Assets.icons.deviceMobile,
                            title: context.l10n.followUsOnSocialMedia,
                            subtitle:
                                context.l10n.followUsSubtitle,
                            trailingType: _HelpItemTrailing.chevron,
                            onTap: () =>
                                context.router.push(const SocialMediaRoute()),
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

  Widget _buildDivider(dynamic colors) {
    return Divider(
      height: 1,
      thickness: 0.5,
      indent: 64.w,
      endIndent: 16.w,
      color: colors.bgB2,
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

enum _HelpItemTrailing { chevron, externalLink }

class _HelpItem extends StatelessWidget {
  final String iconPath;
  final String title;
  final String subtitle;
  final _HelpItemTrailing trailingType;
  final VoidCallback onTap;

  const _HelpItem({
    required this.iconPath,
    required this.title,
    required this.subtitle,
    required this.trailingType,
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
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                color: colors.brandFill,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Center(
                child: SvgPicture.asset(
                  iconPath,
                  width: 20.w,
                  height: 20.w,
                  colorFilter: ColorFilter.mode(
                    colors.brandDefault,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: fonts.textBaseMedium.copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: fonts.textSmRegular.copyWith(
                      color: colors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            Padding(
              padding: EdgeInsets.only(top: 2.h),
              child: Icon(
                trailingType == _HelpItemTrailing.externalLink
                    ? Icons.north_east
                    : Icons.chevron_right,
                color: colors.textTertiary,
                size: trailingType == _HelpItemTrailing.externalLink
                    ? 18.w
                    : 20.w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
