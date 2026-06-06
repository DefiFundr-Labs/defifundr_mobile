import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/components/search_and_filter_bar.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';
import 'package:defifundr_mobile/modules/time_tracking/data/models/contract.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/widgets/contract_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class WorkspaceContractsScreen extends StatefulWidget {
  const WorkspaceContractsScreen({super.key});

  @override
  State<WorkspaceContractsScreen> createState() =>
      _WorkspaceContractsScreenState();
}

class _WorkspaceContractsScreenState extends State<WorkspaceContractsScreen> {
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
      title: 'BlockLayer Validator Integration for DefiFundr',
      type: ContractType.milestone,
      rate: 20,
      currency: 'LUSD',
      status: ContractStatus.pending,
    ),
    TimeTrackingContract(
      id: '4',
      title: 'DefiFundr Mobile & Web App Redesign',
      type: ContractType.fixedRate,
      rate: 81,
      currency: 'USDT',
      status: ContractStatus.pendingSignature,
    ),
  ];

  List<TimeTrackingContract> _filteredContracts = [];

  @override
  void initState() {
    super.initState();
    _filteredContracts = contracts;
    _searchController.addListener(_filterContracts);
  }

  void _filterContracts() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredContracts = contracts;
      } else {
        _filteredContracts = contracts
            .where(
                (contract) => contract.title.toLowerCase().contains(query))
            .toList();
      }
    });
  }

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
            padding: const EdgeInsets.all(16),
            child: SearchAndFilterBar(
              searchController: _searchController,
            ),
          ),
          Expanded(
            child: _filteredContracts.isEmpty
                ? Center(
                    child: Text(
                      'No contracts found',
                      style: context.theme.fonts.textMdRegular.copyWith(
                        color: context.theme.colors.textSecondary,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: _filteredContracts.length,
                    itemBuilder: (context, index) {
                      final contract = _filteredContracts[index];
                      return ContractCard(
                        contract: contract,
                        onTap: () {
                          context.router.push(
                            ViewContractRoute(contract: contract),
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
}
