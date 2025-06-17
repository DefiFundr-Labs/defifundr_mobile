import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/enums/create_contract_enum.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/identity_verification/widgets/brand_button.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/multi_factor_authentication_screen/widgets/custom_back_button.dart';
import 'package:defifundr_mobile/feature/fixed_rate_contract_creation/presentation/screens/create_contract_page_view/client_details.dart';
import 'package:defifundr_mobile/feature/fixed_rate_contract_creation/presentation/screens/create_contract_page_view/compliance_screen.dart';
import 'package:defifundr_mobile/feature/fixed_rate_contract_creation/presentation/screens/create_contract_page_view/contract_details_screen.dart';
import 'package:defifundr_mobile/feature/fixed_rate_contract_creation/presentation/screens/create_contract_page_view/payment_and_invoice_screen.dart';
import 'package:defifundr_mobile/feature/fixed_rate_contract_creation/presentation/screens/create_contract_page_view/review_and_sign_screen.dart';
import 'package:defifundr_mobile/feature/fixed_rate_contract_creation/presentation/screens/create_contract_page_view/select_contract_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateContractScreen extends StatefulWidget {
  const CreateContractScreen({super.key});

  @override
  State<CreateContractScreen> createState() => _CreateContractScreenState();
}

class _CreateContractScreenState extends State<CreateContractScreen> {
  late final PageController _pageController;
  int _currentStep = 0;
  final List<CreateContractStep> _steps = CreateContractStep.values;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  //appBar titles
  String get appBarTitle {
    switch (_steps[_currentStep]) {
      case CreateContractStep.selectType:
        return 'Create a contract';
      case CreateContractStep.contractDetails:
        return 'Contract Details';
      case CreateContractStep.clientDetails:
        return 'Client Details';
      case CreateContractStep.contractDates:
        return 'Contract Dates';
      case CreateContractStep.paymentAndInvoice:
        return 'Payment & Invoice';
      case CreateContractStep.compliance:
        return 'Compliance';
      case CreateContractStep.reviewAndSign:
        return 'Review & Sign';
    }
  }

  void nextStep() {
    if (_currentStep < _steps.length - 1) {
      setState(() {
        _currentStep++;
      });
      _pageController.animateToPage(_currentStep,
          duration: Duration(milliseconds: 300), curve: Curves.easeInOutCirc);
    } else {}
  }

  void previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _pageController.animateToPage(_currentStep,
          duration: Duration(milliseconds: 300), curve: Curves.easeInOutCirc);
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: CustomBackButton(
          onTap: previousStep,
        ),
        surfaceTintColor: Colors.transparent,
        backgroundColor: context.theme.scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          appBarTitle,
          style: context.textTheme.headlineLarge?.copyWith(fontSize: 24.sp),
        ),
        actions: [
          StepProgressIndicator(
              currentStep: _currentStep + 1, totalSteps: _steps.length),
        ],
      ),
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          SelectContractTypeScreen(),
          ContractDetailsScreen(),
          ClientDetails(),
          ContractDetailsScreen(),
          PaymentAndInvoiceScreen(),
          ComplianceScreen(),
          ReviewAndSignScreen(),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BrandButton(text: 'Contine', onPressed: nextStep),
      ),
    );
  }
}

class StepProgressIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const StepProgressIndicator({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    final double progress = currentStep / totalSteps;

    return Container(
      width: 30,
      height: 30,
      margin: EdgeInsets.only(right: 20),
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: progress,
            strokeWidth: 5,
            backgroundColor: AppColors.borderColor,
            valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.brandDefaultContrast),
          ),
          RichText(
              text: TextSpan(
                  text: '$currentStep',
                  style: context.theme.fonts.textMdSemiBold
                      .copyWith(color: AppColors.brandDefaultContrast),
                  children: <TextSpan>[
                TextSpan(
                    text: '/$totalSteps',
                    style: context.theme.fonts.textSmRegular
                        .copyWith(color: AppColors.borderGrey))
              ]))
        ],
      ),
    );
  }
}
