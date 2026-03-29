import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/routers/routers.dart'
    show CreateInvoiceFlowRoute;
import 'package:defifundr_mobile/core/shared/common/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/components/search_and_filter_bar.dart';
import 'package:defifundr_mobile/modules/invoice/presentation/tabs/contract_invoices_tab.dart';
import 'package:defifundr_mobile/modules/invoice/presentation/tabs/manual_invoices_tab.dart';
import 'package:defifundr_mobile/modules/invoice/presentation/widgets/filter_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: SearchAndFilterBar(
              searchController: _searchController,
              onFilterTap: _showFilterBottomSheet,
            ),
          ),
          _buildTabBarView(),
          Container(
            padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: MediaQuery.of(context).padding.bottom),
            child: PrimaryButton(
              text: 'Create an invoice',
              onPressed: _navigateToCreateInvoice,
            ),
          ),
        ],
      ),
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
          fontWeight: FontWeight.w400,
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

  Widget _buildTabBarView() {
    return Expanded(
      child: TabBarView(
        controller: _tabController,
        children: const [
          ManualInvoicesTab(),
          ContractInvoicesTab(),
        ],
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

  void _navigateToCreateInvoice() {
    context.router.push(const CreateInvoiceFlowRoute());
  }
}
