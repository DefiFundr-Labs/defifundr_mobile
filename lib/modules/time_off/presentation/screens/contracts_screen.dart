import 'package:defifundr_mobile/modules/time_off/presentation/screens/time_off_screen.dart';
import 'package:flutter/material.dart';

import '../../data/models/contract.dart';
import '../widgets/contract_card.dart';

class ContractsScreen extends StatelessWidget {
  final List<Contract> contracts = [
    Contract(
      id: '1',
      title: 'DefiFundr Mobile & Web App Re...',
      type: 'Fixed Rate',
      paymentAmount: '581 USDT',
      paymentFrequency: 'Every month',
      isActive: true,
    ),
    Contract(
      id: '2',
      title: 'Quikdash Mobile & Web App Re...',
      type: 'Milestone',
      paymentAmount: '581 STRK',
      paymentFrequency: '5 milestones',
      isActive: true,
    ),
    Contract(
      id: '3',
      title: 'Weave Finance Mobile & Web A...',
      type: 'Pay As You Go',
      paymentAmount: '50 EURt',
      paymentFrequency: 'Per Deliverable',
      isActive: true,
    ),
    Contract(
      id: '4',
      title: 'BlockLayer Validator Integration...',
      type: 'Pay As You Go',
      paymentAmount: '21 USDC',
      paymentFrequency: 'Per Hour',
      isActive: true,
    ),
    Contract(
      id: '5',
      title: 'Legaltide Compliance Audit for...',
      type: 'Pay As You Go',
      paymentAmount: '51 LUSD',
      paymentFrequency: 'Per Day',
      isActive: true,
    ),
    Contract(
      id: '6',
      title: 'Snapworks Product Photograph...',
      type: 'Pay As You Go',
      paymentAmount: '101 DAI',
      paymentFrequency: 'Per Week',
      isActive: true,
    ),
  ];

  ContractsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade50,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
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
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: Colors.grey.shade400, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                Icon(Icons.tune, color: Colors.grey.shade400, size: 20),
              ],
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TimeOffScreen(
                            contractTitle: contracts[index].title,
                          ),
                        ),
                      );
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
