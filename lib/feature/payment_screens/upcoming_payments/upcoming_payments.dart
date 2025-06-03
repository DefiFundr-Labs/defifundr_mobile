import 'package:defifundr_mobile/core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import '../widgets/payment_item_card.dart';
import '../models/payment.dart';
import 'package:defifundr_mobile/core/shared/appbar/appbar_header.dart';
import 'package:go_router/go_router.dart';
import 'package:defifundr_mobile/core/routers/routes_constant.dart';
import 'package:defifundr_mobile/feature/payment_screens/payment_filter_sheet.dart';

class UpcomingPaymentsScreen extends StatefulWidget {
  const UpcomingPaymentsScreen({Key? key}) : super(key: key);

  @override
  _UpcomingPaymentsScreenState createState() => _UpcomingPaymentsScreenState();
}

class _UpcomingPaymentsScreenState extends State<UpcomingPaymentsScreen> {
  List<Payment> _allPayments = [];
  List<Payment> _filteredPayments = [];

  FilterTransactionType _currentTransactionFilter = FilterTransactionType.all;
  FilterStatus _currentStatusFilter = FilterStatus.all;

  @override
  void initState() {
    super.initState();
    _allPayments = _dummyPayments();
    _applyFilters();
  }

  // Dummy data based on the image
  List<Payment> _dummyPayments() {
    return [
      Payment(
        title: 'Neurolytix Initial consul...',
        paymentType: PaymentType.contract,
        estimatedDate: DateTime(2025, 4, 20),
        amount: 256,
        paymentNetwork: PaymentNetwork.ethereum,
        currency: 'USDT',
        status: PaymentStatus.upcoming,
        icon: AppIcons.invoice, // Example icon
        iconBackgroundColor: Colors.deepOrange, // Example color
      ),
      Payment(
        title: 'MintForge Bug fixes an...',
        paymentType: PaymentType.invoice,
        paymentNetwork: PaymentNetwork.starknet,
        estimatedDate: DateTime(2025, 4, 20),
        amount: 65,
        currency: 'USDT',
        status: PaymentStatus.upcoming,
        icon: AppIcons.money, // Example icon
        iconBackgroundColor: Colors.deepPurple, // Example color
      ),
      Payment(
        title: 'ShopLink Pro UX Audit f...',
        paymentType: PaymentType.contract,
        paymentNetwork: PaymentNetwork.solana,
        estimatedDate: DateTime(2025, 4, 20),
        amount: 72,
        currency: 'USDT',
        status: PaymentStatus.overdue,
        icon: AppIcons.invoice, // Example icon
        iconBackgroundColor: Colors.deepOrange, // Example color
      ),
      Payment(
        title: 'Brightfolk Payment for c...',
        paymentType: PaymentType.invoice,
        paymentNetwork: PaymentNetwork.ethereum,
        estimatedDate: DateTime(2025, 4, 20),
        amount: 50,
        currency: 'EURt',
        status: PaymentStatus.overdue,
        icon: AppIcons.money, // Example icon
        iconBackgroundColor: Colors.deepPurple, // Example color
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final textTheme = context.theme.textTheme;
    return DefaultTextStyle(
      style: TextStyle(fontFamily: 'Inter'),
      child: Scaffold(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40), // Increased top spacing
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back_ios, color: colors.textPrimary),
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                  ),
                  const SizedBox(width: 24),
                  Text(
                    'Upcoming Payments',
                    style: textTheme.headlineLarge?.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12), // Increased spacing after header
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 8,
                      child: Container(
                        decoration: BoxDecoration(
                          color: colors.bgB0,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search payments...',
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(14)),
                            filled: true,
                            fillColor: colors.bgB0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          color: colors.bgB0,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: colors.bgB0.withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: IconButton(
                          onPressed: () {
                            _showFilterSheet(context);
                          },
                          icon: const Icon(Icons.filter_list),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _filteredPayments.length,
                  itemBuilder: (context, index) {
                    final payment = _filteredPayments[index];
                    return InkWell(
                      onTap: () {
                        // Navigate to InvoiceScreen and pass the payment object
                        context.pushNamed(RouteConstants.invoice,
                            extra: payment);
                      },
                      child: PaymentItemCard(payment: payment),
                    );
                  },
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }

  void _showFilterSheet(BuildContext context) async {
    final selectedFilters = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints.loose(
        Size(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height * 0.9),
      ),
      builder: (context) => PaymentFilterSheet(),
    );

    if (selectedFilters != null) {
      setState(() {
        _currentTransactionFilter = selectedFilters['transactionType'];
        _currentStatusFilter = selectedFilters['status'];
        _applyFilters();
      });
    }
  }

  void _applyFilters() {
    _filteredPayments = _allPayments.where((payment) {
      final transactionMatch =
          _currentTransactionFilter == FilterTransactionType.all ||
              payment.paymentType.name == _currentTransactionFilter.name;

      final statusMatch = _currentStatusFilter == FilterStatus.all ||
          payment.status.name == _currentStatusFilter.name;

      return transactionMatch && statusMatch;
    }).toList();
  }
}
