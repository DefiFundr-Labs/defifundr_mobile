import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/extensions/l10n_extension.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';
import 'package:defifundr_mobile/modules/workspace/data/models/workspace_card_data_model.dart';
import 'package:defifundr_mobile/modules/workspace/presentation/widgets/workspace_card_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class WorkspaceScreen extends StatelessWidget {
  const WorkspaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;
    final isLight = Theme.of(context).brightness == Brightness.light;

    final cards = [
      WorkspaceCardModel(
        title: context.l10n.contracts,
        description: context.l10n.contractsDesc,
        iconPath: Assets.icons.files,
        onTap: () => context.pushRoute(const TimeTrackingContractsRoute()),
      ),
      WorkspaceCardModel(
        title: context.l10n.payCycle,
        description: context.l10n.payCycleDesc,
        iconPath: Assets.icons.greenMoney,
        onTap: () => context.pushRoute(const PayCycleContractsRoute()),
      ),
      WorkspaceCardModel(
        title: context.l10n.invoices,
        description: context.l10n.invoiceDesc,
        iconPath: Assets.icons.billInvoice,
        onTap: () => context.pushRoute(const InvoicesRoute()),
      ),
      WorkspaceCardModel(
        title: context.l10n.expenses,
        description: context.l10n.expensesDesc,
        iconPath: Assets.icons.receipt,
        onTap: () => context.pushRoute(const ExpensesRoute()),
      ),
      WorkspaceCardModel(
        title: context.l10n.timesheets,
        description: context.l10n.timesheetsDesc,
        iconPath: Assets.icons.yellowClockuser,
        onTap: () => context.pushRoute(const TimeTrackingContractsRoute()),
      ),
      WorkspaceCardModel(
        title: context.l10n.timeOff,
        description: context.l10n.timeOffDesc,
        iconPath: Assets.icons.calendarSlash,
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
                    return WorkspaceCard(
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
