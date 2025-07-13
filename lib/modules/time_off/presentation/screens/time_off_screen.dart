import 'package:flutter/material.dart';

import '../../data/models/contract.dart';
import '../screens/new_time_off_request_screen.dart';
import '../screens/time_off_history_screen.dart';
import '../screens/unpaid_time_off_balance_screen.dart';
import '../widgets/balance_card.dart';
import '../widgets/contract_selection_bottom_sheet.dart';

class TimeOffScreen extends StatefulWidget {
  final String contractTitle;

  const TimeOffScreen({
    Key? key,
    required this.contractTitle,
  }) : super(key: key);

  @override
  State<TimeOffScreen> createState() => _TimeOffScreenState();
}

class _TimeOffScreenState extends State<TimeOffScreen> {
  late String selectedContractTitle;
  late String selectedContractId;

  final List<Contract> availableContracts = [
    Contract(
      id: '1',
      title: 'NovaWorks Marketing Campaign',
      type: 'Fixed Rate Contract',
      paymentAmount: '',
      paymentFrequency: '',
      isActive: true,
    ),
    Contract(
      id: '2',
      title: 'Quikdash Mobile & Web App Redesign',
      type: 'Fixed Rate Contract',
      paymentAmount: '',
      paymentFrequency: '',
      isActive: true,
    ),
    Contract(
      id: '3',
      title: 'Weave Finance Mobile & Web App Redesign',
      type: 'Fixed Rate Contract',
      paymentAmount: '',
      paymentFrequency: '',
      isActive: true,
    ),
    Contract(
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UnpaidTimeOffBalanceScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      const Text(
                        'Upcoming time off',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: Colors.grey.shade400,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'No upcoming time off event',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
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
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const TimeOffHistoryScreen(),
                            ),
                          );
                        },
                        child: Row(
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
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/empty_calendar.png', // You'll need to add this asset
                          width: 80,
                          height: 80,
                          color: Colors.grey.shade300,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.calendar_today_outlined,
                              size: 60,
                              color: Colors.grey.shade300,
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'No time off records yet',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'When you apply for and take time off,\nit\'ll show up here.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NewTimeOffRequestScreen(),
                    ),
                  );
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
