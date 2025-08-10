import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/enums/app_text_field_enums.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/shared/common_ui/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/common_ui/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/common_ui/textfield/app_text_field.dart';
import 'package:defifundr_mobile/modules/invoice/data/models/app_%20constants.dart';
import 'package:defifundr_mobile/modules/invoice/data/models/invoice_models.dart';
import 'package:defifundr_mobile/modules/invoice/presentation/screens/create_invoice_flow_screen.dart';
import 'package:defifundr_mobile/modules/quickpay/invoice_detail_screen.dart';
import 'package:defifundr_mobile/modules/invoice/presentation/widgets/common/empty_state.dart';
import 'package:defifundr_mobile/modules/invoice/presentation/widgets/filter_bottom_sheet.dart';
import 'package:defifundr_mobile/modules/invoice/presentation/widgets/invoice_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class InvoicesScreen extends StatefulWidget {
  const InvoicesScreen({Key? key}) : super(key: key);

  @override
  State<InvoicesScreen> createState() => _InvoicesScreenState();
}

class _InvoicesScreenState extends State<InvoicesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
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
          title: 'Invoices',
          actions: [],
        ),
      ),
      body: Column(
        children: [
          _buildTabBar(),
          _buildSearchBar(),
          _buildTabBarView(),
        ],
      ),
      bottomNavigationBar: _buildCreateInvoiceButton(),
    );
  }

  Widget _buildTabBar() {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final bool isTablet = MediaQuery.of(context).size.shortestSide >= 600;

    final double fontSize = isTablet ? 12.sp : 14.sp;

    final double indicatorWeight = isTablet ? 5 : 3;

    final EdgeInsets padding = isTablet
        ? EdgeInsets.symmetric(horizontal: isLandscape ? 24 : 16)
        : const EdgeInsets.symmetric(horizontal: 8);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TabBar(
        controller: _tabController,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorWeight: indicatorWeight,
        dividerColor: context.theme.colors.strokeSecondary.withAlpha(20),
        labelPadding: padding,
        tabAlignment: TabAlignment.start,
        isScrollable: true,
        labelColor: context.theme.colors.brandContrast,
        unselectedLabelColor: context.theme.colors.textSecondary,
        indicatorColor: context.theme.colors.brandContrast,
        labelStyle: context.theme.fonts.textMdRegular.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: fontSize,
          color: context.theme.colors.brandContrast,
        ),
        unselectedLabelStyle: context.theme.fonts.textMdRegular.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: fontSize,
          color: context.theme.colors.brandContrast,
        ),
        tabs: const [
          Tab(text: 'Manual Invoices'),
          Tab(text: 'Contract Invoices'),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: AppTextField(
              controller: _searchController,
              validate: false,
              alwaysShowLabelAndHint: true,
              hintText: "Search",
              prefixType: PrefixType.customIcon,
              prefixIcon: SvgPicture.asset(
                Assets.icons.magnifyingGlass,
                width: 20,
                height: 20,
                color: context.theme.colors.textSecondary,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: _showFilterBottomSheet,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isLight
                    ? context.theme.colors.bgB0
                    : context.theme.colors.bgB1,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: context.theme.colors.strokeSecondary.withAlpha(20),
                ),
              ),
              child: SvgPicture.asset(
                Assets.icons.filter,
                width: 20,
                height: 20,
                color: context.theme.colors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBarView() {
    return Expanded(
      child: TabBarView(
        controller: _tabController,
        children: [
          _buildInvoicesList(AppConstants.sampleManualInvoices),
          _buildInvoicesList(AppConstants.sampleContractInvoices),
        ],
      ),
    );
  }

  Widget _buildInvoicesList(List<Invoice> invoices) {
    if (invoices.isEmpty) {
      return const EmptyState(
        icon: Icons.description_outlined,
        title: 'No invoices yet.',
        subtitle:
            'Once you create or receive one, you\'ll see it listed\nhere.',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: invoices.length,
      itemBuilder: (context, index) {
        return InvoiceCard(
          invoice: invoices[index],
          onTap: () => _navigateToInvoiceDetail(invoices[index]),
        );
      },
    );
  }

  Widget _buildCreateInvoiceButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      child: PrimaryButton(
        text: 'Create an invoice',
        onPressed: _navigateToCreateInvoice,
      ),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const FilterBottomSheet(),
    );
  }

  void _navigateToInvoiceDetail(Invoice invoice) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InvoiceDetailScreen(invoice: invoice),
      ),
    );
  }

  void _navigateToCreateInvoice() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateInvoiceFlowScreen(),
      ),
    );
  }
}
