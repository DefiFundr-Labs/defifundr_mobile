import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/routers/routers.dart'
    show InvoiceCompleteRoute;
import 'package:defifundr_mobile/core/shared/common/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/common/stepper/stepper.dart';
import 'package:defifundr_mobile/modules/finance/data/model/assets.dart';
import 'package:defifundr_mobile/modules/finance/data/model/network.dart';
import 'package:defifundr_mobile/modules/invoice/data/models/invoice_models.dart';
import 'package:defifundr_mobile/modules/invoice/presentation/screens/create_invoice_flow/steps/client_details_step.dart';
import 'package:defifundr_mobile/modules/invoice/presentation/screens/create_invoice_flow/steps/invoice_details_step.dart';
import 'package:defifundr_mobile/modules/invoice/presentation/screens/create_invoice_flow/steps/review_sign_step.dart';
import 'package:defifundr_mobile/modules/invoice/presentation/screens/create_invoice_flow/steps/your_details_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class CreateInvoiceFlowScreen extends StatefulWidget {
  const CreateInvoiceFlowScreen({Key? key}) : super(key: key);

  @override
  State<CreateInvoiceFlowScreen> createState() =>
      _CreateInvoiceFlowScreenState();
}

class _CreateInvoiceFlowScreenState extends State<CreateInvoiceFlowScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  String _userDialCode = '+234';
  String _userFlagEmoji = '🇳🇬';
  bool _isUserRegisteredBusiness = false;
  final TextEditingController _userCountryController = TextEditingController();
  final TextEditingController _userFirstNameController =
      TextEditingController();
  final TextEditingController _userBusinessNameController =
      TextEditingController();
  final TextEditingController _userLastNameController = TextEditingController();
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _userPhoneController = TextEditingController();
  final TextEditingController _userTaxIdController = TextEditingController();
  final TextEditingController _userStreetController = TextEditingController();
  final TextEditingController _userCityController = TextEditingController();
  final TextEditingController _userPostalCodeController =
      TextEditingController();

  bool _isNewClient = true;
  bool _isClientRegisteredBusiness = true;
  String _clientDialCode = '+234';
  String _clientFlagEmoji = '🇳🇬';
  String? _selectedClientId;
  final TextEditingController _clientCompanyController =
      TextEditingController();
  final TextEditingController _clientFirstNameController =
      TextEditingController();
  final TextEditingController _clientLastNameController =
      TextEditingController();
  final TextEditingController _clientEmailController = TextEditingController();
  final TextEditingController _clientPhoneController = TextEditingController();
  final TextEditingController _clientCountryController =
      TextEditingController();
  final TextEditingController _clientStreetController = TextEditingController();
  final TextEditingController _clientCityController = TextEditingController();
  final TextEditingController _clientPostalCodeController =
      TextEditingController();

  List<InvoiceItem> _invoiceItems = [
    const InvoiceItem(
        name: 'User Flow & Wireframe Design', quantity: 100, price: 5.0),
    const InvoiceItem(
        name: 'User Flow & Wireframe Design', quantity: 100, price: 5.0),
  ];
  bool _addInclusiveTax = false;
  final TextEditingController _invoiceTitleController = TextEditingController();
  Network? _selectedNetwork;
  NetworkAsset? _selectedAsset;
  final TextEditingController _issueDateController = TextEditingController();
  final TextEditingController _dueDateController = TextEditingController();
  final TextEditingController _paymentMemoController = TextEditingController();

  @override
  void dispose() {
    _pageController.dispose();

    _userCountryController.dispose();
    _userFirstNameController.dispose();
    _userBusinessNameController.dispose();
    _userLastNameController.dispose();
    _userEmailController.dispose();
    _userPhoneController.dispose();
    _userTaxIdController.dispose();
    _userStreetController.dispose();
    _userCityController.dispose();
    _userPostalCodeController.dispose();

    _clientCompanyController.dispose();
    _clientFirstNameController.dispose();
    _clientLastNameController.dispose();
    _clientEmailController.dispose();
    _clientPhoneController.dispose();
    _clientCountryController.dispose();
    _clientStreetController.dispose();
    _clientCityController.dispose();
    _clientPostalCodeController.dispose();

    _invoiceTitleController.dispose();
    _issueDateController.dispose();
    _dueDateController.dispose();
    _paymentMemoController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(context.screenWidth(), 60),
        child: DeFiRaiseAppBar(
          centerTitle: true,
          textStyle: context.theme.fonts.heading3SemiBold,
          isBack: true,
          title: getTitle(),
          onBack: _previousStep,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AnimatedStepProgress(
                currentStep: _currentStep + 1,
                totalSteps: 4,
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
          YourDetailsStep(
            isRegisteredBusiness: _isUserRegisteredBusiness,
            onBusinessToggled: (val) =>
                setState(() => _isUserRegisteredBusiness = val),
            countryController: _userCountryController,
            firstNameController: _userFirstNameController,
            businessNameController: _userBusinessNameController,
            lastNameController: _userLastNameController,
            emailController: _userEmailController,
            phoneController: _userPhoneController,
            taxIdController: _userTaxIdController,
            streetController: _userStreetController,
            cityController: _userCityController,
            postalCodeController: _userPostalCodeController,
            dialCode: _userDialCode,
            flagEmoji: _userFlagEmoji,
            onDialCodeChanged: (code, flag) => setState(() {
              _userDialCode = code;
              _userFlagEmoji = flag;
            }),
            onNext: _nextStep,
            onBack: () => context.router.maybePop(),
          ),
          ClientDetailsStep(
            isNewClient: _isNewClient,
            isBusiness: _isClientRegisteredBusiness,
            firstNameController: _clientFirstNameController,
            lastNameController: _clientLastNameController,
            businessNameController: _clientCompanyController,
            emailController: _clientEmailController,
            phoneController: _clientPhoneController,
            countryController: _clientCountryController,
            streetController: _clientStreetController,
            cityController: _clientCityController,
            zipController: _clientPostalCodeController,
            dialCode: _clientDialCode,
            flagEmoji: _clientFlagEmoji,
            selectedClientId: _selectedClientId,
            onNewClientChanged: (val) => setState(() => _isNewClient = val),
            onBusinessChanged: (val) =>
                setState(() => _isClientRegisteredBusiness = val),
            onDialCodeChanged: (code, flag) => setState(() {
              _clientDialCode = code;
              _clientFlagEmoji = flag;
            }),
            onClientSelected: (id) => setState(() => _selectedClientId = id),
            onNext: _nextStep,
          ),
          InvoiceDetailsStep(
            items: _invoiceItems,
            onItemAdded: (item) => setState(() => _invoiceItems.add(item)),
            onItemEdited: (index, updated) =>
                setState(() => _invoiceItems[index] = updated),
            onItemDeleted: (index) =>
                setState(() => _invoiceItems.removeAt(index)),
            addInclusiveTax: _addInclusiveTax,
            onTaxToggled: (val) => setState(() => _addInclusiveTax = val),
            invoiceTitleController: _invoiceTitleController,
            selectedNetwork: _selectedNetwork,
            selectedAsset: _selectedAsset,
            onNetworkChanged: (val) => setState(() => _selectedNetwork = val),
            onAssetChanged: (val) => setState(() => _selectedAsset = val),
            issueDateController: _issueDateController,
            dueDateController: _dueDateController,
            paymentMemoController: _paymentMemoController,
            onNext: _nextStep,
            onBack: _previousStep,
          ),
          ReviewSignStep(
            data: _getInvoiceData(),
            onEdit: (index) {
              setState(() {
                _currentStep = index;
              });
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            onBack: _previousStep,
            onComplete: _completeInvoice,
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> _getInvoiceData() {
    return {
      'yourFirstName': _userFirstNameController.text,
      'yourLastName': _userLastNameController.text,
      'yourEmail': _userEmailController.text,
      'yourPhone': _userPhoneController.text,
      'yourCountry': _userCountryController.text,
      'yourAddress':
          '${_userStreetController.text}, ${_userCityController.text} | ${_userPostalCodeController.text}',
      'clientName': _isNewClient
          ? (_isClientRegisteredBusiness
              ? _clientCompanyController.text
              : '${_clientFirstNameController.text} ${_clientLastNameController.text}')
          : 'Saved Client',
      'clientEmail': _clientEmailController.text,
      'clientPhone': _clientPhoneController.text,
      'clientCountry': _clientCountryController.text,
      'clientAddress':
          '${_clientStreetController.text}, ${_clientCityController.text} | ${_clientPostalCodeController.text}',
      'invoiceTitle': _invoiceTitleController.text,
      'network': _selectedNetwork?.name,
      'asset': _selectedAsset?.name,
      'issueDate': _issueDateController.text,
      'dueDate': _dueDateController.text,
      'paymentMemo': _paymentMemoController.text,
    };
  }

  String getTitle() {
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

  void _nextStep() {
    if (_currentStep < 3) {
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

  void _completeInvoice() {
    final invoiceData = InvoiceData();
    context.router.push(InvoiceCompleteRoute(invoiceData: invoiceData));
  }
}
