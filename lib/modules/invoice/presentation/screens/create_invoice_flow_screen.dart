import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common_ui/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/common_ui/stepper/stepper.dart';
import 'package:defifundr_mobile/modules/invoice/data/models/invoice_models.dart';
import 'package:defifundr_mobile/modules/invoice/presentation/screens/create_invoice_steps.dart';
import 'package:defifundr_mobile/modules/invoice/presentation/screens/invoice_complete_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateInvoiceFlowScreen extends StatefulWidget {
  const CreateInvoiceFlowScreen({Key? key}) : super(key: key);

  @override
  State<CreateInvoiceFlowScreen> createState() =>
      _CreateInvoiceFlowScreenState();
}

class _CreateInvoiceFlowScreenState extends State<CreateInvoiceFlowScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  final InvoiceData _invoiceData = InvoiceData();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(context.screenWidth(), 60),
        child: DeFiRaiseAppBar(
          centerTitle: true,
          textStyle: context.theme.fonts.heading3SemiBold.copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
          isBack: true,
          title: getTitle(),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AnimatedStepProgress(
                currentStep: _currentStep + 1,
                totalSteps: 4,
                size: 40.sp,
              ),
            ),
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          YourDetailsStep(
            invoiceData: _invoiceData,
            onNext: _nextStep,
            onBack: () => Navigator.pop(context),
          ),
          ClientDetailsStep(
            invoiceData: _invoiceData,
            onNext: _nextStep,
            onBack: _previousStep,
          ),
          InvoiceDetailsStep(
            invoiceData: _invoiceData,
            onNext: _nextStep,
            onBack: _previousStep,
          ),
          ReviewSignStep(
            invoiceData: _invoiceData,
            onBack: _previousStep,
            onComplete: _completeInvoice,
          ),
        ],
      ),
    );
  }

  getTitle() {
    switch (_currentStep) {
      case 0:
        return 'Your Details';
      case 1:
        return 'Client Details';
      case 2:
        return 'Invoice Details';
      case 3:
        return 'Review & Sign';
      default:
        return '';
    }
  }

  getStepNumber() {
    switch (_currentStep) {
      case 0:
        return '1/4';
      case 1:
        return '2/4';
      case 2:
        return '3/4';
      case 3:
        return '4/4';
      default:
        return '';
    }
  }

  void _nextStep() {
    if (_currentStep < 3) {
      setState(() {
        _currentStep++;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _completeInvoice() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => InvoiceCompleteScreen(invoiceData: _invoiceData),
      ),
    );
  }
}
