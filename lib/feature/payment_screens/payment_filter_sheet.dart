import 'package:flutter/material.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/design_system/font_extension/font_extension.dart';
import 'package:defifundr_mobile/core/design_system/color_extension/app_color_extension.dart';
import 'package:defifundr_mobile/feature/payment_screens/models/payment.dart';

// Define enums for filter options if needed, or use existing ones
enum FilterTransactionType { all, contract, invoice }

enum FilterStatus { all, upcoming, overdue }

class PaymentFilterSheet extends StatefulWidget {
  // Add parameters for initial filters or callback function
  const PaymentFilterSheet({Key? key}) : super(key: key);

  @override
  _PaymentFilterSheetState createState() => _PaymentFilterSheetState();
}

class _PaymentFilterSheetState extends State<PaymentFilterSheet> {
  // State variables for selected filters
  FilterTransactionType _selectedTransactionType = FilterTransactionType.all;
  FilterStatus _selectedStatus = FilterStatus.all;

  // State variables for section expansion
  bool _isTransactionTypeExpanded = true;
  bool _isStatusExpanded = true;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorExtension>()!;
    final fontTheme = Theme.of(context).extension<AppFontThemeExtension>()!;

    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: colors.bgB0, // Background color from theme
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                color: colors.strokeSecondary, // Handle color
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Filter by',
                    style: fontTheme.heading2Bold, // Title style
                  ),
                  const SizedBox(height: 20),

                  // Transaction Type Filter Section
                  _buildFilterSection(
                    context,
                    'Transaction type',
                    [
                      _buildCheckboxRow(context, 'All',
                          _selectedTransactionType == FilterTransactionType.all,
                          (bool? newValue) {
                        if (newValue == true)
                          setState(() => _selectedTransactionType =
                              FilterTransactionType.all);
                      }),
                      _buildCheckboxRow(
                          context,
                          'Contract payment',
                          _selectedTransactionType ==
                              FilterTransactionType.contract, (bool? newValue) {
                        if (newValue == true)
                          setState(() => _selectedTransactionType =
                              FilterTransactionType.contract);
                      }),
                      _buildCheckboxRow(
                          context,
                          'Invoice',
                          _selectedTransactionType ==
                              FilterTransactionType.invoice, (bool? newValue) {
                        if (newValue == true)
                          setState(() => _selectedTransactionType =
                              FilterTransactionType.invoice);
                      }),
                    ],
                    isExpanded: _isTransactionTypeExpanded,
                    onTap: () {
                      setState(() => _isTransactionTypeExpanded =
                          !_isTransactionTypeExpanded);
                    },
                  ),
                  const SizedBox(height: 20),

                  // Status Filter Section
                  _buildFilterSection(
                    context,
                    'Status',
                    [
                      _buildStatusChip(
                          context, 'All', FilterStatus.all, _selectedStatus,
                          (FilterStatus status) {
                        setState(() => _selectedStatus = status);
                      }),
                      _buildStatusChip(context, 'Coming', FilterStatus.upcoming,
                          _selectedStatus, (FilterStatus status) {
                        setState(() => _selectedStatus = status);
                      }, chipColor: colors.blueHover), // Use appropriate color
                      _buildStatusChip(context, 'Overdue', FilterStatus.overdue,
                          _selectedStatus, (FilterStatus status) {
                        setState(() => _selectedStatus = status);
                      },
                          chipColor:
                              colors.orangeHover), // Use appropriate color
                    ],
                    showChips: false,
                    isExpanded: _isStatusExpanded,
                    onTap: () {
                      setState(() => _isStatusExpanded = !_isStatusExpanded);
                    },
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
          // Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Clear filters logic
                    setState(() {
                      _selectedTransactionType = FilterTransactionType.all;
                      _selectedStatus = FilterStatus.all;
                    });
                    // Dismiss sheet and signal to clear filters
                    Navigator.pop(context, {
                      'transactionType': FilterTransactionType.all,
                      'status': FilterStatus.all
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: colors.bgB2, // Grey button color
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      )),
                  child: Text('Clear all',
                      style: fontTheme.textBaseMedium
                          ?.copyWith(color: colors.textPrimary)), // Text style
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Apply filters and dismiss sheet
                    // Pass selected filters back
                    Navigator.pop(context, {
                      'transactionType': _selectedTransactionType,
                      'status': _selectedStatus
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          colors.brandDefault, // Purple button color
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      )),
                  child: Text('Show results',
                      style: fontTheme.textBaseMedium
                          ?.copyWith(color: colors.textWhite)), // Text style
                ),
              ),
            ],
          ),
          const SizedBox(height: 20), // Bottom padding for buttons
        ],
      ),
    );
  }

  Widget _buildFilterSection(
      BuildContext context, String title, List<Widget> children,
      {bool showChips = false,
      required bool isExpanded,
      required VoidCallback onTap}) {
    final fontTheme = Theme.of(context).extension<AppFontThemeExtension>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: fontTheme.textBaseBold,
                ),
                Icon(isExpanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        if (isExpanded)
          if (showChips)
            Row(children: children)
          else
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children),
      ],
    );
  }

  Widget _buildCheckboxRow(BuildContext context, String label, bool isSelected,
      ValueChanged<bool?> onChanged) {
    final colors = Theme.of(context).extension<AppColorExtension>()!;
    final fontTheme = Theme.of(context).extension<AppFontThemeExtension>()!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: fontTheme.textBaseRegular),
          Checkbox(
            value: isSelected,
            onChanged: onChanged,
            activeColor: colors.brandDefault,
            side: BorderSide(color: colors.strokeSecondary),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0)),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(
      BuildContext context,
      String label,
      FilterStatus status,
      FilterStatus selectedStatus,
      ValueChanged<FilterStatus> onTap,
      {Color? chipColor}) {
    final colors = Theme.of(context).extension<AppColorExtension>()!;
    final fontTheme = Theme.of(context).extension<AppFontThemeExtension>()!;
    final isSelected = status == selectedStatus;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
        label: Text(label,
            style: isSelected
                ? fontTheme.textSmBold?.copyWith(color: colors.textWhite)
                : fontTheme.textSmRegular?.copyWith(color: colors.textPrimary)),
        selected: isSelected,
        selectedColor: chipColor ?? colors.brandDefault,
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? colors.bgB0 // Light mode color
            : colors.bgB1,
        onSelected: (bool selected) {
          if (selected) {
            onTap(status);
          }
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.0),
            side: BorderSide(
                color: isSelected
                    ? chipColor ?? colors.brandDefault
                    : colors.strokeSecondary,
                width: 1.0)),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        labelPadding: EdgeInsets.zero,
        elevation: 0,
      ),
    );
  }
}
