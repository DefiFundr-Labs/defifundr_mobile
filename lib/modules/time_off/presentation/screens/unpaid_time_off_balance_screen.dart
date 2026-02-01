import 'package:defifundr_mobile/modules/time_off/data/models/time_off.dart';
import 'package:flutter/material.dart';

import '../widgets/time_off_item.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class UnpaidTimeOffBalanceScreen extends StatelessWidget {
  final List<TimeOffRequest> upcomingTimeOff = [
    TimeOffRequest(
      id: '1',
      startDate: DateTime(2025, 5, 20),
      endDate: DateTime(2025, 5, 22),
      days: 3,
      type: 'Personal leave',
      status: TimeOffStatus.approved,
      isPaid: false,
    ),
  ];

  final List<TimeOffRequest> pastTimeOff = [
    TimeOffRequest(
      id: '2',
      startDate: DateTime(2025, 4, 10),
      endDate: DateTime(2025, 4, 15),
      days: 6,
      type: 'Personal leave',
      status: TimeOffStatus.used,
      isPaid: false,
    ),
    TimeOffRequest(
      id: '3',
      startDate: DateTime(2025, 3, 31),
      endDate: DateTime(2025, 4, 6),
      days: 11,
      type: 'Sick leave',
      status: TimeOffStatus.used,
      isPaid: false,
    ),
    TimeOffRequest(
      id: '4',
      startDate: DateTime(2025, 3, 15),
      endDate: DateTime(2025, 3, 20),
      days: 6,
      type: 'Family emergency',
      status: TimeOffStatus.used,
      isPaid: false,
    ),
  ];

  UnpaidTimeOffBalanceScreen({Key? key}) : super(key: key);

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
          'Unpaid time off balance',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Balance Summary Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        color: Colors.blue.shade600,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Balance',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    '74 days',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Stats Row
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_month_outlined,
                              color: Colors.blue.shade600,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Allowance',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          '100 days',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.check_circle_outline,
                              color: Colors.green.shade600,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Used / scheduled',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          '26 days',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Upcoming time off events
            const Text(
              'Upcoming time off events',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            ...upcomingTimeOff.map((timeOff) => Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: TimeOffItem(timeOff: timeOff),
                )),
            const SizedBox(height: 24),

            // Past time off events
            const Text(
              'Past time off events',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            ...pastTimeOff.map((timeOff) => Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: TimeOffItem(timeOff: timeOff),
                )),
          ],
        ),
      ),
    );
  }
}
