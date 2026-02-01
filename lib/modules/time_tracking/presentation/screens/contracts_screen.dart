import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/enums/app_text_field_enums.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';
import 'package:defifundr_mobile/core/shared/common/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/common/textfield/app_text_field.dart';
import 'package:defifundr_mobile/modules/invoice/presentation/widgets/filter_bottom_sheet.dart';
import 'package:defifundr_mobile/modules/time_tracking/data/models/contract.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../widgets/contract_card.dart';

@RoutePage()
class TimeTrackingContractsScreen extends StatefulWidget {
  const TimeTrackingContractsScreen({super.key});

  @override
  _TimeTrackingContractsScreenState createState() => _TimeTrackingContractsScreenState();
}

class _TimeTrackingContractsScreenState extends State<TimeTrackingContractsScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<TimeTrackingContract> contracts = [
    TimeTrackingContract(
      id: '1',
      title: 'DefiFundr Mobile & Web App Resign',
      type: 'Pay As You Go',
      rate: 21,
      currency: 'USDT',
      status: 'Active',
    ),
    TimeTrackingContract(
      id: '2',
      title: 'DefiFundr Mobile & Web App Resign',
      type: 'Pay As You Go',
      rate: 50,
      currency: 'EURt',
      status: 'Active',
    ),
    TimeTrackingContract(
      id: '3',
      title: 'BlockLayer Validator Integfration for DefiFundr',
      type: 'Pay As You Go',
      rate: 20,
      currency: 'LUSD',
      status: 'Active',
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
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: contracts.length,
              itemBuilder: (context, index) {
                return ContractCard(
                  contract: contracts[index],
                  onTap: () {
                    context.router.push(TimeTrackingRoute(contract: contracts[index]));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: AppTextField(
              controller: _searchController,
              validate: false,
              alwaysShowLabelAndHint: true,
              hintText: "Search",
              prefixType: PrefixType.customIcon,
              prefixIcon: SvgPicture.asset(
                Assets.icons.magnifyingGlass,
                width: 20,
                height: 20,
                color: context.theme.colors.textSecondary,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: _showFilterBottomSheet,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isLight
                    ? context.theme.colors.bgB0
                    : context.theme.colors.bgB1,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: context.theme.colors.strokeSecondary.withAlpha(20),
                ),
              ),
              child: SvgPicture.asset(
                Assets.icons.filter,
                width: 20,
                height: 20,
                color: context.theme.colors.textSecondary,
              ),
            ),
          ),
        ],
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
}
