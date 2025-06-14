import 'dart:ui';

import 'package:defifundr_mobile/core/constants/app_icons.dart';
import 'package:defifundr_mobile/core/design_system/color_extension/app_color_extension.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/routers/routes_constant.dart';
import 'package:defifundr_mobile/core/shared/appbar/appbar.dart';
import 'package:defifundr_mobile/feature/payment_screens/payment_filter_sheet.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/payment.dart';
import '../widgets/payment_item_card.dart';

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

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _applyFilters();
    });
  }

  List<Payment> _createDummyPayments(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorExtension>()!;
    return [
      Payment(
        title: 'Neurolytix Initial consul...',
        paymentType: PaymentType.contract,
        estimatedDate: DateTime(2025, 4, 20),
        amount: 256,
        paymentNetwork: PaymentNetwork.ethereum,
        currency: 'USDT',
        status: PaymentStatus.upcoming,
        icon: AppIcons.invoice,
        iconBackgroundColor: colors.orangeDefault,
      ),
      Payment(
        title: 'MintForge Bug fixes an...',
        paymentType: PaymentType.invoice,
        paymentNetwork: PaymentNetwork.starknet,
        estimatedDate: DateTime(2025, 4, 20),
        amount: 65,
        currency: 'USDT',
        status: PaymentStatus.upcoming,
        icon: AppIcons.money,
        iconBackgroundColor: colors.brandDefault,
      ),
      Payment(
        title: 'ShopLink Pro UX Audit f...',
        paymentType: PaymentType.contract,
        paymentNetwork: PaymentNetwork.solana,
        estimatedDate: DateTime(2025, 4, 20),
        amount: 72,
        currency: 'USDT',
        status: PaymentStatus.overdue,
        icon: AppIcons.invoice,
        iconBackgroundColor: colors.orangeDefault,
      ),
      Payment(
        title: 'Brightfolk Payment for c...',
        paymentType: PaymentType.invoice,
        paymentNetwork: PaymentNetwork.ethereum,
        estimatedDate: DateTime(2025, 4, 20),
        amount: 50,
        currency: 'EURt',
        status: PaymentStatus.overdue,
        icon: AppIcons.money,
        iconBackgroundColor: colors.brandDefault,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final textTheme = context.theme.textTheme;

    // Initialize payments if empty
    if (_allPayments.isEmpty) {
      _allPayments = _createDummyPayments(context);
      _applyFilters();
    }

    return DefaultTextStyle(
      style: TextStyle(fontFamily: 'Inter'),
      child: Scaffold(
        backgroundColor: colors.bgB0,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40), // Increased top spacing
              SizedBox(height: 16),
              DeFiRaiseAppBar(
                title: 'Upcoming Payments',
                isBack: true,
              ),
              SizedBox(height: 16),
              const SizedBox(height: 12), // Increased spacing after header
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 8,
                      child: Container(
                        decoration: BoxDecoration(
                          color: colors.bgB1,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Search',
                            hintStyle: TextStyle(fontSize: 16.0),
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(14)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(14)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(14)),
                            filled: true,
                            fillColor: colors.bgB1,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          color: colors.bgB1,
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
            MediaQuery.of(context).size.height * 0.60),
      ),
      backgroundColor: Colors.transparent,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context)
                .extension<AppColorExtension>()!
                .bgB0
                .withOpacity(0.8),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: PaymentFilterSheet(),
        ),
      ),
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
    final searchQuery = _searchController.text.toLowerCase();
    _filteredPayments = _allPayments.where((payment) {
      // Check if the search query matches any relevant parameter
      final titleMatch = payment.title.toLowerCase().contains(searchQuery);
      final typeMatch =
          payment.paymentType.name.toLowerCase().contains(searchQuery);
      final networkMatch =
          payment.paymentNetwork.name.toLowerCase().contains(searchQuery);
      final currencyMatch =
          payment.currency.toLowerCase().contains(searchQuery);
      final statusSearchMatch =
          payment.status.name.toLowerCase().contains(searchQuery);

      final transactionMatch =
          _currentTransactionFilter == FilterTransactionType.all ||
              payment.paymentType.name == _currentTransactionFilter.name;

      final statusMatch = _currentStatusFilter == FilterStatus.all ||
          payment.status.name == _currentStatusFilter.name;

      // Combine search match with filter selections
      final searchMatch = titleMatch ||
          typeMatch ||
          networkMatch ||
          currencyMatch ||
          statusSearchMatch;

      return searchMatch && transactionMatch && statusMatch;
    }).toList();
  }
}
