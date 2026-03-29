import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/components/search_and_filter_bar.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';
import 'package:defifundr_mobile/core/shared/common/appbar/appbar.dart';
import 'package:defifundr_mobile/modules/invoice/presentation/widgets/filter_bottom_sheet.dart';
import 'package:defifundr_mobile/modules/time_tracking/data/models/contract.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';

import '../widgets/contract_card.dart';

@RoutePage()
class TimeTrackingContractsScreen extends StatefulWidget {
  const TimeTrackingContractsScreen({super.key});

  @override
  _TimeTrackingContractsScreenState createState() =>
      _TimeTrackingContractsScreenState();
}

class _TimeTrackingContractsScreenState
    extends State<TimeTrackingContractsScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<TimeTrackingContract> contracts = [
    TimeTrackingContract(
      id: '1',
      title: 'DefiFundr Mobile & Web App Resign',
      type: ContractType.payAsYouGo,
      rate: 21,
      currency: 'USDT',
      status: ContractStatus.rejected,
    ),
    TimeTrackingContract(
      id: '2',
      title: 'DefiFundr Mobile & Web App Resign',
      type: ContractType.fixedRate,
      rate: 50,
      currency: 'EURt',
      status: ContractStatus.active,
    ),
    TimeTrackingContract(
      id: '3',
      title: 'BlockLayer Validator Integfration for DefiFundr',
      type: ContractType.milestone,
      rate: 20,
      currency: 'LUSD',
      status: ContractStatus.pending,
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(context.screenWidth(), 60),
        child: DeFiRaiseAppBar(
          centerTitle: true,
          textStyle: context.theme.fonts.heading3SemiBold,
          isBack: true,
          title: 'Contracts',
          actions: [],
        ),
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          // Contracts List
          Expanded(
            child: contracts.isEmpty
                ? _buildEmptyState(context)
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: contracts.length,
                    itemBuilder: (context, index) {
                      return ContractCard(
                        contract: contracts[index],
                        onTap: () {
                          context.router.push(
                              TimeTrackingRoute(contract: contracts[index]));
                        },
                      );
                    },
                  ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 32.h),
            child: PrimaryButton(
              onPressed: () => context.router.push(CreateContractFlowRoute()),
              text: 'Create new contract',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SearchAndFilterBar(
        searchController: _searchController,
        onFilterTap: _showFilterBottomSheet,
      ),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const FilterBottomSheet(),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 50.h),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    Assets.icons.emptyState,
                    width: 200.w,
                    height: 200.h,
                  ),
                  Text(
                    'No contracts yet',
                    style: fonts.textMdSemiBold.copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                  ),
                  Text(
                    'Create one now to get started.',
                    textAlign: TextAlign.center,
                    style: fonts.textMdRegular.copyWith(
                      color: colors.textSecondary,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
