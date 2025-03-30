import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:defifundr_mobile/core/constants/fonts.dart';
import 'package:defifundr_mobile/core/themes/color_scheme.dart';

class PaymentDetailsScreen extends StatefulWidget {
  const PaymentDetailsScreen({Key? key}) : super(key: key);

  @override
  State<PaymentDetailsScreen> createState() => _PaymentDetailsScreenState();
}

class _PaymentDetailsScreenState extends State<PaymentDetailsScreen> {
  String selectedCurrency = '';
  String selectedCurrencyIcon = '';
  String selectedPaymentFrequency = 'Payment Frequency';
  String selectedStartDate = 'Start Date';
  String selectedEndDate = 'End Date';
  String selectedNoticePeriod = 'Notice Period';
  int currentStep = 2;
  int totalSteps = 4;

  final List<Map<String, dynamic>> currencies = [
    {'code': 'EUR', 'symbol': '€', 'name': 'Euro', 'icon': '🇪🇺'},
    {'code': 'GBP', 'symbol': '£', 'name': 'British Pound', 'icon': '🇬🇧'},
    {'code': 'USD', 'symbol': '\$', 'name': 'US Dollar', 'icon': '🇺🇸'},
    {'code': 'NGN', 'symbol': '₦', 'name': 'Nigerian Naira', 'icon': '🇳🇬'},
    {
      'code': 'CAD',
      'symbol': 'CA\$',
      'name': 'Canadian Dollar',
      'icon': '🇨🇦'
    },
    {'code': 'JPY', 'symbol': '¥', 'name': 'Japanese Yen', 'icon': '🇯🇵'},
  ];

  final List<String> paymentFrequencies = [
    'Weekly',
    'Bi-weekly',
    'Monthly',
    'Quarterly'
  ];

  final List<String> noticePeriods = [
    '1 Week',
    '2 Weeks',
    '1 Month',
    '3 Months'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              _buildHeader(),
              const SizedBox(height: 16),
              _buildTitle(),
              const SizedBox(height: 24),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCurrencySection(),
                      const SizedBox(height: 24),
                      _buildInvoiceCycleSection(),
                      const SizedBox(height: 24),
                      _buildDatesSection(),
                      const SizedBox(height: 24),
                      _buildNoticePeriodSection(),
                    ],
                  ),
                ),
              ),
              _buildContinueButton(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    double percentage = (currentStep / totalSteps) * 100;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => Navigator.pop(context),
          child: Image.asset(
            'assets/images/back.png',
            height: 24,
            width: 24,
          ),
        ),
        Row(
          children: [
            const SizedBox(width: 8),
            SizedBox(
              height: 20,
              width: 20,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircularProgressIndicator(
                    value: currentStep / totalSteps,
                    backgroundColor: AppColors.greyD7DD,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.black),
                    strokeWidth: 3,
                  ),
                  Text(
                    '${percentage.toInt()}%',
                    style: GoogleFonts.hankenGrotesk(
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 7,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Details',
          style: DefiFundrFonts.h2(context)
              .copyWith(fontSize: 26, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Text(
          'Create a Fixed Rate contract for individual contractors for your company',
          style: GoogleFonts.hankenGrotesk(
            textStyle: DefiFundrFonts.h2(context).copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: const Color(0xff505780),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCurrencySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSelectField(
          leading: selectedCurrencyIcon.isNotEmpty
              ? Text(selectedCurrencyIcon, style: const TextStyle(fontSize: 24, color:  Color(0xffA6B7D4),
              ))
              : null,
          value: selectedCurrency,
          label: 'Select Stable Coin/Fiat Currency',
          onTap: () => _showCurrencyBottomSheet(isCurrencySelector: true),
        ),
        const SizedBox(height: 16),
        _buildSelectField(
          leading: selectedCurrencyIcon.isNotEmpty
              ? Text(selectedCurrencyIcon, style: const TextStyle(fontSize: 24, color: Color(0xffA6B7D4),))
              : null,
          value: selectedCurrency,
          label: 'Payment Rate',
          onTap: () => _showCurrencyBottomSheet(isCurrencySelector: false),
        ),
      ],
    );
  }

  Widget _buildInvoiceCycleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Invoice Cycle',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 16),
        _buildSelectField(
          leading: Image.asset('assets/images/freq.png'),
          label: selectedPaymentFrequency,
          onTap: () => _showOptionsBottomSheet(
            title: 'Select Payment Frequency',
            options: paymentFrequencies,
            onSelect: (value) {
              setState(() {
                selectedPaymentFrequency = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDatesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Dates',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 16),
        _buildSelectField(
          leading: const Icon(Icons.calendar_month_outlined),
          label: selectedStartDate,
          onTap: () => _selectDate(isStartDate: true),
        ),
        const SizedBox(height: 16),
        _buildSelectField(
          leading: const Icon(Icons.calendar_month_outlined),
          label: selectedEndDate,
          onTap: () => _selectDate(isStartDate: false),
        ),
      ],
    );
  }

  Widget _buildNoticePeriodSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Notice Cycle',
          style: GoogleFonts.hankenGrotesk(
            textStyle: const TextStyle(
              color: Color(0xff000000),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 16),
        _buildSelectField(
          leading: const Icon(Icons.hourglass_empty, color: Color(0xff505780)),
          label: selectedNoticePeriod,
          onTap: () => _showOptionsBottomSheet(
            title: 'Select Notice Period',
            options: noticePeriods,
            onSelect: (value) {
              setState(() {
                selectedNoticePeriod = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildContinueButton() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 16),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            if (currentStep < totalSteps) {
              currentStep++;
            }
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          'Continue',
          style: GoogleFonts.hankenGrotesk(
            textStyle: const TextStyle(
              color: Color(0xffFFFFFF),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectField({
    Widget? leading,
    required String label,
    String value = '',
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            if (leading != null) ...[
              leading,
              const SizedBox(width: 12),
            ],
            if (value.isNotEmpty) ...[
              Text(
                value,
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.hankenGrotesk(
                  textStyle: TextStyle(
                    color: const Color(0xffA6B7D4),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down,
              color: Colors.grey.shade600,
            ),
          ],
        ),
      ),
    );
  }

  void _showCurrencyBottomSheet({required bool isCurrencySelector}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        expand: false,
        builder: (_, scrollController) => Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 8),
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                isCurrencySelector
                    ? "Select Currency"
                    : "Select Payment Rate Currency",
                style: GoogleFonts.hankenGrotesk(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: currencies.length,
                itemBuilder: (context, index) {
                  final currency = currencies[index];
                  return ListTile(
                    onTap: () {
                      setState(() {
                        selectedCurrency = currency['symbol'] ?? '';
                        selectedCurrencyIcon = currency['icon'] ?? '';
                      });
                      Navigator.pop(context);
                    },
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          currency['icon'] ?? '',
                          style: const TextStyle(fontSize: 24),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          currency['symbol'] ?? '',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    title: Text(currency['code'] ?? ''),
                    subtitle: Text(currency['name'] ?? ''),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showOptionsBottomSheet({
    required String title,
    required List<String> options,
    required Function(String) onSelect,
  }) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 8),
            height: 4,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              title,
              style: GoogleFonts.hankenGrotesk(
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: options.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(options[index]),
                  onTap: () {
                    onSelect(options[index]);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate({required bool isStartDate}) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          selectedStartDate = "${picked.toLocal()}".split(' ')[0];
        } else {
          selectedEndDate = "${picked.toLocal()}".split(' ')[0];
        }
      });
    }
  }
}
