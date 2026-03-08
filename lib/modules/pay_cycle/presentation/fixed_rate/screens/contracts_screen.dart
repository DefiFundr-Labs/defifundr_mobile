import 'package:defifundr_mobile/core/shared/components/search_and_filter_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../data/models/contract.dart';
import '../../../data/models/mock_data.dart';
import '../widgets/contract_card.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';

@RoutePage()
class PayCycleContractsScreen extends StatefulWidget {
  const PayCycleContractsScreen({Key? key}) : super(key: key);

  @override
  State<PayCycleContractsScreen> createState() =>
      _PayCycleContractsScreenState();
}

class _PayCycleContractsScreenState extends State<PayCycleContractsScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<PayCycleContract> _contracts = [];
  List<PayCycleContract> _filteredContracts = [];

  @override
  void initState() {
    super.initState();
    _loadContracts();
    _searchController.addListener(() {
      _filterContracts(_searchController.text);
    });
  }

  void _loadContracts() {
    _contracts = MockData.contracts;
    _filteredContracts = _contracts;
  }

  void _filterContracts(String query) {
    setState(() {
      _filteredContracts = _contracts
          .where((contract) =>
              contract.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade50,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => context.router.maybePop(),
        ),
        title: const Text(
          'Contracts',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: SearchAndFilterBar(
              searchController: _searchController,
            ),
          ),
          // Contracts List
          Expanded(
            child: ListView.builder(
              itemCount: _filteredContracts.length,
              itemBuilder: (context, index) {
                final contract = _filteredContracts[index];
                return ContractCard(
                  contract: contract,
                  onTap: () {
                    context.router.push(
                      ContractDetailRoute(
                        contract: contract,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
