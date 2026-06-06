import 'package:defifundr_mobile/core/shared/components/search_and_filter_bar.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';

import '../../data/models/contract.dart';
import '../widgets/contract_card.dart';

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
      type: 'Fixed Rate',
      paymentAmount: '581 USDT',
      paymentFrequency: 'Every month',
      isActive: true,
    ),
    TimeOffContract(
      id: '2',
      title: 'Quikdash Mobile & Web App Re...',
      type: 'Milestone',
      paymentAmount: '581 STRK',
      paymentFrequency: '5 milestones',
      isActive: true,
    ),
    TimeOffContract(
      id: '3',
      title: 'Weave Finance Mobile & Web A...',
      type: 'Pay As You Go',
      paymentAmount: '50 EURt',
      paymentFrequency: 'Per Deliverable',
      isActive: true,
    ),
    TimeOffContract(
      id: '4',
      title: 'BlockLayer Validator Integration...',
      type: 'Pay As You Go',
      paymentAmount: '21 USDC',
      paymentFrequency: 'Per Hour',
      isActive: true,
    ),
    TimeOffContract(
      id: '5',
      title: 'Legaltide Compliance Audit for...',
      type: 'Pay As You Go',
      paymentAmount: '51 LUSD',
      paymentFrequency: 'Per Day',
      isActive: true,
    ),
    TimeOffContract(
      id: '6',
      title: 'Snapworks Product Photograph...',
      type: 'Pay As You Go',
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
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade50,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => context.router.maybePop(),
        ),
        title: const Text(
          'Contracts',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
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
                    if (contracts[index].title.contains('Quikdash')) {
                      context.router.push(TimeOffRoute(
                        contractTitle: contracts[index].title,
                      ));
                    }
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
