import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/color_extension/app_color_extension.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/extensions/l10n_extension.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';
import 'package:defifundr_mobile/modules/more/presentation/widgets/more_list_item.dart';
import 'package:defifundr_mobile/modules/more/presentation/widgets/more_profile_card.dart';
import 'package:defifundr_mobile/modules/more/presentation/widgets/app_language_bottom_sheet.dart';
import 'package:defifundr_mobile/modules/more/presentation/widgets/more_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  bool _useFaceId = true;
  bool _twoFactorAuth = true;
  bool _pushNotifications = true;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: Text(
          l10n.more,
          style: fonts.heading2Bold.copyWith(
            color: colors.textPrimary,
            fontFamily: 'HankenGrotesk',
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MoreProfileCard(
                name: 'Adegboyega Oluwagbemiro',
                email: 'adeshinaadegboyega@icloud.com',
                initials: 'AO',
              ),
              SizedBox(height: 24.h),

              // Profile section
              MoreSection(
                title: l10n.profile,
                items: [
                  MoreListItem(
                    icon: _buildIcon(Assets.icons.profilee, colors),
                    title: l10n.personalDetails,
                    onTap: () => context.router.push(const PersonalDetailsViewRoute()),
                  ),
                  MoreListItem(
                    icon: _buildIcon(Assets.icons.wallet, colors),
                    title: l10n.manageWallet,
                    onTap: () => context.router.push(const ManageWalletRoute()),
                  ),
                  MoreListItem(
                    icon: _buildIcon(Assets.icons.userCircleDashed, colors),
                    title: l10n.addressBook,
                    onTap: () {},
                  ),
                ],
              ),
              SizedBox(height: 24.h),

              // Security section
              MoreSection(
                title: l10n.security,
                items: [
                  MoreListItem(
                    icon: _buildIcon('assets/icons/password.svg', colors),
                    title: l10n.changePassword,
                    onTap: () => context.router.push(const ChangePasswordRoute()),
                  ),
                  MoreListItem(
                    icon: _buildIcon(Assets.icons.lockKeyOpen, colors),
                    title: l10n.changePIN,
                    onTap: () => context.router.push(const CurrentPinCodeRoute()),
                  ),
                  MoreListItem(
                    icon: _buildIcon(Assets.icons.faceScan, colors),
                    title: l10n.useFaceIdFingerprint,
                    trailingType: MoreItemTrailingType.toggle,
                    toggleValue: _useFaceId,
                    onToggleChanged: (value) =>
                        setState(() => _useFaceId = value),
                  ),
                  MoreListItem(
                    icon: _buildIcon(Assets.icons.lockIcon, colors),
                    title: l10n.twoFactorAuthentication,
                    trailingType: MoreItemTrailingType.toggle,
                    toggleValue: _twoFactorAuth,
                    onToggleChanged: (value) {
                      setState(() => _twoFactorAuth = value);
                      if (value) {
                        context.router.push(const SetupTwoFaRoute());
                      }
                    },
                  ),
                  MoreListItem(
                    icon: _buildIcon('assets/icons/devices.svg', colors),
                    title: l10n.deviceManagement,
                    onTap: () => context.router.push(const DeviceManagementRoute()),
                  ),
                ],
              ),
              SizedBox(height: 24.h),

              // General section
              MoreSection(
                title: l10n.general,
                items: [
                  MoreListItem(
                    icon: _buildIcon(Assets.icons.eye, colors),
                    title: l10n.appAppearance,
                    onTap: () => context.router.push(const AppAppearanceRoute()),
                  ),
                  MoreListItem(
                    icon: _buildIcon(Assets.icons.notification, colors),
                    title: l10n.pushNotifications,
                    trailingType: MoreItemTrailingType.toggle,
                    toggleValue: _pushNotifications,
                    onToggleChanged: (value) =>
                        setState(() => _pushNotifications = value),
                  ),
                  MoreListItem(
                    icon: _buildIcon(Assets.icons.globe, colors),
                    title: l10n.appLanguage,
                    onTap: () => showAppLanguageBottomSheet(context),
                  ),
                  MoreListItem(
                    icon: _buildIcon(Assets.icons.headset, colors),
                    title: l10n.helpFeedback,
                    onTap: () => context.router.push(const HelpFeedbackRoute()),
                  ),
                ],
              ),
              SizedBox(height: 24.h),

              // About section
              MoreSection(
                title: l10n.about,
                items: [
                  MoreListItem(
                    icon: _buildIcon(Assets.icons.globe, colors),
                    title: l10n.visitWebsite,
                    trailingType: MoreItemTrailingType.externalLink,
                    onTap: () {},
                  ),
                  MoreListItem(
                    icon: _buildIcon(Assets.icons.fileText, colors),
                    title: l10n.termsOfService,
                    onTap: () {},
                  ),
                  MoreListItem(
                    icon: _buildIcon(Assets.icons.scales, colors),
                    title: l10n.privacyPolicy,
                    onTap: () {},
                  ),
                ],
              ),
              SizedBox(height: 24.h),

              // Log out
              Container(
                decoration: BoxDecoration(
                  color: isLightMode ? colors.bgB0 : colors.bgB1,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(16.r),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          Assets.icons.signOutSvg,
                          width: 20.w,
                          height: 20.w,
                          colorFilter: ColorFilter.mode(
                            colors.redDefault,
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          l10n.logOut,
                          style: fonts.textBaseMedium.copyWith(
                            color: colors.redDefault,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 28.h),

              // Version info
              Center(
                child: Text(
                  l10n.versionInfo('1.17.0', '110'),
                  style: fonts.textSmRegular.copyWith(
                    color: colors.textTertiary,
                  ),
                ),
              ),
              SizedBox(height: 12.h),

              // Social icons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialIcon('assets/icons/x_logo.svg', colors),
                  SizedBox(width: 20.w),
                  _buildSocialIcon('assets/icons/instagram_logo.svg', colors),
                  SizedBox(width: 20.w),
                  _buildSocialIcon('assets/icons/telegram_logo.svg', colors),
                ],
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(String svgPath, AppColorExtension colors) {
    return Container(
      width: 36.w,
      height: 36.w,
      decoration: BoxDecoration(
        color: colors.brandFill,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Center(
        child: SvgPicture.asset(
          svgPath,
          width: 20.w,
          height: 20.w,
          colorFilter: ColorFilter.mode(
            colors.brandDefault,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialIcon(String svgPath, AppColorExtension colors) {
    return SvgPicture.asset(
      svgPath,
      width: 22.w,
      height: 22.w,
      colorFilter: ColorFilter.mode(
        colors.textSecondary,
        BlendMode.srcIn,
      ),
    );
  }
}
