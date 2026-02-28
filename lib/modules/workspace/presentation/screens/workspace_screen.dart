import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/extensions/l10n_extension.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class WorkspaceScreen extends StatelessWidget {
  const WorkspaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;
    final isLight = Theme.of(context).brightness == Brightness.light;

    final cards = [
      _WorkspaceCardData(
        title: context.l10n.contracts,
        description: context.l10n.contractsDesc,
        iconPath: Assets.icons.files,
        iconBgColor: const Color(0xFFEDE9FE),
        onTap: () => context.pushRoute(const TimeTrackingContractsRoute()),
      ),
      _WorkspaceCardData(
        title: context.l10n.payCycle,
        description: context.l10n.payCycleDesc,
        iconPath: Assets.icons.handCoins,
        iconBgColor: const Color(0xFF0D9488),
        onTap: () => context.pushRoute(const PayCycleContractsRoute()),
      ),
      _WorkspaceCardData(
        title: context.l10n.invoices,
        description: context.l10n.invoiceDesc,
        iconPath: Assets.icons.invoiceCopy,
        iconBgColor: const Color(0xFFEA580C),
        onTap: () => context.pushRoute(const InvoicesRoute()),
      ),
      _WorkspaceCardData(
        title: context.l10n.expenses,
        description: context.l10n.expensesDesc,
        iconPath: Assets.icons.moneyCopy,
        iconBgColor: const Color(0xFFDB2777),
        onTap: () => context.pushRoute(const ExpensesRoute()),
      ),
      _WorkspaceCardData(
        title: context.l10n.timesheets,
        description: context.l10n.timesheetsDesc,
        iconPath: Assets.icons.clockUser,
        iconBgColor: const Color(0xFFFEF3C7),
        onTap: () => context.pushRoute(const TimeTrackingContractsRoute()),
      ),
      _WorkspaceCardData(
        title: context.l10n.timeOff,
        description: context.l10n.timeOffDesc,
        iconPath: Assets.icons.prohibit,
        iconBgColor: const Color(0xFFDCFCE7),
        onTap: () => context.pushRoute(TimeOffContractsRoute()),
      ),
    ];

    return Scaffold(
      backgroundColor: isLight ? colors.bgB1 : colors.bgB0,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 8.h),
              child: Text(
                'Workspace',
                style: context.theme.textTheme.headlineLarge?.copyWith(
                  fontSize: 24.sp,
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: GridView.builder(
                  padding: EdgeInsets.only(top: 8.h, bottom: 24.h),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.w,
                    mainAxisSpacing: 12.h,
                    childAspectRatio: 1.05,
                  ),
                  itemCount: cards.length,
                  itemBuilder: (context, index) {
                    final card = cards[index];
                    return _WorkspaceCard(
                      data: card,
                      isLight: isLight,
                      colors: colors,
                      fonts: fonts,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WorkspaceCardData {
  final String title;
  final String description;
  final String iconPath;
  final Color iconBgColor;
  final VoidCallback onTap;

  const _WorkspaceCardData({
    required this.title,
    required this.description,
    required this.iconPath,
    required this.iconBgColor,
    required this.onTap,
  });
}

class _WorkspaceCard extends StatelessWidget {
  final _WorkspaceCardData data;
  final bool isLight;
  final dynamic colors;
  final dynamic fonts;

  const _WorkspaceCard({
    required this.data,
    required this.isLight,
    required this.colors,
    required this.fonts,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: data.onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isLight ? colors.bgB0 : colors.bgB1,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              data.iconPath,
              width: 24.w,
              height: 24.w,
            ),
            SizedBox(height: 12.h),
            Text(
              data.title,
            ),
            SizedBox(height: 4.h),
            Text(
              data.description,
              style: fonts.textSmRegular.copyWith(
                color: colors.textSecondary,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
