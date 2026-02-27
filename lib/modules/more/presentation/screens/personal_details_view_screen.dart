import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/extensions/l10n_extension.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';
import 'package:defifundr_mobile/modules/more/presentation/widgets/personal_details_section_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class PersonalDetailsViewScreen extends StatelessWidget {
  const PersonalDetailsViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;
    final isLightMode = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => context.router.maybePop(),
          child: Icon(
            Icons.chevron_left,
            color: colors.textPrimary,
            size: 28.w,
          ),
        ),
        title: Text(
          context.l10n.personalDetails,
          style: fonts.textLgSemiBold.copyWith(
            color: colors.textPrimary,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile photo card
              _buildPhotoCard(context, colors, fonts, isLightMode),
              SizedBox(height: 16.h),

              // Profile details
              PersonalDetailsSectionCard(
                title: context.l10n.profileDetails,
                onEdit: () => context.router.push(const EditProfileDetailsRoute()),
                children: [
                  _InfoRow(
                    label: context.l10n.legalFirstName,
                    value: const Text('Oluwagbemiro'),
                  ),
                  _InfoRow(
                    label: context.l10n.legalLastName,
                    value: const Text('Adegboyega'),
                  ),
                  _InfoRow(
                    label: context.l10n.countryOfCitizenship,
                    value: _countryValue(context, 'Nigeria'),
                  ),
                  _InfoRow(
                    label: context.l10n.dateOfBirth,
                    value: const Text('18 May 2003'),
                  ),
                  _InfoRow(
                    label: context.l10n.gender,
                    value: const Text('Male'),
                  ),
                  _InfoRow(
                    label: context.l10n.phoneNo,
                    value: const Text('+234 (801) 234 5678'),
                    isLast: true,
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // Address
              PersonalDetailsSectionCard(
                title: context.l10n.address,
                onEdit: () => context.router.push(const EditAddressDetailsRoute()),
                children: [
                  _InfoRow(
                    label: context.l10n.country,
                    value: _countryValue(context, 'Nigeria'),
                  ),
                  _InfoRow(
                    label: context.l10n.address,
                    value: const Text(
                      'No 8 James Robertson Shittu/\nOgunlana Drive, Surulere | 142261',
                      textAlign: TextAlign.right,
                    ),
                    isLast: true,
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // Account details
              PersonalDetailsSectionCard(
                title: context.l10n.accountDetails,
                onEdit: () => context.router.push(const EditAccountDetailsRoute()),
                children: [
                  _InfoRow(
                    label: context.l10n.email,
                    value: const Text(
                      'adeshinaadegboyega@icloud.com',
                      textAlign: TextAlign.right,
                    ),
                    isLast: true,
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // Tax information
              PersonalDetailsSectionCard(
                title: context.l10n.taxInformation,
                onEdit: () => context.router.push(const EditTaxInformationRoute()),
                children: [
                  _InfoRow(
                    label: context.l10n.countryOfTaxResidence,
                    value: _countryValue(context, 'Nigeria'),
                  ),
                  _InfoRow(
                    label: context.l10n.address,
                    value: const Text(
                      'No 8 James Robertson Shittu/\nOgunlana Drive, Surulere | 142261',
                      textAlign: TextAlign.right,
                    ),
                  ),
                  _InfoRow(
                    label: context.l10n.taxId,
                    value: const Text('8012345678'),
                    isLast: true,
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // Delete account
              Container(
                decoration: BoxDecoration(
                  color: isLightMode ? colors.bgB0 : colors.bgB1,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: InkWell(
                  onTap: () => context.router.push(const DeleteAccountRoute()),
                  borderRadius: BorderRadius.circular(16.r),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          Assets.icons.trash,
                          width: 20.w,
                          height: 20.w,
                          colorFilter: ColorFilter.mode(
                            colors.redDefault,
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          context.l10n.deleteAccount,
                          style: fonts.textBaseMedium.copyWith(
                            color: colors.redDefault,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoCard(
    BuildContext context,
    dynamic colors,
    dynamic fonts,
    bool isLightMode,
  ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isLightMode ? colors.bgB0 : colors.bgB1,
        borderRadius: BorderRadius.circular(16.r),
      ),
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.profilePhoto,
            style: fonts.textBaseSemiBold.copyWith(
              color: colors.textPrimary,
            ),
          ),
          SizedBox(height: 20.h),
          Center(
            child: Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                color: colors.brandFill,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  'AO',
                  style: fonts.textLgBold.copyWith(
                    color: colors.brandDefault,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Center(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 8.h,
                ),
                decoration: BoxDecoration(
                  color: isLightMode ? colors.bgB1 : colors.bgB2,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: colors.bgB2),
                ),
                child: Text(
                  context.l10n.editPhoto,
                  style: fonts.textSmMedium.copyWith(
                    color: colors.textPrimary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _countryValue(BuildContext context, String country) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ClipOval(
          child: SvgPicture.asset(
            Assets.icons.countryFlags.nigeria,
            width: 20.w,
            height: 20.w,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 6.w),
        Text(
          country,
          style: fonts.textMdMedium.copyWith(
            color: colors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final Widget value;
  final bool isLast;

  const _InfoRow({
    required this.label,
    required this.value,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: Text(
                  label,
                  style: fonts.textMdRegular.copyWith(
                    color: colors.textSecondary,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                flex: 6,
                child: DefaultTextStyle(
                  style: fonts.textMdMedium.copyWith(
                    color: colors.textPrimary,
                  ),
                  textAlign: TextAlign.right,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: value,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (!isLast)
          Divider(
            height: 1,
            thickness: 0.5,
            indent: 16.w,
            endIndent: 16.w,
            color: colors.bgB2,
          ),
      ],
    );
  }
}
