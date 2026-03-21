import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/components/search_and_filter_bar.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';

import '../../data/models/contract.dart';
import '../widgets/contract_card.dart';
import 'package:defifundr_mobile/modules/time_tracking/data/models/contract.dart';

@RoutePage()
class TimeOffContractsScreen extends StatefulWidget {
  TimeOffContractsScreen({Key? key}) : super(key: key);

  @override
  State<TimeOffContractsScreen> createState() => _TimeOffContractsScreenState();
}

class _TimeOffContractsScreenState extends State<TimeOffContractsScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<TimeOffContract> contracts = [
    TimeOffContract(
      id: '1',
      title: 'DefiFundr Mobile & Web App Re...',
      type: ContractType.fixedRate,
      paymentAmount: '581 USDT',
      paymentFrequency: 'Every month',
      isActive: true,
    ),
    TimeOffContract(
      id: '2',
      title: 'Quikdash Mobile & Web App Re...',
      type: ContractType.milestone,
      paymentAmount: '581 STRK',
      paymentFrequency: '5 milestones',
      isActive: true,
    ),
    TimeOffContract(
      id: '3',
      title: 'Weave Finance Mobile & Web A...',
      type: ContractType.payAsYouGo,
      paymentAmount: '50 EURt',
      paymentFrequency: 'Per Deliverable',
      isActive: true,
    ),
    TimeOffContract(
      id: '4',
      title: 'BlockLayer Validator Integration...',
      type: ContractType.payAsYouGo,
      paymentAmount: '21 USDC',
      paymentFrequency: 'Per Hour',
      isActive: true,
    ),
    TimeOffContract(
      id: '5',
      title: 'Legaltide Compliance Audit for...',
      type: ContractType.payAsYouGo,
      paymentAmount: '51 LUSD',
      paymentFrequency: 'Per Day',
      isActive: true,
    ),
    TimeOffContract(
      id: '6',
      title: 'Snapworks Product Photograph...',
      type: ContractType.payAsYouGo,
      paymentAmount: '101 DAI',
      paymentFrequency: 'Per Week',
      isActive: true,
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
      backgroundColor: context.theme.colors.bgB1,
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
          Padding(
            padding: const EdgeInsets.all(16),
            child: SearchAndFilterBar(
              searchController: _searchController,
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: contracts.length,
              itemBuilder: (context, index) {
                return ContractCard(
                  contract: contracts[index],
                  onTap: () {
                    context.router.push(TimeOffRoute(
                      contractTitle: contracts[index].title,
                    ));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
