import 'package:defifundr_mobile/core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/design_system/font_extension/font_extension.dart';
import 'package:defifundr_mobile/core/design_system/color_extension/app_color_extension.dart';
import 'package:defifundr_mobile/modules/payment/data/models/payment.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:defifundr_mobile/core/utils/ellipsify.dart';

class InvoiceScreen extends StatelessWidget {
  final Payment payment;

  const InvoiceScreen({Key? key, required this.payment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorExtension>()!;
    final fontTheme = Theme.of(context).extension<AppFontThemeExtension>()!;

    final appBarTitle = payment.paymentType == PaymentType.contract
        ? 'Contract payment'
        : 'Invoice';

    final bool isOverdue = payment.status == PaymentStatus.overdue ||
        payment.estimatedDate.difference(DateTime.now()).inDays < 0;

    final daysUntil = payment.estimatedDate.difference(DateTime.now()).inDays;
    String statusText = isOverdue
        ? 'Overdue'
        : 'Coming in ${daysUntil > 0 ? daysUntil : 2} days';
    Color statusColor = isOverdue ? colors.orangeDefault : colors.blueDefault;

    final formattedDate =
        DateFormat('dd MMMM yyyy').format(payment.estimatedDate);

    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 60),
        child: SafeArea(
          child: Row(
            children: [
              IconButton(
                onPressed: () => context.router.maybePop(),
                icon: Icon(Icons.arrow_back_ios, color: colors.textPrimary),
              ),
              Expanded(
                child: Text(
                  appBarTitle,
                  style: context.theme.textTheme.headlineLarge?.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: 48),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: colors.bgB0,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: payment.iconBackgroundColor,
                    child: Center(
                      child: SvgPicture.asset(
                        payment.icon,
                        height: 24,
                        width: 24,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '${payment.amount.toStringAsFixed(0)} ${payment.currency}',
                    style: fontTheme.heading1Bold.copyWith(fontSize: 32),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '≈ \$${(payment.amount * 0.96).toStringAsFixed(2)}',
                    style: fontTheme.textBaseRegular
                        .copyWith(fontSize: 16, color: colors.textSecondary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: colors.bgB0,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Column(
                children: [
                  _buildDetailRow(
                    context,
                    'Status',
                    statusText,
                    valueColor: statusColor,
                    showBubble: true,
                    isOutlinedBubble: isOverdue,
                  ),
                  const SizedBox(height: 30),
                  _buildDetailRow(context, 'Est. arrival date', formattedDate),
                  const SizedBox(height: 30),
                  _buildDetailRow(
                    context,
                    'Network',
                    payment.paymentNetwork.name.substring(0, 1).toUpperCase() +
                        payment.paymentNetwork.name.substring(1).toLowerCase(),
                    showNetworkIcon: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: colors.bgB0,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: payment.paymentType == PaymentType.contract
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow(context, 'Contract',
                            ellipsify(word: payment.title, maxLength: 25),
                            showLinkIcon: true),
                        const SizedBox(height: 30),
                        _buildDetailRow(context, 'Contract type', 'Fixed Rate'),
                        const SizedBox(height: 30),
                        _buildDetailRow(context, 'Invoice', '#INV-2025-001',
                            showLinkIcon: true),
                        const SizedBox(height: 30),
                        _buildDetailRow(
                            context, 'Client', 'Adegboyega Oluwagbemiro'),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow(context, 'Invoice', '#INV-2025-001',
                            showLinkIcon: true),
                        const SizedBox(height: 30),
                        _buildDetailRow(context, 'Title',
                            ellipsify(word: payment.title, maxLength: 25)),
                        const SizedBox(height: 30),
                        _buildDetailRow(
                            context, 'Client', 'Adegboyega Oluwagbemiro'),
                      ],
                    ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 24, bottom: 24),
              decoration: BoxDecoration(
                color: colors.bgB0,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _buildPaymentTrackerItems(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildPaymentTrackerItems(BuildContext context) {
    bool isOverdue = payment.status == PaymentStatus.overdue ||
        payment.estimatedDate.difference(DateTime.now()).inDays < 0;

    if (payment.paymentType == PaymentType.contract) {
      return [
        _buildTrackerItem(
          context,
          icon: Icons.check_circle,
          iconColor: context.theme.colors.greenDefault,
          title: 'Contract cycle completed',
          subtitle: '20 April 2025, 04:40 PM',
          isCompleted: true,
          lineColor: context.theme.colors.greenDefault,
        ),
        _buildTrackerItem(
          context,
          icon: Icons.check_circle,
          iconColor: context.theme.colors.greenDefault,
          title: 'Client approved contract cycle',
          subtitle: '20 April 2025, 04:40 PM',
          isCompleted: true,
          lineColor: context.theme.colors.greenDefault,
        ),
        _buildTrackerItem(
          context,
          icon: Icons.check_circle,
          iconColor: context.theme.colors.greenDefault,
          title: 'Invoice created for this cycle',
          subtitle: '20 April 2025, 04:40 PM',
          isCompleted: true,
          lineColor: context.theme.colors.greenDefault,
        ),
        if (isOverdue)
          _buildTrackerItem(
            context,
            icon: Icons.warning_amber_rounded,
            iconColor: context.theme.colors.orangeHover,
            title: 'Client payment overdue',
            subtitle:
                'The payment was expected by **31 May 2025** but has not yet been received.',
            isCompleted: false,
          )
        else
          _buildTrackerItem(
            context,
            icon: Icons.watch_later_outlined,
            iconColor: context.theme.colors.orangeDefault,
            title: 'Awaiting payment confirmation',
            subtitle:
                'Your client will get invoice access **10 days** before it is due.',
            isCompleted: false,
          ),
        _buildTrackerItem(
          context,
          customIcon: DashedCircleIcon(
              color: context.theme.colors.textSecondary.withValues(alpha: 0.5)),
          title: 'Process your client payment',
          isCompleted: false,
          isGreyedOut: true,
        ),
        _buildTrackerItem(
          context,
          customIcon: DashedCircleIcon(
              color: context.theme.colors.textSecondary.withValues(alpha: 0.5)),
          subtitle:
              'According to your invoice, funds should be reflected in your balance on **31 May 2025**.',
          isCompleted: false,
          isGreyedOut: true,
          isLast: true,
        ),
      ];
    } else {
      return [
        _buildTrackerItem(
          context,
          icon: Icons.check_circle,
          iconColor: context.theme.colors.greenDefault,
          title: 'Invoice created and sent to client',
          subtitle: '20 April 2025, 04:40 PM',
          isCompleted: true,
          lineColor: context.theme.colors.greenDefault,
        ),
        if (isOverdue)
          _buildTrackerItem(
            context,
            icon: Icons.warning_amber_rounded,
            iconColor: context.theme.colors.orangeHover,
            title: 'Client payment overdue',
            subtitle:
                'The payment was expected by **31 May 2025** but has not yet been received.',
            isCompleted: false,
          )
        else
          _buildTrackerItem(
            context,
            icon: Icons.watch_later_outlined,
            iconColor: context.theme.colors.orangeDefault,
            title: 'Awaiting payment confirmation',
            subtitle:
                'Your client will get invoice access before it is due on **31 May 2025**.',
            isCompleted: false,
          ),
        _buildTrackerItem(
          context,
          customIcon: DashedCircleIcon(
              color: context.theme.colors.textSecondary.withValues(alpha: 0.5)),
          title: 'Process your client payment',
          isCompleted: false,
          isGreyedOut: true,
        ),
        _buildTrackerItem(
          context,
          customIcon: DashedCircleIcon(
              color: context.theme.colors.textSecondary.withValues(alpha: 0.5)),
          subtitle:
              'According to your invoice, funds should be reflected in your balance on **31 May 2025**.',
          isCompleted: false,
          isGreyedOut: true,
          isLast: true,
        ),
      ];
    }
  }

  Widget _buildTrackerItem(
    BuildContext context, {
    Widget? customIcon,
    IconData? icon,
    Color? iconColor,
    String? title,
    String? subtitle,
    required bool isCompleted,
    bool isLast = false,
    Color? lineColor,
    bool isGreyedOut = false,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              customIcon ??
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Center(
                      child: Icon(
                        icon,
                        color: iconColor,
                        size: 20,
                      ),
                    ),
                  ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 1.5,
                    color: lineColor ??
                        context.theme.colors.strokeSecondary
                            .withValues(alpha: 0.3),
                    margin: const EdgeInsets.only(top: 4, bottom: 4),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (title != null && title.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Text(
                      title,
                      style: context.theme.fonts.textMdMedium.copyWith(
                        fontSize: 13,
                        color: isGreyedOut
                            ? context.theme.colors.textSecondary
                                .withValues(alpha: 0.5)
                            : context.theme.colors.textPrimary,
                      ),
                    ),
                  ),
                if (subtitle != null && subtitle.isNotEmpty) ...[
                  if (title != null && title.isNotEmpty)
                    const SizedBox(height: 4),
                  Padding(
                    padding: EdgeInsets.only(
                        top: (title == null || title.isEmpty) ? 2.0 : 0.0),
                    child: _buildRichSubtitle(context, subtitle, isGreyedOut),
                  ),
                ],
                if (!isLast) const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRichSubtitle(
      BuildContext context, String text, bool isGreyedOut) {
    if (!text.contains('**')) {
      return Text(
        text,
        style: context.theme.fonts.textMdRegular.copyWith(
          fontSize: 12,
          color: isGreyedOut
              ? context.theme.colors.textSecondary.withValues(alpha: 0.5)
              : context.theme.colors.textSecondary,
        ),
      );
    }

    final defaultStyle = context.theme.fonts.textMdRegular.copyWith(
      fontSize: 12,
      color: isGreyedOut
          ? context.theme.colors.textSecondary.withValues(alpha: 0.5)
          : context.theme.colors.textSecondary,
    );

    final boldStyle = context.theme.fonts.textMdSemiBold.copyWith(
      fontSize: 12,
      color: isGreyedOut
          ? context.theme.colors.textPrimary.withValues(alpha: 0.5)
          : context
              .theme.colors.textPrimary, // Bolds stand out with textPrimary
    );

    final parts = text.split('**');
    List<TextSpan> spans = [];
    for (int i = 0; i < parts.length; i++) {
      // even indexes are normal, odd indexes are bold
      spans.add(TextSpan(
        text: parts[i],
        style: i % 2 == 1 ? boldStyle : defaultStyle,
      ));
    }

    return RichText(text: TextSpan(children: spans));
  }

  Widget _buildDetailRow(BuildContext context, String label, String value,
      {Color? valueColor,
      bool showBubble = false,
      bool isOutlinedBubble = false,
      bool showLinkIcon = false,
      bool showNetworkIcon = false}) {
    final colors = Theme.of(context).extension<AppColorExtension>()!;
    final fontTheme = Theme.of(context).extension<AppFontThemeExtension>()!;

    String? networkIconAsset;
    if (label == 'Network') {
      switch (value.toLowerCase()) {
        case 'ethereum':
          networkIconAsset = AppIcons.ethereumIcon;
          break;
        case 'starknet':
          networkIconAsset = AppIcons.starknetIcon;
          break;
        case 'solana':
          networkIconAsset = AppIcons.solanaIcon;
          break;
        case 'stellar':
          networkIconAsset = AppIcons.stellar;
          break;
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: fontTheme.textSmRegular.copyWith(color: colors.textSecondary),
        ),
        Row(
          children: [
            if (showNetworkIcon && networkIconAsset != null) ...[
              SvgPicture.asset(
                networkIconAsset,
                height: 16,
                width: 16,
              ),
              const SizedBox(width: 4),
            ],
            if (showBubble)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: isOutlinedBubble ? colors.orangeFill : colors.blueFill,
                  borderRadius: BorderRadius.circular(32.0),
                  border: Border.all(
                    color: isOutlinedBubble
                        ? colors.orangeStroke
                        : colors.blueStroke,
                    width: 1,
                  ),
                ),
                child: Text(
                  value,
                  style: fontTheme.textXsSemiBold.copyWith(
                    color: valueColor ?? colors.brandDefault,
                    fontSize: 12,
                  ),
                ),
              )
            else
              Text(
                value,
                style: fontTheme.textBaseMedium,
              ),
            if (showLinkIcon) ...[
              const SizedBox(width: 4),
              Icon(Icons.open_in_new, color: colors.textPrimary, size: 16),
            ],
          ],
        ),
      ],
    );
  }
}

class DashedCircleIcon extends StatelessWidget {
  final Color color;
  const DashedCircleIcon({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: Center(
        child: SizedBox(
          width: 18,
          height: 18,
          child: CustomPaint(
            painter: DashedCirclePainter(color: color),
          ),
        ),
      ),
    );
  }
}

class DashedCirclePainter extends CustomPainter {
  final Color color;

  DashedCirclePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: (size.width / 2) - 1);

    const int dashCount = 8;
    const double dashLength = (2 * 3.141592653589793) / (dashCount * 2);

    for (int i = 0; i < dashCount; i++) {
      canvas.drawArc(rect, i * 2 * dashLength, dashLength, false, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
