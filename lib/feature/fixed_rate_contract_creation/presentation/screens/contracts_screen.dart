import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/enums/contract_status.dart';
import 'package:defifundr_mobile/core/shared/buttons/filter_component.dart';
import 'package:defifundr_mobile/core/shared/buttons/search_filter_button.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/identity_verification/widgets/brand_button.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/multi_factor_authentication_screen/widgets/custom_back_button.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/multi_factor_authentication_screen/widgets/primary_button.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/quick_pay/class/quick_payments.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/quick_pay/widgets/checkbox_status.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/quick_pay/widgets/slide_up_panel.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/quick_pay/widgets/time_filter_radio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ContractsScreen extends StatefulWidget {
  const ContractsScreen({super.key});

  @override
  State<ContractsScreen> createState() => _ContractsScreenState();
}

class _ContractsScreenState extends State<ContractsScreen> {
  ValueNotifier<bool> isPanelVisible = ValueNotifier(false);
  ValueNotifier<TimeRange?> selectedTimeRange = ValueNotifier<TimeRange?>(null);

  ValueNotifier<Map<QuickPaymentsStatus, bool?>?> statusFilter =
      ValueNotifier(null);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: CustomBackButton(),
        surfaceTintColor: Colors.transparent,
        backgroundColor: context.theme.scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          'Contracts',
          style: context.textTheme.headlineLarge?.copyWith(fontSize: 24.sp),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          children: [
            SearchAndFilterBar(
              onFilterTap: () async {
                isPanelVisible.value = true;

                await slideUpPanel(
                  context,
                  FilterPanel(
                    sections: [
                      FilterSection(
                        title: "Contract Type",
                        children: [],
                      ),
                      FilterSection(
                        title: "Status",
                        children: [
                          CheckBoxStatus(
                            onChanged: (value) {
                              statusFilter.value = value;
                            },
                          ),
                        ],
                      ),
                      FilterSection(
                        title: "Date",
                        children: [
                          TimeFilterRadio(
                            onChanged: (selected) {
                              selectedTimeRange.value = selected;
                            },
                          ),
                        ],
                      ),
                    ],
                    onClear: () {
                      Navigator.pop(context);
                    },
                    onShowResults: () {
                      Navigator.pop(context);
                    },
                  ),
                  canDismiss: true,
                  onDismiss: () {
                    isPanelVisible.value = false;
                  },
                );
              },
            ),
            SizedBox(height: 16),
            Expanded(child: FilledContractsView()),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: BrandButton(
                text: 'Create new contract',
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class buildContractCard extends StatelessWidget {
  const buildContractCard({
    super.key,
    required this.label,
    this.status,
    this.trailingText,
    required this.amount,
    required this.duration,
    required this.contractType,
  });
  final String label;
  final String amount;
  final ContractStatus? status;
  final String? trailingText;
  final String duration;
  final String contractType;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.bgB0,
          boxShadow: [
            BoxShadow(
              color: AppColors.constantDefault.withOpacity(0.3),
              blurRadius: 1,
              spreadRadius: -5,
              offset: Offset(0, 1),
            ),
          ]),
      child: Column(
        children: [
          buildRowWidget(
            leading: label,
            leadingStyle: context.theme.fonts.textMdSemiBold,
            status: status,
          ),
          SizedBox(height: 16),
          buildRowWidget(
            leading: 'Type',
            leadingStyle: context.theme.fonts.textSmRegular,
            trailing: amount,
            trailingStyle: context.theme.fonts.textMdSemiBold,
          ),
          buildRowWidget(
            leading: contractType,
            leadingStyle: context.theme.fonts.textMdSemiBold,
            trailing: duration,
            trailingStyle: context.theme.fonts.textSmRegular,
          ),
        ],
      ),
    );
  }
}

class buildRowWidget extends StatelessWidget {
  const buildRowWidget({
    super.key,
    required this.leading,
    required this.leadingStyle,
    this.trailingStyle,
    this.trailing,
    this.status,
  });
  final String leading;
  final String? trailing;
  final TextStyle leadingStyle;
  final TextStyle? trailingStyle;
  final ContractStatus? status;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            leading,
            overflow: TextOverflow.ellipsis,
            style: leadingStyle,
          ),
        ),
        status != null
            ? Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: status!.bgColor,
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(color: status!.borderColor),
                ),
                child: Text(
                  status!.label,
                  style: context.theme.fonts.textXsSemiBold
                      .copyWith(color: status!.textColor),
                ),
              )
            : Text(
                trailing!,
                style: trailingStyle,
              ),
      ],
    );
  }
}

class EmptyContractsView extends StatelessWidget {
  const EmptyContractsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(AppAssets.emptyState),
        Text(
          'No contracts yet',
          style: context.textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.w600, fontSize: 14.sp),
        ),
        Text(
          'Create one now to get started.',
          style: context.textTheme.bodySmall
              ?.copyWith(color: AppColors.textSecondary, fontSize: 12.sp),
        ),
      ],
    );
  }
}

class FilledContractsView extends StatelessWidget {
  const FilledContractsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            buildContractCard(
              label: 'DefiFundr Mobile & Web App Redesign',
              amount: '581 USDT',
              status: ContractStatus.active,
              duration: 'Every month',
              contractType: 'Fixed Rate',
            ),
            SizedBox(height: 20),
            buildContractCard(
              label: 'Quikdash Mobile & Web App Redesign',
              amount: '581 STRK',
              status: ContractStatus.pending,
              duration: '5 milestones',
              contractType: 'Fixed Rate',
            ),
            SizedBox(height: 20),
            buildContractCard(
              label: 'DefiFundr Mobile & Web App Redesign',
              amount: '581 USDT',
              status: ContractStatus.rejected,
              duration: 'Per Deliverable',
              contractType: 'Fixed Rate',
            ),
          ],
        ),
      ],
    );
  }
}
