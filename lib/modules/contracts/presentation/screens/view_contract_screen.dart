import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/shared/common/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/components/agreement_bottom_sheet.dart';
import 'package:defifundr_mobile/core/shared/components/review_sign_bottom_sheet.dart';
import 'package:defifundr_mobile/core/utils/get_initials.dart';
import 'package:defifundr_mobile/modules/time_tracking/data/models/contract.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/screens/create_contract_flow/widgets/agreement_file_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';

@RoutePage()
class ViewContractScreen extends StatefulWidget {
  final TimeTrackingContract contract;

  const ViewContractScreen({
    Key? key,
    required this.contract,
  }) : super(key: key);

  @override
  State<ViewContractScreen> createState() => _ViewContractScreenState();
}

class _ViewContractScreenState extends State<ViewContractScreen> {
  bool _workScopeExpanded = false;

  bool get _isPending => widget.contract.status == ContractStatus.pending;
  bool get _isPendingSignature =>
      widget.contract.status == ContractStatus.pendingSignature;
  bool get _isRejected => widget.contract.status == ContractStatus.rejected;
  bool get _showInvitedBanner => _isPending || _isPendingSignature;

  Map<String, String> get _contractDates => {
        'Creation Date': '15 April 2025',
        'Start Date': '18 April 2025',
        'End Date': '30 September 2025',
        'Termination notice period': '10 days',
      };

  Map<String, String> get _roleDetails => {
        'Job Role': 'Senior DevOps Engineer',
      };

  String get _workScope =>
      'Infrastructure Management: Manage and optimize cloud-based infrastructure, ensuring scalability and reliability across all services. This includes monitoring system performance, implementing CI/CD pipelines, and automating deployment workflows to reduce downtime and improve delivery speed.';

  Map<String, String> get _clientDetails => {
        'Name': 'Adegboyega Oluwagbemiro',
        'Email': 'adeshinaadegboyega@icloud.com',
        'Phone no': '+234 (801) 234 5678',
        'Country': '🇳🇬 Nigeria',
        'Address':
            'No 8 James Robertson Shittu/ Ogunlana Drive, Surulere | 142261',
      };

  String get _additionalTerms =>
      'In the event that any payment due under this Agreement is not received by the Contractor within fifteen (15) days after the due date, the Client agrees to pay a late fee of 1.5% per month on any overdue amount, or the maximum amount permitted by law, whichever is lower.';

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;

