import 'package:defifundr_mobile/core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/design_system/font_extension/font_extension.dart';
import 'package:defifundr_mobile/core/design_system/color_extension/app_color_extension.dart';
import 'package:defifundr_mobile/feature/payment_screens/models/payment.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

enum TimelineStatus { completed, current, future }

// Custom painter for dashed line
class DashedLinePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;

  DashedLinePainter({
    this.color = Colors.grey,
    this.strokeWidth = 1.0,
    this.dashWidth = 5.0,
    this.dashSpace = 5.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    double startY = 0;
    while (startY < size.height) {
      canvas.drawLine(
        Offset(size.width / 2, startY),
        Offset(size.width / 2, startY + dashWidth),
        paint,
      );
      startY += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Widget to display the dashed vertical divider
class DashedVerticalDivider extends StatelessWidget {
  final double height;
  final Color color;

  const DashedVerticalDivider(
      {Key? key, required this.height, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: 2, // Match the width of the timeline line
      child: CustomPaint(
        painter: DashedLinePainter(
            color: color,
            dashWidth: 4.0,
            dashSpace: 4.0), // Adjust dash properties here
      ),
    );
  }
}

class InvoiceScreen extends StatelessWidget {
  final Payment payment;

  const InvoiceScreen({Key? key, required this.payment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorExtension>()!;
    final fontTheme = Theme.of(context).extension<AppFontThemeExtension>()!;

    // Determine app bar title based on payment type
    final appBarTitle = payment.paymentType == PaymentType.contract
        ? 'Contract Payment'
        : 'Invoice';

    // Determine status text and color
    String statusText;
    Color statusColor;
    switch (payment.status) {
      case PaymentStatus.upcoming:
        // You might want to calculate days dynamically here based on payment.estimatedDate and current date
        statusText =
            'Coming in 7 days'; // Placeholder, replace with dynamic calculation
        statusColor = colors.blueHover; // Example color for upcoming
        break;
      case PaymentStatus.overdue:
        statusText = 'Overdue';
        statusColor = colors.orangeHover; // Example color for overdue
        break;
    }

    // Format date
    final formattedDate =
        DateFormat('dd MMMM yyyy').format(payment.estimatedDate);

    return Scaffold(
      backgroundColor: context
          .theme.scaffoldBackgroundColor, // Assuming a light grey background

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 40), // Increased top spacing
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back_ios, color: colors.textPrimary),
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Text(
                      appBarTitle, // Use dynamic app bar title
                      style: context.theme.textTheme.headlineLarge?.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                      width:
                          72), // Add SizedBox to balance the left side (approx icon width + padding)
                ],
              ),
              const SizedBox(height: 12),
              // Top Amount Card
              Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: colors.bgB0, // Assuming a white card background
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor:
                          payment.iconBackgroundColor, // Use dynamic color
                      child: SvgPicture.asset(
                        payment.icon, // Use dynamic icon path
                        height: 30, // Match previous size
                        width: 30, // Match previous size
                        colorFilter: ColorFilter.mode(
                            colors.textWhite, BlendMode.srcIn), // Apply color
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '${payment.amount} ${payment.currency}', // Use dynamic amount and currency
                      style: fontTheme.heading1Bold, // Large bold text
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$ ${payment.amount * 0.96}', // Assuming a simple conversion rate, replace with actual logic
                      style: fontTheme.textBaseRegular.copyWith(
                          fontSize: 16,
                          color:
                              colors.textSecondary), // Smaller secondary text
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Status and Details Section
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: colors.bgB0, // White card background
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Column(
                  children: [
                    _buildDetailRow(context, 'Status',
                        statusText, // Use dynamic status text
                        valueColor: statusColor, // Use dynamic status color
                        showBubble: true), // Example status, match image
                    const SizedBox(height: 16),
                    _buildDetailRow(context, 'Est. arrival date',
                        formattedDate), // Use dynamic formatted date
                    const SizedBox(height: 16),
                    _buildDetailRow(
                        context,
                        'Network',
                        payment.paymentNetwork.name
                            .toLowerCase(), // Pass network enum name as string
                        showNetworkIcon: true), // Example network, match image
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Invoice Details Section
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: colors.bgB0, // White card background
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow(context, 'Invoice',
                        '#INV-2025-001', // Invoice number not in Payment model, keeping placeholder or replace with actual data
                        showLinkIcon:
                            true), // Example invoice number, match image
                    const SizedBox(height: 16),
                    _buildDetailRow(
                        context, 'Title', payment.title), // Use dynamic title
                    const SizedBox(height: 16),
                    _buildDetailRow(context, 'Client',
                        'Adegboyega Oluwagbemiro'), // Client name not in Payment model, keeping placeholder or replace with actual data
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Timeline/Status History Section (Keeping static for now as timeline details are not in Payment model)
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: colors.bgB0, // White card background
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    // Timeline items - these would typically be dynamic
                    _buildTimelineItem(
                      context,
                      TimelineStatus.completed, // Status: Completed
                      'Invoice created and sent to client',
                      '20 April 2025, 04:40 PM',
                      isLast: false,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0), // Adjust padding to align with icon
                      child: DashedVerticalDivider(
                          height: 24, // Adjust height as needed for spacing
                          color:
                              colors.greenDefault // Green line after completed
                          ),
                    ),
                    _buildTimelineItem(
                      context,
                      TimelineStatus.current, // Status: Current
                      'Awaiting payment confirmation',
                      'Your client will get invoice access before\nit is due on 31 May 2025.',
                      isLast: false,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0), // Adjust padding to align with icon
                      child: DashedVerticalDivider(
                          height: 24, // Adjust height as needed for spacing
                          color:
                              colors.strokeSecondary // Grey line after current
                          ),
                    ),
                    _buildTimelineItem(
                      context,
                      TimelineStatus.future, // Status: Future
                      'Process your client payment',
                      '',
                      isLast: false,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0), // Adjust padding to align with icon
                      child: DashedVerticalDivider(
                          height: 24, // Adjust height as needed for spacing
                          color:
                              colors.strokeSecondary // Grey line after future
                          ),
                    ),
                    _buildTimelineItem(
                      context,
                      TimelineStatus.future, // Status: Future
                      'According to your invoice, funds should\nbe reflected in your balance on 31 May\n2025.',
                      '',
                      isLast: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value,
      {Color? valueColor,
      bool showBubble = false,
      bool showLinkIcon = false,
      bool showNetworkIcon = false}) {
    final colors = Theme.of(context).extension<AppColorExtension>()!;
    final fontTheme = Theme.of(context).extension<AppFontThemeExtension>()!;

    // Determine network text and icon
    String? networkIconAsset;
    String networkText = '';
    if (label == 'Network') {
      switch (value) {
        case 'ethereum':
          networkText = 'Ethereum';
          networkIconAsset = AppIcons.ethereumIcon; // Use SVG asset path
          break;
        case 'starknet':
          networkText = 'Starknet';
          networkIconAsset = AppIcons.starknetIcon; // Use SVG asset path
          break;
        case 'solana':
          networkText = 'Solana';
          networkIconAsset = AppIcons.solanaIcon; // Use SVG asset path
          break;
        case 'stellar':
          networkText = 'Stellar';
          networkIconAsset = AppIcons.stellar; // Use SVG asset path
          break;
        default:
          networkText = 'Unknown';
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: fontTheme.textSmRegular
              .copyWith(color: colors.textSecondary), // Grey text for label
        ),
        Row(
          children: [
            if (showNetworkIcon && networkIconAsset != null) ...[
              SvgPicture.asset(
                // Use SvgPicture.asset for SVG icons
                networkIconAsset,
                height: 16, // Adjust size as needed
                width: 16,
                // color: colors.blueDefault, // Example color, adjust as needed
              ),
              const SizedBox(width: 4),
            ],
            if (showBubble)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: valueColor?.withOpacity(0.1) ??
                      colors.brandFill, // Light background for bubble
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  value,
                  style: fontTheme.textSmRegular.copyWith(
                      color: valueColor ?? colors.brandDefault,
                      fontSize: 12), // Colored text for status
                ),
              )
            else
              Text(
                label == 'Network'
                    ? networkText
                    : value, // Use dynamic network text or original value
                style:
                    fontTheme.textBaseRegular, // Default text style for value
              ),
            if (showLinkIcon) ...[
              const SizedBox(width: 4),
              Icon(Icons.open_in_new,
                  color: colors.blueDefault, size: 16), // Example Link Icon
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildTimelineItem(BuildContext context, TimelineStatus status,
      String title, String subtitle,
      {required bool isLast}) {
    final colors = Theme.of(context).extension<AppColorExtension>()!;
    final fontTheme = Theme.of(context).extension<AppFontThemeExtension>()!;

    IconData icon;
    Color iconColor;
    Color lineColor = colors.strokeSecondary; // Default line color

    switch (status) {
      case TimelineStatus.completed:
        icon = Icons.check_circle;
        iconColor = colors.greenDefault;
        lineColor = colors.greenDefault; // Line after completed item is green
        break;
      case TimelineStatus.current:
        icon = Icons.schedule;
        iconColor = colors.orangeDefault;
        // Line after current item is grey (default)
        break;
      case TimelineStatus.future:
        icon = Icons.circle_outlined;
        iconColor = colors.grayTertiary;
        // Line after future item is grey (default)
        break;
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Icon(icon, color: iconColor, size: 24),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: fontTheme.textBaseMedium), // Bold title
                if (subtitle.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(subtitle,
                      style: fontTheme.textSmRegular.copyWith(
                          color: colors.textSecondary)), // Grey subtitle
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
