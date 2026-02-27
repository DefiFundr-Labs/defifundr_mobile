import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/extensions/l10n_extension.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class _DeviceInfo {
  final String name;
  final String location;
  final String ip;
  final String lastLogin;
  final bool isMobile;

  const _DeviceInfo({
    required this.name,
    required this.location,
    required this.ip,
    required this.lastLogin,
    required this.isMobile,
  });
}

@RoutePage()
class DeviceManagementScreen extends StatefulWidget {
  const DeviceManagementScreen({super.key});

  @override
  State<DeviceManagementScreen> createState() => _DeviceManagementScreenState();
}

class _DeviceManagementScreenState extends State<DeviceManagementScreen> {
  final _currentDevice = const _DeviceInfo(
    name: 'Apple iPhone 13',
    location: 'Lagos, Nigeria',
    ip: '102.89.68.30',
    lastLogin: '20th Apr 2025, 04:40 PM',
    isMobile: true,
  );

  final List<_DeviceInfo> _otherDevices = [
    const _DeviceInfo(
      name: 'Chrome V122.0.0 • Windows',
      location: 'Lagos, Nigeria',
      ip: '102.89.68.30',
      lastLogin: '20th Apr 2025, 04:40 PM',
      isMobile: false,
    ),
    const _DeviceInfo(
      name: 'Poco M2102J20SG',
      location: 'Lagos, Nigeria',
      ip: '102.89.68.30',
      lastLogin: '20th Apr 2025, 04:40 PM',
      isMobile: true,
    ),
    const _DeviceInfo(
      name: 'Edge V133.0.0 • Windows',
      location: 'Lagos, Nigeria',
      ip: '102.89.68.30',
      lastLogin: '20th Apr 2025, 04:40 PM',
      isMobile: false,
    ),
    const _DeviceInfo(
      name: 'Chrome V122.0.0 • Mobile',
      location: 'Lagos, Nigeria',
      ip: '102.89.68.30',
      lastLogin: '20th Apr 2025, 04:40 PM',
      isMobile: true,
    ),
  ];

  void _showDeleteDeviceSheet(_DeviceInfo device) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;
    final isLight = Theme.of(context).brightness == Brightness.light;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => Container(
        decoration: BoxDecoration(
          color: isLight ? Colors.white : colors.bgB1,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 12.h),
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: colors.grayTertiary,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              context.l10n.deleteDevice,
              style: fonts.heading2Bold.copyWith(color: colors.textPrimary),
            ),
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Text(
                context.l10n.deleteDeviceConfirm,
                textAlign: TextAlign.center,
                style: fonts.textSmRegular.copyWith(color: colors.textSecondary),
              ),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: _buildDeviceCard(context, device, showDelete: false),
            ),
            SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        height: 52.h,
                        decoration: BoxDecoration(
                          color: colors.grayQuaternary,
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          context.l10n.goBack,
                          style: fonts.textBaseMedium.copyWith(
                            color: colors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        setState(() => _otherDevices.remove(device));
                      },
                      child: Container(
                        height: 52.h,
                        decoration: BoxDecoration(
                          color: colors.redDefault,
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          context.l10n.delete,
                          style: fonts.textBaseMedium.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
                height: MediaQuery.systemGestureInsetsOf(context).bottom + 16),
          ],
        ),
      ),
    );
  }

  void _showLogOutAllSheet() {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;
    final isLight = Theme.of(context).brightness == Brightness.light;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => Container(
        decoration: BoxDecoration(
          color: isLight ? Colors.white : colors.bgB1,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 12.h),
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: colors.grayTertiary,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              context.l10n.logOutAllDevices,
              style: fonts.heading2Bold.copyWith(color: colors.textPrimary),
            ),
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Text(
                context.l10n.logOutAllDevicesConfirm,
                textAlign: TextAlign.center,
                style: fonts.textSmRegular.copyWith(color: colors.textSecondary),
              ),
            ),
            SizedBox(height: 32.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        height: 52.h,
                        decoration: BoxDecoration(
                          color: colors.grayQuaternary,
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          context.l10n.goBack,
                          style: fonts.textBaseMedium.copyWith(
                            color: colors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: PrimaryButton(
                      text: context.l10n.logOut,
                      isEnabled: true,
                      onPressed: () {
                        Navigator.of(context).pop();
                        setState(() => _otherDevices.clear());
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
                height: MediaQuery.systemGestureInsetsOf(context).bottom + 16),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;
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
                      context.l10n.deviceManagement,
                      style: context.theme.textTheme.headlineLarge?.copyWith(
                        fontSize: 24.sp,
                        color: colors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      context.l10n.deviceManagementSubtitle,
                      style: context.theme.textTheme.headlineMedium?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: colors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      context.l10n.currentDevice,
                      style: fonts.textSmMedium.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    _buildDeviceCard(context, _currentDevice, showDelete: false),
                    SizedBox(height: 20.h),
                    if (_otherDevices.isNotEmpty) ...[
                      Text(
                        context.l10n.otherDevices,
                        style: fonts.textSmMedium.copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      ...List.generate(_otherDevices.length, (i) {
                        final device = _otherDevices[i];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: _buildDeviceCard(
                            context,
                            device,
                            showDelete: true,
                            onDelete: () => _showDeleteDeviceSheet(device),
                          ),
                        );
                      }),
                    ],
                    SizedBox(height: 8.h),
                    GestureDetector(
                      onTap: _showLogOutAllSheet,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.l10n.logOutAllDevicesTitle,
                            style: fonts.textBaseMedium.copyWith(
                              color: colors.redDefault,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            context.l10n.logOutAllDevicesSubtitle,
                            style: fonts.textSmRegular.copyWith(
                              color: colors.redDefault,
                            ),
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

  Widget _buildDeviceCard(
    BuildContext context,
    _DeviceInfo device, {
    required bool showDelete,
    VoidCallback? onDelete,
  }) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isLight ? colors.bgB0 : colors.bgB2,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: colors.brandFill,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(
              child: SvgPicture.asset(
                device.isMobile
                    ? Assets.icons.deviceMobile
                    : Assets.icons.devices,
                width: 22.w,
                height: 22.w,
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
                  device.name,
                  style: fonts.textBaseMedium.copyWith(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  '${context.l10n.location} ${device.location} • ${device.ip}',
                  style: fonts.textXsRegular.copyWith(
                    color: colors.textSecondary,
                  ),
                ),
                Text(
                  '${context.l10n.lastLogin} ${device.lastLogin}',
                  style: fonts.textXsRegular.copyWith(
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          if (showDelete) ...[
            SizedBox(width: 8.w),
            GestureDetector(
              onTap: onDelete,
              child: Icon(
                Icons.delete_outline_rounded,
                color: colors.textTertiary,
                size: 22.sp,
              ),
            ),
          ],
        ],
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
            colorFilter:
                ColorFilter.mode(colors.textPrimary, BlendMode.srcIn),
            width: 24.w,
            height: 24.w,
          ),
          onPressed: () => context.router.maybePop(),
        ),
      ),
    );
  }
}
