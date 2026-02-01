import 'package:defifundr_mobile/modules/time_off/data/models/time_off_detail.dart';
import 'package:flutter/material.dart';
import '../../data/models/time_off.dart';
import '../widgets/status_chip.dart';
import '../widgets/success_bottom_sheet.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class CancelTimeOffRequestScreen extends StatefulWidget {
  final TimeOffDetail timeOffDetail;

  const CancelTimeOffRequestScreen({
    Key? key,
    required this.timeOffDetail,
  }) : super(key: key);

  @override
  State<CancelTimeOffRequestScreen> createState() => _CancelTimeOffRequestScreenState();
}

class _CancelTimeOffRequestScreenState extends State<CancelTimeOffRequestScreen> {
  final TextEditingController _reasonController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.timeOffDetail.status == TimeOffStatus.pending) {
      _reasonController.text = 'Decided to cancel the holiday plans due to a change in family circumstances.';
    }
  }

  void _submitCancellation() {
    if (_reasonController.text.trim().isNotEmpty) {
      showModalBottomSheet(
        context: context,
        isDismissible: false,
        enableDrag: false,
        backgroundColor: Colors.transparent,
        builder: (context) => const CancellationSuccessBottomSheet(),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide a reason for cancellation'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  String get title {
    return widget.timeOffDetail.status == TimeOffStatus.approved 
        ? 'Cancel time off request'
        : 'Cancel time off request';
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
        title: Text(
          title,
          style: const TextStyle(
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
                  // Approval needed warning (only for approved requests)
                  if (widget.timeOffDetail.status == TimeOffStatus.approved) ...[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.orange.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Approval needed',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.orange.shade700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'The cancellation of this time off will require approval.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Time off details card
                  Container(
                    width: double.infinity,
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
                            Expanded(
                              child: Text(
                                widget.timeOffDetail.reason,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            StatusChip(status: widget.timeOffDetail.status),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '${widget.timeOffDetail.dateRange} • ${widget.timeOffDetail.totalDays} days holiday',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          widget.timeOffDetail.description,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                            height: 1.4,
                          ),
                        ),
                        if (widget.timeOffDetail.attachmentFileName != null) ...[
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.description_outlined, size: 16, color: Colors.grey.shade600),
                                const SizedBox(width: 6),
                                Text(
                                  widget.timeOffDetail.attachmentFileName!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Reason for cancellation
                  const Text(
                    'Reason for cancellation',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: TextField(
                      controller: _reasonController,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Submit button
          Container(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitCancellation,
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
                  'Submit cancellation',
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

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }
}