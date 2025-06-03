import 'package:defifundr_mobile/core/constants/app_icons.dart';
import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/textfield/app_text_field.dart';
import 'package:defifundr_mobile/feature/transaction/transaction_bloc/transaction_bloc.dart';
import 'package:defifundr_mobile/feature/transaction/models/transaction_model.dart';
import 'package:defifundr_mobile/feature/transaction/widgets/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../core/shared/appbar/appbar.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  String _searchQuery = '';
  List<String> _lastTypes = ['All'];
  String _lastStatus = 'All';
  DateTimeRange? _lastDateRange;

  void _applyFilter({
    List<String>? types,
    String? status,
    DateTimeRange? dateRange,
    String? search,
  }) {
    _lastTypes = types ?? _lastTypes;
    _lastStatus = status ?? _lastStatus;
    _lastDateRange = dateRange ?? _lastDateRange;
    _searchQuery = search ?? _searchQuery;
    context.read<TransactionBloc>().add(
          FilterTransactions(
            types: _lastTypes,
            status: _lastStatus,
            startDate: _lastDateRange?.start,
            endDate: _lastDateRange?.end,
            search: _searchQuery,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return BlocProvider(
      create: (context) => TransactionBloc()..add(LoadTransactions()),
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: PreferredSize(
          preferredSize: Size(context.screenWidth(), 60),
          child: DeFiRaiseAppBar(
            title: 'Transactions',
            isBack: true,
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            context.read<TransactionBloc>().add(LoadTransactions());
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                _buildSearchHeader(theme, context),
                Expanded(
                  child: BlocBuilder<TransactionBloc, TransactionState>(
                    builder: (context, state) {
                      if (state is TransactionLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is TransactionLoaded) {
                        if (state.transactionsByDate.isEmpty) {
                          return _buildEmptyState(theme);
                        }
                        return ListView.builder(
                          itemCount: state.transactionsByDate.length,
                          itemBuilder: (context, index) {
                            final date =
                                state.transactionsByDate.keys.elementAt(index);
                            final transactions =
                                state.transactionsByDate[date]!;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Divider(
                                          color: theme.colors.grayTertiary,
                                          thickness: 1,
                                          endIndent: 8,
                                        ),
                                      ),
                                      Text(
                                        _formatDate(date),
                                        style: theme.textTheme.titleSmall!
                                            .copyWith(
                                                color: context
                                                    .theme.colors.grayTertiary),
                                      ),
                                      Expanded(
                                        child: Divider(
                                          color: theme.colors.grayTertiary,
                                          thickness: 1,
                                          indent: 8,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: theme.colors.bgB0,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  margin: const EdgeInsets.only(bottom: 16),
                                  child: Column(
                                    children: transactions
                                        .map((transaction) => Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 16),
                                              child: TransactionItem(
                                                  transaction: transaction),
                                            ))
                                        .toList(),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      } else if (state is TransactionError) {
                        return Center(child: Text(state.message));
                      }
                      return const SizedBox();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('d MMMM, y').format(date);
  }

  Row _buildSearchHeader(ThemeData theme, BuildContext context) {
    return Row(
      children: [
        Container(
          width: 286.w,
          height: 40.h,
          decoration: BoxDecoration(
            color: context.theme.colors.bgB0,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextFormField(
            initialValue: _searchQuery,
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
              _applyFilter(search: value);
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              prefixIcon: Icon(Icons.search, color: theme.colors.graySecondary),
              hintText: 'Search',
              hintStyle: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colors.graySecondary,
              ),
            ),
          ),
        ),
        HorizontalMargin(8),
        GestureDetector(
          onTap: () async {
            final result = await showModalBottomSheet<Map<String, dynamic>>(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              builder: (context) => _TransactionFilterSheet(
                initialTypes: _lastTypes,
                initialStatus: _lastStatus,
                initialDateRange: _lastDateRange,
              ),
            );
            if (result != null) {
              _applyFilter(
                types: result['types'] as List<String>?,
                status: result['status'] as String?,
                dateRange: result['dateRange'] as DateTimeRange?,
              );
            }
          },
          child: Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: context.theme.colors.bgB0,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.filter_list, color: theme.colors.graySecondary),
          ),
        ),
      ],
    );
  }

  Column _buildEmptyState(ThemeData theme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(AppAssets.emptyState),
        Text('No transactions yet', style: theme.textTheme.bodyLarge),
        Text(
          'Transactions will appear here as you use the platform.',
          style: theme.textTheme.bodyMedium!
              .copyWith(color: theme.colors.textSecondary),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _TransactionFilterSheet extends StatefulWidget {
  final List<String> initialTypes;
  final String initialStatus;
  final DateTimeRange? initialDateRange;
  const _TransactionFilterSheet({
    this.initialTypes = const ['All'],
    this.initialStatus = 'All',
    this.initialDateRange,
  });

  @override
  State<_TransactionFilterSheet> createState() =>
      _TransactionFilterSheetState();
}

class _TransactionFilterSheetState extends State<_TransactionFilterSheet> {
  static const List<String> _transactionTypes = [
    'All',
    'Contract payment',
    'Invoice',
    'Quickpay',
    'Withdrawal',
  ];
  static const List<String> _statuses = [
    'All',
    'Processing',
    'Successful',
    'Failed',
  ];
  late List<String> _selectedTypes;
  late String _selectedStatus;
  DateTimeRange? _selectedDateRange;
  bool _typeExpanded = true;
  bool _statusExpanded = true;
  bool _dateExpanded = false;

  @override
  void initState() {
    super.initState();
    _selectedTypes = List<String>.from(widget.initialTypes);
    _selectedStatus = widget.initialStatus;
    _selectedDateRange = widget.initialDateRange;
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: 24 + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Filter by', style: theme.textTheme.titleLarge),
            SizedBox(height: 24),
            _buildExpansionPanel(
              title: 'Transaction type',
              expanded: _typeExpanded,
              onToggle: () => setState(() => _typeExpanded = !_typeExpanded),
              child: Column(
                children: _transactionTypes.map((type) {
                  final isSelected = _selectedTypes.contains(type);
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    trailing: _CustomCheckbox(
                      value: isSelected,
                      onChanged: (val) {
                        setState(() {
                          if (type == 'All') {
                            _selectedTypes = ['All'];
                          } else {
                            _selectedTypes.remove('All');
                            if (val == true) {
                              _selectedTypes.add(type);
                            } else {
                              _selectedTypes.remove(type);
                            }
                            if (_selectedTypes.isEmpty) {
                              _selectedTypes = ['All'];
                            }
                          }
                        });
                      },
                    ),
                    title: Text(type, style: theme.textTheme.bodyLarge),
                    onTap: () {
                      final val = !_selectedTypes.contains(type);
                      setState(() {
                        if (type == 'All') {
                          _selectedTypes = ['All'];
                        } else {
                          _selectedTypes.remove('All');
                          if (val) {
                            _selectedTypes.add(type);
                          } else {
                            _selectedTypes.remove(type);
                          }
                          if (_selectedTypes.isEmpty) {
                            _selectedTypes = ['All'];
                          }
                        }
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            Divider(
              height: 32,
              color: context.theme.colors.grayTertiary,
            ),
            _buildExpansionPanel(
              title: 'Status',
              expanded: _statusExpanded,
              onToggle: () =>
                  setState(() => _statusExpanded = !_statusExpanded),
              child: Wrap(
                spacing: 8,
                children: _statuses.map((status) {
                  final isSelected = _selectedStatus == status;
                  return ChoiceChip(
                    label: Text(status),
                    selected: isSelected,
                    selectedColor: theme.colors.blueStroke.withAlpha(50),
                    labelStyle: theme.textTheme.bodyLarge?.copyWith(
                      color: isSelected
                          ? theme.colors.blueDefault
                          : theme.colors.textPrimary,
                    ),
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(
                        color: isSelected
                            ? theme.colors.blueDefault
                            : theme.colors.grayTertiary,
                      ),
                    ),
                    onSelected: (_) {
                      setState(() => _selectedStatus = status);
                    },
                  );
                }).toList(),
              ),
            ),
            Divider(
              height: 32,
              color: context.theme.colors.grayTertiary,
            ),
            _buildExpansionPanel(
              title: 'Date',
              expanded: _dateExpanded,
              onToggle: () => setState(() => _dateExpanded = !_dateExpanded),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () async {
                      final now = DateTime.now();
                      final picked = await showDateRangePicker(
                        context: context,
                        firstDate: DateTime(now.year - 5),
                        lastDate: DateTime(now.year + 1),
                        initialDateRange: _selectedDateRange,
                      );
                      if (picked != null) {
                        setState(() => _selectedDateRange = picked);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        color: theme.colors.bgB0,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: theme.colors.grayTertiary),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _selectedDateRange == null
                                ? 'Select date range'
                                : '${DateFormat('d MMM, y').format(_selectedDateRange!.start)} - ${DateFormat('d MMM, y').format(_selectedDateRange!.end)}',
                            style: theme.textTheme.bodyLarge,
                          ),
                          Icon(Icons.calendar_today,
                              color: theme.colors.grayTertiary),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedTypes = ['All'];
                        _selectedStatus = 'All';
                        _selectedDateRange = null;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colors.fillTertiary,
                      foregroundColor: theme.colors.textPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      elevation: 0,
                    ),
                    child: const Text('Clear all'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop({
                        'types': _selectedTypes,
                        'status': _selectedStatus,
                        'dateRange': _selectedDateRange,
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colors.blueDefault,
                      foregroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      elevation: 0,
                    ),
                    child: const Text('Show results'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpansionPanel({
    required String title,
    required bool expanded,
    required VoidCallback onToggle,
    required Widget child,
  }) {
    final theme = context.theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onToggle,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: theme.textTheme.titleMedium),
              Icon(
                expanded ? Icons.expand_less : Icons.expand_more,
                color: theme.colors.grayTertiary,
              ),
            ],
          ),
        ),
        if (expanded) ...[
          const SizedBox(height: 8),
          child,
        ],
      ],
    );
  }
}

class _CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const _CustomCheckbox({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: value ? theme.colors.blueDefault : Colors.transparent,
          border: Border.all(
            color: value ? theme.colors.blueDefault : theme.colors.grayTertiary,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: value ? Icon(Icons.check, size: 18, color: Colors.white) : null,
      ),
    );
  }
}
