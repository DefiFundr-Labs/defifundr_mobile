import 'package:defifundr_mobile/modules/time_tracking/data/models/time_tracking_summary.dart';
import 'package:flutter/material.dart';

class TimeTrackingSummaryCard extends StatelessWidget {
  final TimeTrackingSummary summary;

  const TimeTrackingSummaryCard({Key? key, required this.summary})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              _buildSummaryItem(
                icon: Icons.schedule,
                iconColor: Color(0xFF6366F1),
                label: 'Total hours logged',
                value: '${summary.totalHours} h',
              ),
              SizedBox(width: 20.0),
              _buildSummaryItem(
                icon: Icons.check_circle,
                iconColor: Colors.green,
                label: 'Approved hours',
                value: '${summary.approvedHours} h',
              ),
            ],
          ),
          SizedBox(height: 24.0),
          Row(
            children: [
              _buildSummaryItem(
                icon: Icons.access_time,
                iconColor: Colors.orange,
                label: 'Pending hours',
                value: '${summary.pendingHours} h',
              ),
              SizedBox(width: 20.0),
              _buildSummaryItem(
                icon: Icons.cancel,
                iconColor: Colors.red,
                label: 'Denied hours',
                value: '${summary.deniedHours} h',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 20),
              SizedBox(width: 8.0),
            ],
          ),
          SizedBox(height: 8.0),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
