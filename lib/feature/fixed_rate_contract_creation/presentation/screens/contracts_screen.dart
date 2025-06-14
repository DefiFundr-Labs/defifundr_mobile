import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/enums/checkbox_enum.dart';
import 'package:defifundr_mobile/core/enums/contract_status.dart';
import 'package:defifundr_mobile/core/enums/contract_type.dart';
import 'package:defifundr_mobile/core/routers/routes_constant.dart';
import 'package:defifundr_mobile/core/shared/buttons/filter_component.dart';
import 'package:defifundr_mobile/core/shared/buttons/reusable_checkbox.dart';
import 'package:defifundr_mobile/core/shared/buttons/search_filter_button.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/identity_verification/widgets/brand_button.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/multi_factor_authentication_screen/widgets/custom_back_button.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/multi_factor_authentication_screen/widgets/primary_button.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/quick_pay/class/quick_payments.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/quick_pay/widgets/checkbox_status.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/quick_pay/widgets/slide_up_panel.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/quick_pay/widgets/time_filter_radio.dart';
import 'package:defifundr_mobile/feature/fixed_rate_contract_creation/presentation/widgets/contract_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class ContractsScreen extends StatefulWidget {
  const ContractsScreen({super.key});

  @override
  State<ContractsScreen> createState() => _ContractsScreenState();
}

class _ContractsScreenState extends State<ContractsScreen> {
  ValueNotifier<bool> isPanelVisible = ValueNotifier(false);
  ValueNotifier<TimeRange?> selectedTimeRange = ValueNotifier<TimeRange?>(null);

  final ValueNotifier<Map<ContractStatus, bool?>> statusFilter =
      ValueNotifier({});
  final ValueNotifier<List<ContractType>> contractTypeFilter =
      ValueNotifier(ContractType.values);

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
                        children: [
                          EnumCheckboxGroup<ContractType>(
                              options: ContractType.values
                                  .map(
                                    (contract) => EnumCheckboxMeta(
                                      value: contract,
                                      label: contract.label,
                                      fillColor: AppColors.transparent,
                                      borderColor: AppColors.transparent,
                                      textColor: AppColors.primaryColor,
                                    ),
                                  )
                                  .toList())
                        ],
                      ),
                      FilterSection(
                        title: "Status",
                        children: [
                          EnumCheckboxGroup<ContractStatus>(
                            options: ContractStatus.values.map((status) {
                              return EnumCheckboxMeta(
                                value: status,
                                label: status.label,
                                fillColor: status.bgColor,
                                borderColor: status.borderColor,
                                textColor: status.textColor,
                              );
                            }).toList(),
                            onChanged: (selectedMap) {
                              statusFilter.value = selectedMap;
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
                onPressed: () =>
                    context.pushNamed(RouteConstants.createcontractScreen),
              ),
            ),
          ],
        ),
      ),
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
