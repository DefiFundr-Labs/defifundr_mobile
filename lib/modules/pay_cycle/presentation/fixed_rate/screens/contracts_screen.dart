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
  State<PayCycleContractsScreen> createState() => _PayCycleContractsScreenState();
}

class _PayCycleContractsScreenState extends State<PayCycleContractsScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<PayCycleContract> _contracts = [];
  List<PayCycleContract> _filteredContracts = [];

  @override
  void initState() {
    super.initState();
    _loadContracts();
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
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: _filterContracts,
                      decoration: const InputDecoration(
                        hintText: 'Search',
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: const Icon(Icons.tune, color: Colors.grey),
                ),
              ],
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
