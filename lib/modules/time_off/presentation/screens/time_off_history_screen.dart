import 'package:defifundr_mobile/modules/time_off/data/models/time_off.dart';
import 'package:flutter/material.dart';

import '../widgets/time_off_item.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class TimeOffHistoryScreen extends StatefulWidget {
  const TimeOffHistoryScreen({Key? key}) : super(key: key);

  @override
  State<TimeOffHistoryScreen> createState() => _TimeOffHistoryScreenState();
}

class _TimeOffHistoryScreenState extends State<TimeOffHistoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<TimeOffRequest> filteredTimeOff = [];

  final List<TimeOffRequest> allTimeOffHistory = [
    TimeOffRequest(
      id: '1',
      startDate: DateTime(2025, 5, 1),
      endDate: DateTime(2025, 5, 5),
      days: 5,
      type: 'Vacation',
      status: TimeOffStatus.rejected,
      isPaid: true,
    ),
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
    TimeOffRequest(
      id: '5',
      startDate: DateTime(2025, 3, 6),
      endDate: DateTime(2025, 3, 10),
      days: 5,
      type: 'Personal leave',
      status: TimeOffStatus.rejected,
      isPaid: false,
    ),
    TimeOffRequest(
      id: '6',
      startDate: DateTime(2025, 3, 1),
      endDate: DateTime(2025, 3, 3),
      days: 5,
      type: 'Vacation',
      status: TimeOffStatus.rejected,
      isPaid: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    filteredTimeOff = allTimeOffHistory;
  }

  void _filterTimeOff(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredTimeOff = allTimeOffHistory;
      } else {
        filteredTimeOff = allTimeOffHistory.where((timeOff) {
          return timeOff.type.toLowerCase().contains(query.toLowerCase()) ||
              timeOff.dateRange.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
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
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => context.router.maybePop(),
        ),
        title: const Text(
          'Time off history',
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
          // Search Bar
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
                    controller: _searchController,
                    onChanged: _filterTimeOff,
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

          // Time off history list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filteredTimeOff.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: TimeOffItem(timeOff: filteredTimeOff[index]),
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
