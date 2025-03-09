import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoleDetails extends StatefulWidget {
  const RoleDetails({Key? key}) : super(key: key);

  @override
  State<RoleDetails> createState() => _RoleDetailsState();
}

class _RoleDetailsState extends State<RoleDetails> {
  bool showCurrencyList = false;
  String selectedCurrency = '';
  String selectedStartDate = 'Start Date';
  String selectedEndDate = 'End Date';
  //track user input for progress
  int currentStep = 2;
  int totalSteps = 4;

  Widget trackProgress() {
    double percentage = (currentStep / totalSteps) * 100;

    return Row(
      children: [
        // Text(
        //   'Step $currentStep of $totalSteps',
        //   style: GoogleFonts.hankenGrotesk(
        //     textStyle: TextStyle(
        //       color: Color(0xff505780),
        //       fontSize: 12,
        //       fontWeight: FontWeight.w500,
        //     ),
        //   ),
        // ),
        SizedBox(width: 8),
        SizedBox(
          height: 30,
          width: 30,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Circular progress indicator
              CircularProgressIndicator(
                value: currentStep / totalSteps,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                strokeWidth: 5,
              ),
              // Percentage text
              Text(
                '${percentage.toInt()}%',
                style: GoogleFonts.hankenGrotesk(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  currencySearch() {
    return showCurrencyPicker(
      context: context,
      showFlag: true,
      showCurrencyName: true,
      showCurrencyCode: true,
      showSearchField: true,
      searchHint: 'search currency',
      currencyFilter: <String>[
        'EUR',
        'GBP',
        'USD',
        'NGN',
        'CAD',
        'JPY',
      ],
      onSelect: (Currency currency) {
        print('Select currency: ${currency.symbol}');
        setState(() {
          selectedCurrency = currency.symbol;
        });
      },
    );
  }

  Future<void> selectStartDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        selectedStartDate = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> selectEndDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        selectedEndDate = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildPaymentDetailsForm(),
    );
  }

  Widget buildPaymentDetailsForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 80,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {},
                child: Image(
                  height: 24,
                  width: 24,
                  image: AssetImage('assets/images/back.png'),
                ),
              ),
              trackProgress(),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Payment Details',
            style: GoogleFonts.hankenGrotesk(
              textStyle: TextStyle(
                color: Color(0xff16192C),
                fontSize: 26,
                letterSpacing: 0.0,
                height: 33.8 / 26,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Create a Fixed Rate contract for individual contractors for your \ncompany',
            style: GoogleFonts.hankenGrotesk(
              textStyle: TextStyle(
                color: Color(0xff505780),
                fontSize: 12,
                letterSpacing: 0.0,
                height: 18 / 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 24),
          currencySelectField(
            subText: selectedCurrency,
            text: 'Select Stable Coin/Fiat Currency',
            onTap: () {
              setState(() {
                currencySearch();
              });
            },
          ),
          const SizedBox(height: 16),
          currencySelectField(
            subText: selectedCurrency,
            text: 'Payment Rate',
            onTap: () {
              setState(() {
                currencySearch();
              });
            },
          ),
          const SizedBox(height: 16),
          const Text(
            'Invoice Cycle',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          buildSelectField(
            svg: Image.asset('assets/images/freq.png'),
            text: 'Payment Frequency',
            iconColor: Colors.purple,
          ),
          const SizedBox(height: 24),
          const Text(
            'Dates',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          buildSelectField(
            icon: Icons.calendar_month_outlined,
            text: selectedStartDate,
            onTap: () => selectStartDate(context),
          ),
          const SizedBox(height: 16),
          buildSelectField(
            icon: Icons.calendar_month_outlined,
            text: selectedEndDate,
            onTap: () => selectEndDate(context),
          ),
          const SizedBox(height: 24),
          Text(
            'Invoice Cycle',
            style: GoogleFonts.hankenGrotesk(
              textStyle: TextStyle(
                color: Color(0xff000000),
                fontSize: 14,
                letterSpacing: 0.0,
                height: 19.6 / 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 16),
          buildSelectField(
            icon: Icons.hourglass_empty,
            text: 'Notice Period',
            iconColor: Color(0xff505780),
          ),
          const Spacer(),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 16),
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
                  textStyle: TextStyle(
                    color: Color(0xffFFFFFF),
                    fontSize: 14,
                    letterSpacing: 0.0,
                    height: 15.4 / 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  Widget buildSelectField({
    IconData? icon,
    Image? svg,
    required String text,
    Color? iconColor,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                color: iconColor,
              ),
              const SizedBox(width: 8),
            ],
            if (svg != null) ...[
              svg,
              const SizedBox(width: 8),
            ],
            const SizedBox(width: 16),
            Text(
              text,
              style: GoogleFonts.hankenGrotesk(
                textStyle: TextStyle(
                  color: Color(0xffA6B7D4),
                  fontSize: 14,
                  letterSpacing: 0.0,
                  height: 16.8 / 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Spacer(),
            Icon(
              Icons.keyboard_arrow_down,
              color: Color(0xff000000),
            ),
          ],
        ),
      ),
    );
  }

  Widget currencySelectField({
    required String text,
    required String subText,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Text(
              subText,
              style: TextStyle(
                color: Colors.blue,
                fontSize: 20,
              ),
            ),
            const SizedBox(width: 16),
            Text(
              text,
              style: GoogleFonts.hankenGrotesk(
                textStyle: TextStyle(
                  color: Color(0xffA6B7D4),
                  fontSize: 14,
                  letterSpacing: 0.0,
                  height: 16.8 / 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Spacer(),
            Icon(
              Icons.keyboard_arrow_down,
              color: Colors.grey.shade600,
            ),
          ],
        ),
      ),
    );
  }
}