    return Scaffold(
      backgroundColor: colors.bgB1,
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 60),
        child: DeFiRaiseAppBar(
          centerTitle: true,
          textStyle: context.theme.fonts.heading3SemiBold,
          isBack: true,
          title: '',
          actions: _isRejected
              ? []
              : [
                  PopupMenuButton<String>(
                    icon: Icon(
                      Icons.more_vert,
                      color: colors.textPrimary,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    color: colors.bgB0,
                    elevation: 4,
                    onSelected: (value) {
                      switch (value) {
                        case 'download':
                          break;
                        case 'terminate':
                          context.router.push(RequestTerminationRoute(
                            clientName: 'Kehinde Adeoye',
                            noticePeriod: '10 days',
                          ));
                          break;
                        case 'cancel':
                          _showCancelContractSheet(context);
                          break;
                        case 'reject':
                          _showRejectContractSheet(context);
                          break;
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem<String>(
                        value: 'download',
                        child: Row(
                          children: [
                            Icon(
                              Iconsax.document_download,
                              size: 20.sp,
                              color: colors.textPrimary,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'Download contract',
                              style: context.theme.fonts.textMdMedium.copyWith(
                                color: colors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: _isPending
                            ? 'cancel'
                            : _isPendingSignature
                                ? 'reject'
                                : 'terminate',
                        child: Row(
                          children: [
                            Icon(
                              Iconsax.close_circle,
                              size: 20.sp,
                              color: colors.redDefault,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              _isPending
                                  ? 'Cancel contract'
                                  : _isPendingSignature
                                      ? 'Reject contract'
                                      : 'Request termination',
                              style: context.theme.fonts.textMdMedium.copyWith(
                                color: colors.redDefault,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildContractHeader(context),
              SizedBox(height: 20.h),
              _buildSectionCard(
                context,
                title: 'Contract Dates',
                child: Column(
                  children: _contractDates.entries
                      .map((e) => _buildDetailRow(context, e.key, e.value))
                      .toList(),
                ),
              ),
              SizedBox(height: 20.h),
              _buildSectionCard(
                context,
                title: 'Role Details',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ..._roleDetails.entries
                        .map((e) => _buildDetailRow(context, e.key, e.value))
                        .toList(),
                    _buildWorkScopeSection(context),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              _buildSectionCard(
                context,
                title: 'Client Details',
                child: Column(
                  children: _clientDetails.entries
                      .map((e) => _buildDetailRow(context, e.key, e.value))
                      .toList(),
                ),
              ),
              SizedBox(height: 20.h),
              _buildPaymentSection(context),
              SizedBox(height: 20.h),
              _buildComplianceSection(context),
              if (_isPending) ...[
                SizedBox(height: 20.h),
                PrimaryButton(
                  onPressed: () {},
                  text: 'Resend contract link',
                ),
              ],
              if (_isPendingSignature) ...[
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(
                      child: PrimaryButton(
                        text: 'Reject contract',
                        onPressed: () => _showRejectContractSheet(context),
                        color: colors.fillTertiary,
                        textColor: colors.textPrimary,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: PrimaryButton(
                        text: 'Review & Sign',
                        onPressed: () => _navigateToReviewAndSign(context),
                      ),
                    ),
                  ],
                ),
              ],
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContractHeader(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.bgB0,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: colors.brandHover,
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: Center(
                  child: Text(
                    getInitials(widget.contract.title),
                    style: fonts.textMdMedium.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.contract.title,
                      style: fonts.heading3Bold.copyWith(
                        color: colors.textPrimary,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        Text(
                          widget.contract.type.title,
                          style: fonts.textSmRegular.copyWith(
                            color: colors.textSecondary,
                          ),
                        ),
                        if (_isRejected) ...[
                          SizedBox(width: 8.w),
                          Text(' • ',
                              style: fonts.textSmRegular
                                  .copyWith(color: colors.textSecondary)),
                          SizedBox(width: 8.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: widget.contract.status.fillColor(context),
                              borderRadius: BorderRadius.circular(32.r),
                              border: Border.all(
                                color:
                                    widget.contract.status.borderColor(context),
                              ),
                            ),
                            child: Text(
                              'Rejected',
                              style: fonts.textXsMedium.copyWith(
                                color:
                                    widget.contract.status.textColor(context),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (_showInvitedBanner) ...[
            Column(
              children: [
                SizedBox(height: 12.h),
                Container(
                  padding: EdgeInsets.all(12.sp),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: context.theme.colors.fillTertiary),
                  child: Text.rich(
                    TextSpan(
                      style: fonts.textSmRegular.copyWith(
                        color: colors.textSecondary,
                        height: 1.5,
                      ),
                      children: [
                        const TextSpan(text: 'You have invited '),
                        TextSpan(
                          text:
                              'Adegboyega Oluwagbemiro (adeshinaadegboyega@icloud.com)',
                          style: fonts.textSmMedium.copyWith(
                            color: colors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
          if (_isRejected) ...[
            Column(
              children: [
                SizedBox(height: 12.h),
                Container(
                  padding: EdgeInsets.all(12.sp),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: context.theme.colors.fillTertiary,
                  ),
                  child: Text.rich(
                    TextSpan(
                      style: fonts.textSmRegular.copyWith(
                        color: colors.textSecondary,
                        height: 1.5,
                      ),
                      children: [
                        const TextSpan(text: 'This contract was rejected by '),
                        TextSpan(
                          text: 'Stephen Dairo (adeshinaadegboyega@icloud.com)',
                          style: fonts.textSmMedium.copyWith(
                            color: colors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSectionCard(
    BuildContext context, {
    required String title,
    required Widget child,
  }) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: colors.bgB0,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: fonts.textBaseSemiBold.copyWith(
              color: colors.textPrimary,
            ),
          ),
          SizedBox(height: 20.h),
          child,
        ],
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;

    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: fonts.textMdRegular.copyWith(
              color: colors.textSecondary,
            ),
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: Text(
              value,
              style: fonts.textMdMedium.copyWith(
                color: colors.textPrimary,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkScopeSection(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Work Scope',
            style: fonts.textMdRegular.copyWith(
              color: colors.textSecondary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            _workScope,
            maxLines: _workScopeExpanded ? null : 3,
            overflow: _workScopeExpanded ? null : TextOverflow.ellipsis,
            style: fonts.textMdMedium.copyWith(
              color: colors.textPrimary,
              height: 1.5,
            ),
          ),
          GestureDetector(
            onTap: () =>
                setState(() => _workScopeExpanded = !_workScopeExpanded),
            child: Text(
              _workScopeExpanded ? 'Show less' : '...Read more',
              style: fonts.textMdMedium.copyWith(
                color: colors.brandDefault,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentSection(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;
    final isPayAsYouGo = widget.contract.type == ContractType.payAsYouGo;
    final isMilestone = widget.contract.type == ContractType.milestone;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: colors.bgB0,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isMilestone ? 'Payment & Milestone' : 'Payment & Invoice',
            style: fonts.textBaseSemiBold.copyWith(
              color: colors.textPrimary,
            ),
          ),
          SizedBox(height: 20.h),
          _buildPaymentRow(context, 'Network', 'Ethereum', networkIcon: '🔷'),
          _buildPaymentRow(context, 'Asset', 'USDT', networkIcon: '🟢'),
          if (isMilestone) ...[
            _buildPaymentRowWithSubtitle(
              context,
              'Milestone Name',
              '51 USDT',
              'Due: 15 September 2024',
            ),
            _buildDetailRow(context, 'Require a Deposit', 'No'),
          ] else ...[
            if (isPayAsYouGo) ...[
              _buildDetailRow(context, 'Unit Type', 'Per Hour'),
              _buildPaymentRowWithSubtitle(
                context,
                'Payment Rate',
                '51 USDT',
                '\$50.89',
              ),
            ] else ...[
              _buildPaymentRowWithSubtitle(
                context,
                'Payment Rate',
                '\$81 USDT',
                '\$583.65',
              ),
            ],
            _buildDetailRow(context, 'Invoice Frequency', 'Weekly'),
            _buildDetailRow(context, 'Issue Invoice On', 'Monday'),
            _buildDetailRow(context, 'Payment Due', 'Same day'),
            _buildDetailRow(context, 'First Invoice Date', '15 September 2024'),
            if (!isPayAsYouGo)
              _buildDetailRow(
                  context, 'Amount', 'Full amount \u2022 \$81 USDT'),
            _buildDetailRow(context, 'Inclusive Tax', 'No'),
          ],
        ],
      ),
    );
  }

  Widget _buildPaymentRow(
    BuildContext context,
    String label,
    String value, {
    String? networkIcon,
  }) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;

    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: fonts.textMdRegular.copyWith(
              color: colors.textSecondary,
            ),
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (networkIcon != null) ...[
                  Container(
                    width: 20.w,
                    height: 20.w,
                    decoration: BoxDecoration(
                      color: label == 'Network'
                          ? const Color(0xFF627EEA)
                          : const Color(0xFF26A17B),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        label == 'Network' ? 'Ξ' : '\$',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 6.w),
                ],
                Text(
                  value,
                  style: fonts.textMdMedium.copyWith(
                    color: colors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentRowWithSubtitle(
    BuildContext context,
    String label,
    String value,
    String subtitle,
  ) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;

    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: fonts.textMdRegular.copyWith(
              color: colors.textSecondary,
            ),
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  value,
                  style: fonts.textMdMedium.copyWith(
                    color: colors.textPrimary,
                  ),
                  textAlign: TextAlign.right,
                ),
                Text(
                  subtitle,
                  style: fonts.textXsMedium.copyWith(
                    color: colors.textSecondary,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComplianceSection(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: colors.bgB0,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Compliance',
            style: fonts.textBaseSemiBold.copyWith(
              color: colors.textPrimary,
            ),
          ),
          SizedBox(height: 20.h),
          _buildDetailRow(context, 'Agreement', 'Standard agreement'),
          SizedBox(height: 20.h),
          AgreementFileCard(onView: () {}),
          SizedBox(height: 20.h),
          Text('Additional terms',
              style: fonts.textMdRegular.copyWith(
                color: colors.textSecondary,
              )),
          SizedBox(height: 8.h),
          Text(
            _additionalTerms,
            style: fonts.textMdMedium.copyWith(
              color: colors.textPrimary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  void _showCancelContractSheet(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Container(
        padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
        decoration: BoxDecoration(
          color: colors.bgB0,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: colors.strokeSecondary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'Cancel contract?',
              style: fonts.heading2Bold.copyWith(
                color: colors.textPrimary,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Are you sure you want to cancel this contract?',
              style: fonts.textMdRegular.copyWith(
                color: colors.textSecondary,
              ),
            ),
            SizedBox(height: 20.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: colors.fillTertiary,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.contract.title,
                    style: fonts.textMdSemiBold.copyWith(
                      color: colors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Senior DevOps Engineer • ${widget.contract.type.title}',
                    style: fonts.textSmRegular.copyWith(
                      color: colors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    text: 'Go back',
                    onPressed: () => Navigator.of(ctx).pop(),
                    color: colors.fillTertiary,
                    textColor: colors.textPrimary,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: PrimaryButton(
                    text: 'Cancel contract',
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      _showCancelSuccessSheet(context);
                    },
                    color: colors.redDefault,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showCancelSuccessSheet(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;

    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        decoration: BoxDecoration(
          color: colors.bgB0,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 70.w,
                height: 70.h,
                decoration: BoxDecoration(
                  color: colors.brandFill,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    Assets.icons.termination,
                    height: 48.h,
                    width: 48.w,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Contract cancelled',
                style: fonts.heading2Bold.copyWith(
                  color: colors.textPrimary,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'This contract has been cancelled. For a new agreement, please create a new contract.',
                textAlign: TextAlign.center,
                style: fonts.textMdRegular.copyWith(
                  color: colors.textSecondary,
                ),
              ),
              SizedBox(height: 32.h),
              PrimaryButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  context.router.maybePop();
                },
                text: 'Done',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showRejectContractSheet(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;
    final reasonController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom,
        ),
        child: Container(
          padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
          decoration: BoxDecoration(
            color: colors.bgB0,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: colors.strokeSecondary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                'Reject contract?',
                style: fonts.heading2Bold.copyWith(
                  color: colors.textPrimary,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Are you sure you want to reject this contract?',
                style: fonts.textMdRegular.copyWith(
                  color: colors.textSecondary,
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: colors.fillTertiary,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.contract.title,
                      style: fonts.textMdSemiBold.copyWith(
                        color: colors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Senior DevOps Engineer \u2022 ${widget.contract.type.title}',
                      style: fonts.textSmRegular.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              TextField(
                controller: reasonController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Provide a reason *',
                  hintStyle: fonts.textMdRegular.copyWith(
                    color: colors.textSecondary,
                  ),
                  filled: true,
                  fillColor: colors.bgB1,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: colors.strokeSecondary),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: colors.strokeSecondary),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: colors.brandDefault),
                  ),
                ),
                style: fonts.textMdRegular.copyWith(
                  color: colors.textPrimary,
                ),
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      text: 'Go back',
                      onPressed: () => Navigator.of(ctx).pop(),
                      color: colors.fillTertiary,
                      textColor: colors.textPrimary,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: PrimaryButton(
                      text: 'Reject contract',
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        _showRejectSuccessSheet(context);
                      },
                      color: colors.redDefault,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showRejectSuccessSheet(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;

    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        decoration: BoxDecoration(
          color: colors.bgB0,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 70.w,
                height: 70.h,
                decoration: BoxDecoration(
                  color: colors.brandFill,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    Assets.icons.termination,
                    height: 48.h,
                    width: 48.w,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Contract rejected',
                style: fonts.heading2Bold.copyWith(
                  color: colors.textPrimary,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'This contract has been rejected. For a new agreement, please create a new contract.',
                textAlign: TextAlign.center,
                style: fonts.textMdRegular.copyWith(
                  color: colors.textSecondary,
                ),
              ),
              SizedBox(height: 32.h),
              PrimaryButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  context.router.maybePop();
                },
                text: 'Done',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToReviewAndSign(BuildContext context) {
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
                Navigator.of(context).pop();
              },
            ),
          );
        },
      ),
    );
  }
}
