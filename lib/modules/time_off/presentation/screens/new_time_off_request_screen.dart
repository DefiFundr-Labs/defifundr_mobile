import 'package:flutter/material.dart';

import '../widgets/success_bottom_sheet.dart';

class NewTimeOffRequestScreen extends StatefulWidget {
  const NewTimeOffRequestScreen({Key? key}) : super(key: key);

  @override
  State<NewTimeOffRequestScreen> createState() =>
      _NewTimeOffRequestScreenState();
}

class _NewTimeOffRequestScreenState extends State<NewTimeOffRequestScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  String? selectedTimeOffType;
  String? selectedReason;
  DateTime? startDate;
  DateTime? endDate;
  int requestDays = 0;

  final List<String> timeOffTypes = [
    'Paid time off',
    'Unpaid time off',
    'Sick leave',
    'Vacation',
    'Personal leave',
    'Family emergency',
  ];

  final List<String> reasons = [
    'Vacation',
    'Personal leave',
    'Sick leave',
    'Family emergency',
    'Medical appointment',
    'Other',
  ];

  void _calculateRequestDays() {
    if (startDate != null && endDate != null) {
      final difference = endDate!.difference(startDate!).inDays + 1;
      setState(() {
        requestDays = difference > 0 ? difference : 0;
      });
    }
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue.shade600,
              onPrimary: Colors.white,
              onSurface: Colors.black87,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          startDate = picked;
          if (endDate != null && endDate!.isBefore(picked)) {
            endDate = null;
            requestDays = 0;
          }
        } else {
          endDate = picked;
        }
        _calculateRequestDays();
      });
    }
  }

  void _showDropdown(BuildContext context, List<String> items,
      String? selectedValue, Function(String?) onChanged, String title) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            ...items.map((item) => ListTile(
                  title: Text(item),
                  trailing: selectedValue == item
                      ? Icon(Icons.check, color: Colors.blue.shade600)
                      : null,
                  onTap: () {
                    onChanged(item);
                    Navigator.pop(context);
                  },
                )),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _submitRequest() {
    if (selectedTimeOffType != null &&
        selectedReason != null &&
        startDate != null &&
        endDate != null &&
        requestDays > 0) {
      showModalBottomSheet(
        context: context,
        isDismissible: false,
        enableDrag: false,
        backgroundColor: Colors.transparent,
        builder: (context) => const SuccessBottomSheet(),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all required fields'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    final months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${date.day} ${months[date.month]} ${date.year}';
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
          'New time off request',
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
            // Time off type dropdown
            GestureDetector(
              onTap: () => _showDropdown(
                context,
                timeOffTypes,
                selectedTimeOffType,
                (value) => setState(() => selectedTimeOffType = value),
                'Select Time Off Type',
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        selectedTimeOffType ?? 'Time off type',
                        style: TextStyle(
                          fontSize: 16,
                          color: selectedTimeOffType != null
                              ? Colors.black87
                              : Colors.grey.shade400,
                        ),
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_down,
                        color: Colors.grey.shade400),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Reason dropdown
            GestureDetector(
              onTap: () => _showDropdown(
                context,
                reasons,
                selectedReason,
                (value) => setState(() => selectedReason = value),
                'Select Reason',
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        selectedReason ?? 'Reason',
                        style: TextStyle(
                          fontSize: 16,
                          color: selectedReason != null
                              ? Colors.black87
                              : Colors.grey.shade400,
                        ),
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_down,
                        color: Colors.grey.shade400),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Start date
            GestureDetector(
              onTap: () => _selectDate(context, true),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        startDate != null
                            ? _formatDate(startDate)
                            : 'Start date',
                        style: TextStyle(
                          fontSize: 16,
                          color: startDate != null
                              ? Colors.black87
                              : Colors.grey.shade400,
                        ),
                      ),
                    ),
                    Icon(Icons.calendar_today_outlined,
                        color: Colors.grey.shade400, size: 20),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // End date
            GestureDetector(
              onTap: () => _selectDate(context, false),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        endDate != null ? _formatDate(endDate) : 'End date',
                        style: TextStyle(
                          fontSize: 16,
                          color: endDate != null
                              ? Colors.black87
                              : Colors.grey.shade400,
                        ),
                      ),
                    ),
                    Icon(Icons.calendar_today_outlined,
                        color: Colors.grey.shade400, size: 20),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Number of request days
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'No of request days',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                  Text(
                    requestDays > 0 ? '$requestDays' : '--',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Description field
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: TextField(
                controller: _descriptionController,
                maxLines: 6,
                decoration: InputDecoration(
                  hintText: 'Enter time off description',
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Attachment section
            const Text(
              'Attachment (Optional)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: Column(
                children: [
                  Text(
                    'Click to upload',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Supported formats: PDF, JPEG or PNG; Max file size: 10MB',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 40),

            // Submit button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitRequest,
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
                  'Submit request',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }
}
