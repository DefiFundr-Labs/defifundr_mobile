import 'package:defifundr_mobile/core/shared/components/search_and_filter_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common/appbar/appbar.dart';

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
      backgroundColor: context.theme.colors.bgB1,
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 60),
        child: DeFiRaiseAppBar(
          centerTitle: true,
          textStyle: context.theme.fonts.heading3SemiBold,
          isBack: true,
          title: 'Contracts',
          actions: const [],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: SearchAndFilterBar(
              searchController: _searchController,
            ),
          ),
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
