import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/common/stepper/stepper.dart';
import 'package:defifundr_mobile/modules/time_tracking/data/models/contract.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/screens/create_contract_flow/steps/contract_type_step.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/screens/create_contract_flow/steps/contract_details_step.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/screens/create_contract_flow/steps/client_details_step.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/screens/create_contract_flow/steps/contract_dates_step.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/screens/create_contract_flow/steps/payment_invoice_step.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/screens/create_contract_flow/steps/compliance_step.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/screens/create_contract_flow/steps/review_sign_step.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/screens/create_contract_flow/widgets/agreement_bottom_sheet.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/screens/create_contract_flow/widgets/review_sign_bottom_sheet.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/screens/create_contract_flow/widgets/completion_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:defifundr_mobile/modules/finance/data/model/network.dart';
import 'package:defifundr_mobile/modules/finance/data/model/assets.dart';
import 'package:intl/intl.dart';

@RoutePage()
class CreateContractFlowScreen extends StatefulWidget {
  const CreateContractFlowScreen({Key? key}) : super(key: key);

  @override
  State<CreateContractFlowScreen> createState() =>
      _CreateContractFlowScreenState();
}

class _CreateContractFlowScreenState extends State<CreateContractFlowScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  ContractType? _selectedContractType;

  @override
  void initState() {
    super.initState();
    _selectedAsset = NetworkAsset.supportedAssets.firstWhere(
      (a) => a.name == 'USDT',
      orElse: () => NetworkAsset.supportedAssets[0],
    );
  }

  // Step 2 State
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _jobRoleController = TextEditingController();
  final TextEditingController _workScopeTemplateController =
      TextEditingController();
  final TextEditingController _explanationController = TextEditingController();

  // Step 3 State
  bool _isNewClient = true;
  bool _isBusiness = false;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _clientEmailController = TextEditingController();
  final TextEditingController _clientPhoneController = TextEditingController();
  final TextEditingController _clientCountryController =
      TextEditingController();
  final TextEditingController _clientStreetController = TextEditingController();
  final TextEditingController _clientCityController = TextEditingController();
  final TextEditingController _clientZipController = TextEditingController();
  String _clientDialCode = '+234';
  String _clientFlagEmoji = '🇳🇬';
  String? _selectedClientId;

  // Step 4 State
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _noticePeriodController = TextEditingController();

  // Step 5 State
  Network? _selectedNetwork;
  NetworkAsset? _selectedAsset;
  final TextEditingController _paymentAmountController =
      TextEditingController();
  String? _invoiceFrequency;
  String? _issueInvoiceOn;
  String? _issueSecondInvoiceOn;
  String _monthlyInvoiceMode = 'Ends on date';
  String? _paymentDue;
  final TextEditingController _firstInvoiceDateController =
      TextEditingController();
  final TextEditingController _firstInvoiceCustomAmountController =
      TextEditingController();
  String _firstInvoiceAmountType = 'Full amount';
  bool _addInclusiveTax = false;
  String? _taxType;
  final TextEditingController _taxIdController = TextEditingController();
  final TextEditingController _taxRateController = TextEditingController();

  // Step 6 State
  String? _agreementType;
  final TextEditingController _additionalTermsController =
      TextEditingController();

  @override
  void dispose() {
    _pageController.dispose();
    _titleController.dispose();
    _jobRoleController.dispose();
    _workScopeTemplateController.dispose();
    _explanationController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _businessNameController.dispose();
    _clientEmailController.dispose();
    _clientPhoneController.dispose();
    _clientCountryController.dispose();
    _clientStreetController.dispose();
    _clientCityController.dispose();
    _clientZipController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _noticePeriodController.dispose();
    _paymentAmountController.dispose();
    _firstInvoiceDateController.dispose();
    _firstInvoiceCustomAmountController.dispose();
    _taxIdController.dispose();
    _taxRateController.dispose();
    _additionalTermsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String appBarTitle;
    switch (_currentStep) {
      case 0:
        appBarTitle = 'Create a contract';
        break;
      case 1:
        appBarTitle = 'Contract Details';
        break;
      case 2:
        appBarTitle = 'Client Details';
        break;
      case 3:
        appBarTitle = 'Contract Dates';
        break;
      case 4:
        appBarTitle = 'Payment & Invoice';
        break;
      case 5:
        appBarTitle = 'Compliance';
        break;
      case 6:
        appBarTitle = 'Review & Sign';
        break;
      default:
        appBarTitle = 'Create a contract';
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(context.screenWidth(), 60),
        child: DeFiRaiseAppBar(
          centerTitle: true,
          textStyle: context.theme.fonts.heading3SemiBold,
          isBack: true,
          title: appBarTitle,
          onBack: _previousStep,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AnimatedStepProgress(
                currentStep: _currentStep + 1,
                totalSteps: 7,
                size: 36.sp,
              ),
            ),
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ContractTypeStep(
            selectedType: _selectedContractType,
            onTypeChanged: (type) {
              setState(() {
                _selectedContractType = type;
              });
            },
            onNext: _nextStep,
          ),
          ContractDetailsStep(
            titleController: _titleController,
            jobRoleController: _jobRoleController,
            workScopeTemplateController: _workScopeTemplateController,
            explanationController: _explanationController,
            onNext: _nextStep,
          ),
          ClientDetailsStep(
            isNewClient: _isNewClient,
            isBusiness: _isBusiness,
            firstNameController: _firstNameController,
            lastNameController: _lastNameController,
            businessNameController: _businessNameController,
            emailController: _clientEmailController,
            phoneController: _clientPhoneController,
            countryController: _clientCountryController,
            streetController: _clientStreetController,
            cityController: _clientCityController,
            zipController: _clientZipController,
            dialCode: _clientDialCode,
            flagEmoji: _clientFlagEmoji,
            selectedClientId: _selectedClientId,
            onNewClientChanged: (val) => setState(() => _isNewClient = val),
            onBusinessChanged: (val) => setState(() => _isBusiness = val),
            onDialCodeChanged: (code, flag) => setState(() {
              _clientDialCode = code;
              _clientFlagEmoji = flag;
            }),
            onClientSelected: (id) => setState(() => _selectedClientId = id),
            onNext: _nextStep,
          ),
          ContractDatesStep(
            startDateController: _startDateController,
            endDateController: _endDateController,
            noticePeriodController: _noticePeriodController,
            onNext: _nextStep,
          ),
          PaymentInvoiceStep(
            selectedNetwork: _selectedNetwork,
            selectedAsset: _selectedAsset,
            paymentAmountController: _paymentAmountController,
            invoiceFrequency: _invoiceFrequency,
            issueInvoiceOn: _issueInvoiceOn,
            issueSecondInvoiceOn: _issueSecondInvoiceOn,
            monthlyInvoiceMode: _monthlyInvoiceMode,
            paymentDue: _paymentDue,
            firstInvoiceDateController: _firstInvoiceDateController,
            firstInvoiceCustomAmountController:
                _firstInvoiceCustomAmountController,
            firstInvoiceAmountType: _firstInvoiceAmountType,
            addInclusiveTax: _addInclusiveTax,
            taxType: _taxType,
            taxIdController: _taxIdController,
            taxRateController: _taxRateController,
            onNetworkChanged: (Network? val) =>
                setState(() => _selectedNetwork = val),
            onAssetChanged: (NetworkAsset? val) =>
                setState(() => _selectedAsset = val),
            onFrequencyChanged: (val) =>
                setState(() => _invoiceFrequency = val),
            onIssueOnChanged: (val) => setState(() => _issueInvoiceOn = val),
            onIssueSecondOnChanged: (val) =>
                setState(() => _issueSecondInvoiceOn = val),
            onMonthlyModeChanged: (val) =>
                setState(() => _monthlyInvoiceMode = val),
            onPaymentDueChanged: (val) => setState(() => _paymentDue = val),
            onFirstInvoiceTypeChanged: (val) =>
                setState(() => _firstInvoiceAmountType = val),
            onTaxChanged: (val) => setState(() => _addInclusiveTax = val),
            onTaxTypeChanged: (val) => setState(() => _taxType = val),
            onNext: _nextStep,
          ),
          ComplianceStep(
            agreementType: _agreementType,
            additionalTermsController: _additionalTermsController,
            onAgreementTypeChanged: (val) =>
                setState(() => _agreementType = val),
            onNext: _nextStep,
          ),
          ReviewSignStep(
            data: _getContractData(),
            onEdit: (stepIndex) {
              setState(() => _currentStep = stepIndex);
              _pageController.jumpToPage(stepIndex);
            },
            onNext: _navigateToAgreement,
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> _getContractData() {
    return {
      'title': _titleController.text,
      'type': _selectedContractType?.titleCase,
      'jobRole': _jobRoleController.text,
      'workScope': _explanationController.text,
      'clientName': _isNewClient
          ? (_isBusiness
              ? _businessNameController.text
              : '${_firstNameController.text} ${_lastNameController.text}')
          : 'Selected Client',
      'clientEmail': _clientEmailController.text,
      'clientPhone': '$_clientDialCode ${_clientPhoneController.text}',
      'clientCountry': _clientCountryController.text,
      'clientAddress':
          '${_clientStreetController.text}, ${_clientCityController.text}',
      'creationDate': DateFormat('dd MMM yyyy').format(DateTime.now()),
      'startDate': _startDateController.text,
      'endDate': _endDateController.text,
      'noticePeriod': _noticePeriodController.text,
      'networkName': _selectedNetwork?.name,
      'networkIcon': _selectedNetwork?.iconPath,
      'assetName': _selectedAsset?.name,
      'assetIcon': _selectedAsset?.iconPath,
      'amount': _paymentAmountController.text.isEmpty
          ? '0.00'
          : _paymentAmountController.text,
      'frequency': _invoiceFrequency,
      'issueOn': _issueInvoiceOn,
      'due': _paymentDue,
      'firstInvoiceDate': _firstInvoiceDateController.text,
      'firstInvoiceType': _firstInvoiceAmountType,
      'includeTax': _addInclusiveTax,
      'agreementType': _agreementType,
      'additionalTerms': _additionalTermsController.text,
    };
  }

  void _navigateToAgreement() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DesignServicesAgreementBottomSheet(
        onSign: () {
          context.router.maybePop();
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => ReviewSignBottomSheet(
              onSign: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => CompletionBottomSheet(
                    onDone: () {
                      context.router.popUntilRoot();
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _nextStep() {
    if (_currentStep < 6) {
      setState(() {
        _currentStep++;
      });
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      context.router.maybePop();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      context.router.maybePop();
    }
  }
}
