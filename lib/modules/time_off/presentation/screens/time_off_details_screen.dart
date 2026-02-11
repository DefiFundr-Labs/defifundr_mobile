import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';

import '../../data/models/contract.dart';
import '../../data/models/time_off.dart';
import '../widgets/balance_card.dart';
import '../widgets/contract_selection_bottom_sheet.dart';
import '../widgets/time_off_item.dart';

@RoutePage()
class TimeOffDetailsScreen extends StatefulWidget {
  final String contractTitle;

  const TimeOffDetailsScreen({
    Key? key,
    required this.contractTitle,
  }) : super(key: key);

  @override
  State<TimeOffDetailsScreen> createState() => _TimeOffDetailsScreenState();
}

class _TimeOffDetailsScreenState extends State<TimeOffDetailsScreen> {
  late String selectedContractTitle;
  late String selectedContractId;

  final List<TimeOffContract> availableContracts = [
    TimeOffContract(
      id: '1',
      title: 'NovaWorks Marketing Campaign',
      type: 'Fixed Rate Contract',
      paymentAmount: '',
      paymentFrequency: '',
      isActive: true,
    ),
    TimeOffContract(
      id: '2',
      title: 'Quikdash Mobile & Web App Redesign',
      type: 'Fixed Rate Contract',
      paymentAmount: '',
      paymentFrequency: '',
      isActive: true,
    ),
    TimeOffContract(
      id: '3',
      title: 'Weave Finance Mobile & Web App Redesign',
      type: 'Fixed Rate Contract',
      paymentAmount: '',
      paymentFrequency: '',
      isActive: true,
    ),
    TimeOffContract(
      id: '4',
      title: 'DefiFundr Mobile & Web App Redesign',
      type: 'Fixed Rate Contract',
      paymentAmount: '',
      paymentFrequency: '',
      isActive: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    selectedContractTitle = widget.contractTitle;
    selectedContractId = '2'; // Default to Quikdash
  }

  void _showContractSelection() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ContractSelectionBottomSheet(
        contracts: availableContracts,
        selectedContractId: selectedContractId,
        onContractSelected: (contract) {
          setState(() {
            selectedContractTitle = contract.title;
            selectedContractId = contract.id;
          });
        },
      ),
    );
  }

  final List<TimeOffRequest> upcomingTimeOff = [
    TimeOffRequest(
      id: '1',
      startDate: DateTime(2025, 6, 3),
      endDate: DateTime(2025, 6, 7),
      days: 5,
      type: 'Sick leave',
      status: TimeOffStatus.pending,
      isPaid: true,
    ),
    TimeOffRequest(
      id: '2',
      startDate: DateTime(2025, 5, 20),
      endDate: DateTime(2025, 5, 22),
      days: 3,
      type: 'Personal leave',
      status: TimeOffStatus.approved,
      isPaid: false,
    ),
  ];

  final List<TimeOffRequest> timeOffHistory = [
    TimeOffRequest(
      id: '3',
      startDate: DateTime(2025, 5, 1),
      endDate: DateTime(2025, 5, 5),
      days: 5,
      type: 'Vacation',
      status: TimeOffStatus.rejected,
      isPaid: true,
    ),
    TimeOffRequest(
      id: '4',
      startDate: DateTime(2025, 4, 10),
      endDate: DateTime(2025, 4, 15),
      days: 6,
      type: 'Personal leave',
      status: TimeOffStatus.used,
      isPaid: false,
    ),
    TimeOffRequest(
      id: '5',
      startDate: DateTime(2025, 3, 31),
      endDate: DateTime(2025, 4, 6),
      days: 11,
      type: 'Sick leave',
      status: TimeOffStatus.used,
      isPaid: false,
    ),
    TimeOffRequest(
      id: '6',
      startDate: DateTime(2025, 3, 15),
      endDate: DateTime(2025, 3, 20),
      days: 6,
      type: 'Family emergency',
      status: TimeOffStatus.used,
      isPaid: false,
    ),
    TimeOffRequest(
      id: '7',
      startDate: DateTime(2025, 3, 6),
      endDate: DateTime(2025, 3, 10),
      days: 5,
      type: 'Personal leave',
      status: TimeOffStatus.rejected,
      isPaid: false,
    ),
  ];

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
          'Time off',
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
          GestureDetector(
            onTap: _showContractSelection,
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  Text(
                    'Showing for: ',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      selectedContractTitle,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade400),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BalanceCard(
                    title: 'Paid time off balance',
                    days: 12,
                    onViewDetails: () {},
                  ),
                  const SizedBox(height: 16),
                  BalanceCard(
                    title: 'Unpaid time off balance',
                    days: 12,
                    onViewDetails: () {},
                    onTap: () {
                      context.router.push(UnpaidTimeOffBalanceRoute());
                    },
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Upcoming time off',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...upcomingTimeOff.map((timeOff) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: TimeOffItem(timeOff: timeOff),
                      )),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      const Text(
                        'Time off history',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Text(
                            'See all',
                            style: TextStyle(
                              color: Colors.blue.shade600,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.blue.shade600,
                            size: 12,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ...timeOffHistory.map((timeOff) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: TimeOffItem(timeOff: timeOff),
                      )),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.router.push(const NewTimeOffRequestRoute());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade600,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Request time off',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}