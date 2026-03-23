import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common/appbar/appbar.dart';
import 'package:defifundr_mobile/core/utils/ellipsify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/models/contract.dart';
import '../../../data/models/mock_data.dart';
import '../../../data/models/payment_history.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';
import '../widgets/payment_history_item.dart';

@RoutePage()
class ContractDetailScreen extends StatefulWidget {
  final PayCycleContract contract;

  const ContractDetailScreen({
    Key? key,
    required this.contract,
  }) : super(key: key);

  @override
  State<ContractDetailScreen> createState() => _ContractDetailScreenState();
}

class _ContractDetailScreenState extends State<ContractDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<PaymentHistoryItem> _paymentHistory = [];
  List<Payout> _payouts = [];
  List<Milestone> _milestones = [];

  bool get isMilestone => widget.contract.type == ContractType.milestone;
  bool get isPayAsYouGo => widget.contract.type == ContractType.payAsYouGo;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: (isMilestone || isPayAsYouGo) ? 3 : 2, vsync: this);
    _loadData();
    _tabController.addListener(() {
      setState(() {});
    });
  }

  void _loadData() {
    _paymentHistory = MockData.getPaymentHistory(widget.contract.id);
    _payouts = MockData.getPayouts(widget.contract.id);
    final contract = MockData.getContractById(widget.contract.id);
    _milestones = contract?.milestones ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.colors.bgB1,
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 60),
        child: DeFiRaiseAppBar(
          centerTitle: true,
          textStyle: context.theme.fonts.heading3SemiBold,
          isBack: true,
          title: '',
          actions: const [],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildContractHeader(context),
              const SizedBox(height: 20),
              _buildMainSection(context),
              if (!isMilestone) ...[
                const SizedBox(height: 20),
                _buildHistorySection(context),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContractHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.theme.colors.bgB0,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: context.theme.colors.brandHover,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Center(
              child: Text(
                'QM',
                style: context.theme.fonts.textMdMedium.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ellipsify(word: widget.contract.title, maxLength: 20),
                  style: context.theme.fonts.heading3Bold.copyWith(
                      color: context.theme.colors.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      widget.contract.type.displayName,
                      style: context.theme.fonts.textMdMedium.copyWith(
                        color: context.theme.colors.textSecondary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text('•',
                        style: context.theme.fonts.textMdMedium.copyWith(
                            color: context.theme.colors.textSecondary)),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: context.theme.colors.greenFill,
                        borderRadius: BorderRadius.circular(32),
                        border:
                            Border.all(color: context.theme.colors.greenStroke),
                      ),
                      child: Text(
                        'Active',
                        style: context.theme.fonts.textXsSemiBold.copyWith(
                          color: context.theme.colors.greenDefault,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainSection(BuildContext context) {
    final isDeliverable =
        widget.contract.frequency == PayCycleFrequency.perDeliverable;
    final isDay = widget.contract.frequency == PayCycleFrequency.perDay;
    final isWeek = widget.contract.frequency == PayCycleFrequency.perWeek;

    final sectionTitle = isMilestone
        ? 'Milestones'
        : isPayAsYouGo
            ? (isDeliverable
                ? 'Deliverables'
                : (isDay
                    ? 'Days worked'
                    : (isWeek ? 'Weeks worked' : 'Hours worked')))
            : 'Payouts';
    final sectionDescription = isMilestone
        ? 'Milestones must be completed and approved before an invoice can be generated for payment.'
        : isPayAsYouGo
            ? (isDeliverable
                ? 'Submit your completed deliverable for client approval. It will be invoiced once approved.'
                : (isDay
                    ? 'Submit your days worked for client approval. It will be invoiced once approved.'
                    : (isWeek
                        ? 'Submit your weeks worked for client approval. It will be invoiced once approved.'
                        : 'Submit your hours worked for client approval. It will be invoiced once approved.')))
            : 'Payout request are automatically generated based on the schedule and terms defined in the contract.';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.theme.colors.bgB0,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(sectionTitle, style: context.theme.fonts.textBaseSemiBold),
          const SizedBox(height: 4),
          Text(sectionDescription, style: context.theme.fonts.textSmRegular),
          const SizedBox(height: 20),
          _buildTabBar(context),
          const SizedBox(height: 20),
          _buildTabContent(context),
          if (isMilestone) ...[
            const SizedBox(height: 16),
            PrimaryButton(
              text: 'Add milestone',
              onPressed: () => context.router
                  .push(AddMilestoneRoute(contract: widget.contract)),
              borderRadius: BorderRadius.circular(8.r),
              color: context.theme.colors.grayTertiary.withAlpha(50),
              textColor: context.theme.colors.textPrimary,
            ),
          ],
          if (isPayAsYouGo) ...[
            const SizedBox(height: 16),
            PrimaryButton(
              text: isDeliverable
                  ? 'Submit deliverable'
                  : (isDay
                      ? 'Submit days worked'
                      : (isWeek
                          ? 'Submit weeks worked'
                          : 'Submit hours worked')),
              onPressed: () => context.router
                  .push(PayCycleSubmitHoursRoute(contract: widget.contract)),
              borderRadius: BorderRadius.circular(8.r),
              color: context.theme.colors.grayTertiary.withAlpha(50),
              textColor: context.theme.colors.textPrimary,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    List<Widget> tabs;
    if (isMilestone) {
      final inProgressCount = _milestones
          .where((m) =>
              m.status == PaymentStatus.pendingSubmission ||
              m.status == PaymentStatus.overdue)
          .length;
      final inReviewCount = _milestones
          .where((m) => m.status == PaymentStatus.pendingApproval)
          .length;
      final approvedCount = _milestones
          .where((m) =>
              m.status == PaymentStatus.awaitingPayment ||
              m.status == PaymentStatus.paid)
          .length;

      tabs = [
        Tab(text: 'In progress ($inProgressCount)'),
        Tab(text: 'In review ($inReviewCount)'),
        Tab(text: 'Approved ($approvedCount)'),
      ];
    } else if (isPayAsYouGo) {
      final submissions = MockData.getWorkSubmissions(widget.contract.id);
      final pendingCount =
          submissions.where((s) => s.status == PaymentStatus.pendingApproval).length;
      final approvedCount =
          submissions.where((s) => s.status == PaymentStatus.approved).length;
      final deniedCount =
          submissions.where((s) => s.status == PaymentStatus.rejected).length;

      tabs = [
        Tab(text: 'Pending ($pendingCount)'),
        Tab(text: 'Approved ($approvedCount)'),
        Tab(text: 'Denied ($deniedCount)'),
      ];
    } else {
      final pendingPayouts = _payouts
          .where((p) =>
              p.status == PaymentStatus.pending ||
              p.status == PaymentStatus.overdue)
          .length;
      final approvedPayouts = _payouts
          .where((p) =>
              p.status == PaymentStatus.approved ||
              p.status == PaymentStatus.paid)
          .length;

      tabs = [
        Tab(text: 'Pending ($pendingPayouts)'),
        Tab(text: 'Approved ($approvedPayouts)'),
      ];
    }

    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: context.theme.colors.fillTertiary,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: TabBar(
        controller: _tabController,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        indicator: BoxDecoration(
          color: context.theme.colors.bgB0,
          borderRadius: BorderRadius.circular(4.r),
        ),
        labelColor: context.theme.colors.textPrimary,
        unselectedLabelColor: context.theme.colors.textSecondary,
        labelStyle: context.theme.fonts.textSmMedium.copyWith(fontSize: 11.sp),
        unselectedLabelStyle:
            context.theme.fonts.textSmMedium.copyWith(fontSize: 11.sp),
        tabs: tabs,
      ),
    );
  }

  Widget _buildTabContent(BuildContext context) {
    if (isMilestone) {
      List<Milestone> filteredMilestones;
      String emptyMessage;
      if (_tabController.index == 0) {
        filteredMilestones = _milestones
            .where((m) =>
                m.status == PaymentStatus.pendingSubmission ||
                m.status == PaymentStatus.overdue)
            .toList();
        emptyMessage = 'No in progress milestones listed yet';
      } else if (_tabController.index == 1) {
        filteredMilestones = _milestones
            .where((m) => m.status == PaymentStatus.pendingApproval)
            .toList();
        emptyMessage = 'No in review milestones listed yet';
      } else {
        filteredMilestones = _milestones
            .where((m) =>
                m.status == PaymentStatus.awaitingPayment ||
                m.status == PaymentStatus.paid)
            .toList();
        emptyMessage = 'No approved milestones listed yet';
      }

      if (filteredMilestones.isEmpty) {
        return _buildEmptyState(context, emptyMessage);
      }

      return Column(
        children: filteredMilestones
            .map((m) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: InkWell(
                    onTap: () => context.router.push(
                      MilestoneDetailRoute(
                        milestone: m,
                        contractTitle: widget.contract.title,
                        clientName: widget.contract.clientName ?? 'Client',
                      ),
                    ),
                    child: _buildMilestoneCard(context, m),
                  ),
                ))
            .toList(),
      );
    } else if (isPayAsYouGo) {
      // Implementation for PAYG tabs
      if (_tabController.index == 0) {
        // Pending Tab
        return _buildPayAsYouGoList(context, 'Pending');
      } else if (_tabController.index == 1) {
        // Approved Tab
        return _buildPayAsYouGoList(context, 'Approved');
      } else {
        // Denied Tab
        return _buildPayAsYouGoList(context, 'Denied');
      }
    } else {
      final isPendingTab = _tabController.index == 0;
      final filteredPayouts = isPendingTab
          ? _payouts
              .where((p) =>
                  p.status == PaymentStatus.pending ||
                  p.status == PaymentStatus.overdue)
              .toList()
          : _payouts
              .where((p) =>
                  p.status == PaymentStatus.approved ||
                  p.status == PaymentStatus.paid)
              .toList();

      if (filteredPayouts.isEmpty) {
        return _buildEmptyState(context,
            isPendingTab ? 'No pending payouts' : 'No approved payouts');
      }

      return Column(
        children: filteredPayouts
            .map((p) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildCurrentPayoutCard(context, p,
                      isPending: isPendingTab),
                ))
            .toList(),
      );
    }
  }

  Widget _buildEmptyState(BuildContext context, String message) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.theme.colors.bgB1,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: context.theme.colors.strokeSecondary),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.info_outline,
              color: context.theme.colors.textSecondary, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: context.theme.fonts.textSmMedium.copyWith(
                color: context.theme.colors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMilestoneCard(BuildContext context, Milestone milestone) {
    final isApprovedTab = _tabController.index == 2;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.theme.colors.bgB1,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  milestone.title,
                  style: context.theme.fonts.textMdSemiBold.copyWith(
                    color: context.theme.colors.textPrimary,
                  ),
                ),
              ),
              Text(
                '${milestone.amount.toInt()} ${milestone.currency}',
                style: context.theme.fonts.textMdSemiBold.copyWith(
                  color: context.theme.colors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              if (isApprovedTab && milestone.invoiceNumber.isNotEmpty)
                Text(
                  milestone.invoiceNumber,
                  style: context.theme.fonts.textSmMedium.copyWith(
                    color: context.theme.colors.brandDefault,
                  ),
                )
              else if (milestone.dueDate != null)
                Text(
                  'Due by: ${milestone.dueDate!.dayMonthYear}',
                  style: context.theme.fonts.textSmRegular.copyWith(
                    color: context.theme.colors.textSecondary,
                  ),
                ),
              const Spacer(),
              _buildStatusWithDot(context, milestone.status),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentPayoutCard(BuildContext context, Payout payout,
      {required bool isPending}) {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.colors.bgB1,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'For ${payout.startDate.dayMonth} - ${payout.endDate.dayMonthYear}',
                    style: context.theme.fonts.textMdSemiBold.copyWith(
                      color: context.theme.colors.textPrimary,
                    ),
                  ),
                ),
                if (isPending)
                  Text(
                    '${payout.amount.toInt()} ${payout.currency}',
                    style: context.theme.fonts.textMdSemiBold.copyWith(
                      color: context.theme.colors.textPrimary,
                    ),
                  )
                else
                  Text(
                    payout.invoiceNumber,
                    style: context.theme.fonts.textMdMedium.copyWith(
                      color: context.theme.colors.brandDefault,
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  '1 item',
                  style: context.theme.fonts.textSmMedium.copyWith(
                    color: context.theme.colors.textSecondary,
                  ),
                ),
                const Spacer(),
                Text(
                  isPending ? 'Total pending' : 'Awaiting payment',
                  style: context.theme.fonts.textSmRegular.copyWith(
                    color: context.theme.colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Divider(color: context.theme.colors.strokeSecondary, height: 1),
          InkWell(
            onTap: () => context.router.push(PayoutDetailRoute(payout: payout)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Monthly payment',
                          style: context.theme.fonts.textMdMedium.copyWith(
                            color: context.theme.colors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Submitted: ${payout.submissionDate.dayMonthYear}',
                          style: context.theme.fonts.textSmRegular.copyWith(
                            color: context.theme.colors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${payout.amount.toInt()} ${payout.currency}',
                        style: context.theme.fonts.textMdSemiBold.copyWith(
                          color: context.theme.colors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      _buildStatusWithDot(context, payout.status),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistorySection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.theme.colors.bgB0,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Text(
              isPayAsYouGo
                  ? (widget.contract.frequency ==
                          PayCycleFrequency.perDeliverable
                      ? 'Deliverables history'
                      : (widget.contract.frequency == PayCycleFrequency.perDay
                          ? 'Days worked history'
                          : (widget.contract.frequency ==
                                  PayCycleFrequency.perWeek
                              ? 'Weeks worked history'
                              : 'Hours worked history')))
                  : 'Payouts history',
              style: context.theme.fonts.textBaseSemiBold,
            ),
          SizedBox(height: 20.h),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _paymentHistory.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: PaymentHistoryItemWidget(
                item: _paymentHistory[index],
                onTap: () {
                  final item = _paymentHistory[index];
                  if (isPayAsYouGo) {
                    final isDeliverable = widget.contract.frequency == PayCycleFrequency.perDeliverable;
                    context.router.push(
                      PayCycleSubmittedHoursDetailRoute(
                        submission: WorkSubmission(
                          id: item.id,
                          workDate: item.startDate,
                          submissionDate: item.submissionDate,
                          quantity: isDeliverable
                              ? 2
                              : (widget.contract.frequency ==
                                      PayCycleFrequency.perDay
                                  ? 4
                                  : (widget.contract.frequency ==
                                          PayCycleFrequency.perWeek
                                      ? 3
                                      : 12.35)),
                          unit: isDeliverable
                              ? 'deliverables'
                              : (widget.contract.frequency ==
                                      PayCycleFrequency.perDay
                                  ? 'days'
                                  : (widget.contract.frequency ==
                                          PayCycleFrequency.perWeek
                                      ? 'weeks'
                                      : 'hours')),
                          amount: item.amount,
                          currency: item.currency,
                          status: item.status,
                          invoiceNumber: item.invoiceNumber,
                          description: isDeliverable
                              ? 'Deliverables Batch'
                              : 'Refactored the user onboarding process to reduce friction, added progress indicators, and updated form validations for a smoother user experience.',
                          attachmentPath: 'File name.pdf',
                          breakdown: widget.contract.frequency ==
                                  PayCycleFrequency.perDay
                              ? [
                                  WorkBreakdownItem(
                                      label: 'Mon 12 May 2025',
                                      timeRange: '',
                                      duration: '1 day'),
                                  WorkBreakdownItem(
                                      label: 'Wed 14 May 2025',
                                      timeRange: '',
                                      duration: '1 day'),
                                  WorkBreakdownItem(
                                      label: 'Fri 16 May 2025',
                                      timeRange: '',
                                      duration: '1 day'),
                                  WorkBreakdownItem(
                                      label: 'Sat 17 May 2025',
                                      timeRange: '',
                                      duration: '1 day'),
                                ]
                              : (isDeliverable
                                  ? []
                                  : [
                                      WorkBreakdownItem(
                                          label: 'Feature Development',
                                          timeRange: '09:00 – 13:00',
                                          duration: '4h 00m'),
                                      WorkBreakdownItem(
                                          label: 'Bug Fixing',
                                          timeRange: '14:00 – 16:30',
                                          duration: '2h 30m'),
                                    ]),
                          records: [],
                        ),
                        contract: widget.contract,
                      ),
                    );
                  } else {
                    context.router.push(
                      PayoutDetailRoute(
                        payout: Payout(
                          id: item.id,
                          invoiceNumber: item.invoiceNumber,
                          status: item.status,
                          startDate: item.startDate,
                          endDate: item.endDate,
                          submissionDate: item.submissionDate,
                          dueDate: item.endDate,
                          amount: item.amount,
                          currency: item.currency,
                          contractId: widget.contract.id,
                          contractTitle: widget.contract.title,
                          clientName: widget.contract.clientName ?? 'Client',
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPayAsYouGoList(BuildContext context, String tabType) {
    final submissions = MockData.getWorkSubmissions(widget.contract.id);

    if (tabType == 'Pending') {
      final pendingSubmissions = submissions
          .where((s) => s.status == PaymentStatus.pendingApproval)
          .toList();
      if (pendingSubmissions.isEmpty) {
        final itemLabel = widget.contract.frequency ==
                PayCycleFrequency.perDeliverable
            ? 'deliverable'
            : (widget.contract.frequency == PayCycleFrequency.perDay
                ? 'pending workday'
                : (widget.contract.frequency == PayCycleFrequency.perWeek
                    ? 'no pending workweek'
                    : 'hours worked'));
        return _buildEmptyState(context, 'No $itemLabel yet');
      }
      return Column(
        children: [
          _buildPayAsYouGoGroupHeader(
            context,
            title: 'For 1 May - 31 May 2025',
            amount: '33 USDT',
            subtitle: '${pendingSubmissions.length} items',
            amountLabel: 'Total pending',
          ),
          const SizedBox(height: 12),
          ...pendingSubmissions.map((s) => Column(
                children: [
                  _buildWorkItemCard(
                    context,
                    submission: s,
                    onTap: () => context.router.push(
                      PayCycleSubmittedHoursDetailRoute(
                        submission: s,
                        contract: widget.contract,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              )),
        ],
      );
    } else if (tabType == 'Approved') {
      final approvedSubmissions =
          submissions.where((s) => s.status == PaymentStatus.approved).toList();
      return Column(
        children: [
          _buildPayAsYouGoGroupHeader(
            context,
            title: 'For 1 May - 31 May 2025',
            amount: '#INV-2025-001',
            subtitle: '${approvedSubmissions.length} items',
            amountLabel: 'Awaiting payment',
            isInvoice: true,
          ),
          const SizedBox(height: 12),
          ...approvedSubmissions.map((s) => Column(
                children: [
                  _buildWorkItemCard(
                    context,
                    submission: s,
                    onTap: () => context.router.push(
                      PayCycleSubmittedHoursDetailRoute(
                        submission: s,
                        contract: widget.contract,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              )),
        ],
      );
    } else if (tabType == 'Denied') {
      final rejectedSubmissions =
          submissions.where((s) => s.status == PaymentStatus.rejected).toList();
      return Column(
        children: [
          _buildPayAsYouGoGroupHeader(
            context,
            title: 'For 1 May - 31 May 2025',
            amount: '33 USDT',
            subtitle: '${rejectedSubmissions.length} item',
            amountLabel: 'Total rejected',
          ),
          const SizedBox(height: 12),
          ...rejectedSubmissions.map((s) => Column(
                children: [
                  _buildWorkItemCard(
                    context,
                    submission: s,
                    onTap: () => context.router.push(
                      PayCycleSubmittedHoursDetailRoute(
                        submission: s,
                        contract: widget.contract,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              )),
        ],
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildPayAsYouGoGroupHeader(
    BuildContext context, {
    required String title,
    required String amount,
    required String subtitle,
    required String amountLabel,
    bool isInvoice = false,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: context.theme.fonts.textMdSemiBold.copyWith(
                  color: context.theme.colors.textPrimary,
                ),
              ),
            ),
            Text(
              amount,
              style: context.theme.fonts.textMdSemiBold.copyWith(
                color: isInvoice
                    ? context.theme.colors.brandDefault
                    : context.theme.colors.textPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Text(
              subtitle,
              style: context.theme.fonts.textSmMedium.copyWith(
                color: context.theme.colors.textSecondary,
              ),
            ),
            const Spacer(),
            Text(
              amountLabel,
              style: context.theme.fonts.textSmRegular.copyWith(
                color: context.theme.colors.textSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWorkItemCard(
    BuildContext context, {
    required WorkSubmission submission,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.theme.colors.bgB1,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.contract.frequency == PayCycleFrequency.perDeliverable
                        ? (submission.description ?? 'Deliverable')
                        : '${submission.quantity.toInt()} ${submission.unit} worked',
                    style: context.theme.fonts.textMdSemiBold.copyWith(
                      color: context.theme.colors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${submission.amount.toInt()} ${submission.currency}',
                  style: context.theme.fonts.textMdSemiBold.copyWith(
                    color: context.theme.colors.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Submitted: ${submission.submissionDate.dayMonthYear}',
                  style: context.theme.fonts.textSmRegular.copyWith(
                    color: context.theme.colors.textSecondary,
                  ),
                ),
                const Spacer(),
                _buildStatusWithDot(context, submission.status),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusWithDot(BuildContext context, PaymentStatus status) {
    Color color;
    String text;
    switch (status) {
      case PaymentStatus.pending:
        color = context.theme.colors.orangeDefault;
        text = 'Pending approval';
        break;
      case PaymentStatus.approved:
      case PaymentStatus.paid:
        color = context.theme.colors.greenDefault;
        text = status == PaymentStatus.approved ? 'Approved' : 'Paid';
        break;
      case PaymentStatus.overdue:
        color = context.theme.colors.redDefault;
        text = 'Overdue';
        break;
      case PaymentStatus.pendingSubmission:
        color = context.theme.colors.orangeDefault;
        text = 'Pending submission';
        break;
      case PaymentStatus.pendingApproval:
        color = context.theme.colors.orangeActive;
        text = 'Pending approval';
        break;
      case PaymentStatus.awaitingPayment:
        color = context.theme.colors.brandDefault;
        text = 'Awaiting payment';
        break;
      case PaymentStatus.rejected:
        color = context.theme.colors.redDefault;
        text = 'Rejected';
        break;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: context.theme.fonts.textSmMedium.copyWith(
            color: color,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
