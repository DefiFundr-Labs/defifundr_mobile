import 'package:defifundr_mobile/core/shared/components/search_and_filter_bar.dart';
import 'package:defifundr_mobile/modules/time_off/data/models/time_off.dart';
import 'package:flutter/material.dart';

import '../widgets/time_off_card_container.dart';
import '../widgets/time_off_item.dart';
import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common/appbar/appbar.dart';

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
    _searchController.addListener(() {
      _filterTimeOff(_searchController.text);
    });
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
      backgroundColor: context.theme.colors.bgB1,
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 60),
        child: DeFiRaiseAppBar(
          centerTitle: true,
          textStyle: context.theme.fonts.heading3SemiBold,
          isBack: true,
          title: 'Time off history',
          actions: [],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: SearchAndFilterBar(searchController: _searchController),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filteredTimeOff.length,
              itemBuilder: (context, index) {
                return TimeOffCardContainer(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
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
