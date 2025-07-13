import 'package:flutter/material.dart';
import '../../data/models/time_off_detail.dart';
import '../widgets/success_bottom_sheet.dart';

class EditTimeOffRequestScreen extends StatefulWidget {
  final TimeOffDetail timeOffDetail;

  const EditTimeOffRequestScreen({
    Key? key,
    required this.timeOffDetail,
  }) : super(key: key);

  @override
  State<EditTimeOffRequestScreen> createState() => _EditTimeOffRequestScreenState();
}

class _EditTimeOffRequestScreenState extends State<EditTimeOffRequestScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  String? selectedTimeOffType;
  String? selectedReason;
  DateTime? startDate;
  DateTime? endDate;
  int requestDays = 0;
  bool hasAttachment = true;

  final List<String> timeOffTypes = [
    'Paid time off',
    'Unpaid time off',
    'Sick leave',
    'Vacation',
    'Personal leave',
    'Family emergency',
  ];

  final List<String> reasons = [
    'Annual leave',
    'Vacation',
    'Personal leave',
    'Sick leave',
    'Family emergency',
    'Medical appointment',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    // Pre-populate with existing data
    selectedTimeOffType = widget.timeOffDetail.type;
    selectedReason = widget.timeOffDetail.reason;
    startDate = widget.timeOffDetail.startDate;
    endDate = widget.timeOffDetail.endDate;
    requestDays = widget.timeOffDetail.totalDays;
    _descriptionController.text = widget.timeOffDetail.description;
  }

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
      initialDate: isStartDate ? startDate ?? DateTime.now() : endDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
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

  void _showDropdown(BuildContext context, List<String> items, String? selectedValue, Function(String?) onChanged, String title) {
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
            Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            const SizedBox(height: 20),
            ...items.map((item) => ListTile(
                  title: Text(item),
                  trailing: selectedValue == item ? Icon(Icons.check, color: Colors.blue.shade600) : null,
                  onTap: () {
                    onChanged(item);
                    Navigator.pop(context);
                  },
                )),
          ],
        ),
      ),
    );
  }

  void _saveChanges() {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (context) => const EditSuccessBottomSheet(),
    );
  }

  void _discardChanges() {
    Navigator.of(context).pop();
  }

  void _removeAttachment() {
    setState(() {
      hasAttachment = false;
    });
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    const months = ['', 'January', 'February', 'March', 'April', 'May', 'June',
                   'July', 'August', 'September', 'October', 'November', 'December'];
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
          'Edit time off request',
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
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Time off type dropdown
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Time off type',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () => _showDropdown(
                            context,
                            timeOffTypes,
                            selectedTimeOffType,
                            (value) => setState(() => selectedTimeOffType = value),
                            'Select Time Off Type',
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  selectedTimeOffType ?? 'Select type',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade400),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Reason dropdown
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Reason',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () => _showDropdown(
                            context,
                            reasons,
                            selectedReason,
                            (value) => setState(() => selectedReason = value),
                            'Select Reason',
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  selectedReason ?? 'Select reason',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade400),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Start date
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Start date',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () => _selectDate(context, true),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  _formatDate(startDate),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              Icon(Icons.calendar_today_outlined, color: Colors.grey.shade400, size: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // End date
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'End date',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () => _selectDate(context, false),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  _formatDate(endDate),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              Icon(Icons.calendar_today_outlined, color: Colors.grey.shade400, size: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Number of request days
                  Container(
                    padding: const EdgeInsets.all(16),
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
                          '$requestDays days',
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
                      decoration: const InputDecoration(
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
                  if (hasAttachment) 
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.description, color: Colors.blue.shade600, size: 20),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              'File name',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: _removeAttachment,
                            child: Icon(Icons.delete, color: Colors.red.shade600, size: 20),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          
          // Bottom buttons
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _discardChanges,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: BorderSide(color: Colors.grey.shade300),
                    ),
                    child: const Text(
                      'Discard changes',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _saveChanges,
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
                      'Save changes',
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
        ],
      ),
    );
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }
}
