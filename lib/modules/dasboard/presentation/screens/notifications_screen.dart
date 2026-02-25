import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/design_system/color_extension/app_color_extension.dart';
import 'package:defifundr_mobile/core/design_system/font_extension/font_extension.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';
import 'package:defifundr_mobile/core/shared/common/appbar/appbar.dart';
import 'package:defifundr_mobile/modules/dasboard/data/models/notification_item.dart';
import 'package:defifundr_mobile/modules/dasboard/presentation/widgets/notification_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

@RoutePage()
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  List<NotificationItem> get _notifications => [
        NotificationItem(
          id: '1',
          title: 'Invoice notification title',
          description:
              'Lorem ipsum dolor sit amet consectetur. Commodo quam pulvinar ut adipiscing.',
          dateTime: DateTime(2025, 4, 21, 16, 40),
          type: NotificationType.invoice,
          actionLabel: 'View Invoice',
        ),
        NotificationItem(
          id: '2',
          title: 'Contract notification title',
          description:
              'Lorem ipsum dolor sit amet consectetur. Commodo quam pulvinar ut adipiscing.',
          dateTime: DateTime(2025, 4, 20, 16, 40),
          type: NotificationType.contract,
          actionLabel: 'View Contract',
        ),
        NotificationItem(
          id: '3',
          title: 'Time off notification title',
          description:
              'Lorem ipsum dolor sit amet consectetur. Commodo quam pulvinar ut adipiscing.',
          dateTime: DateTime(2025, 4, 20, 16, 40),
          type: NotificationType.timeOff,
          isRead: true,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;
    final notifications = _notifications;

    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size(context.screenWidth(), 60),
        child: DeFiRaiseAppBar(
          centerTitle: true,
          title: 'Notifications',
          isBack: true,
          actions: [],
          textStyle: context.theme.fonts.heading3SemiBold.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: notifications.isEmpty
                ? _buildEmptyState(context, colors, fonts)
                : _buildNotificationsList(
                    context, colors, fonts, notifications),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, AppColorExtension colors,
      AppFontThemeExtension fonts) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    Assets.icons.emptyState,
                    width: 200,
                    height: 200,
                  ),
                  Text(
                    'No notifications yet.',
                    style: fonts.textMdSemiBold.copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                  ),
                  Text(
                    'Your updates will show up here when they\'re ready.',
                    textAlign: TextAlign.center,
                    style: fonts.textMdRegular.copyWith(
                      color: colors.textSecondary,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationsList(
    BuildContext context,
    AppColorExtension colors,
    AppFontThemeExtension fonts,
    List<NotificationItem> notifications,
  ) {
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    final grouped = <String, List<NotificationItem>>{};
    for (final n in notifications) {
      final key = DateFormat('dd MMMM yyyy').format(n.dateTime);
      grouped.putIfAbsent(key, () => []).add(n);
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      itemCount: grouped.length,
      itemBuilder: (context, index) {
        final dateLabel = grouped.keys.elementAt(index);
        final items = grouped[dateLabel]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Divider(
                  color: colors.strokePrimary,
                )),
                Text(
                  dateLabel,
                  style: fonts.textSmMedium.copyWith(
                    color: colors.textTertiary,
                    fontSize: 12.sp,
                  ),
                ),
                Expanded(
                    child: Divider(
                  color: colors.strokePrimary,
                )),
              ],
            ),
            SizedBox(height: 20.h),
            Container(
              padding: EdgeInsets.all(8.sp),
              decoration: BoxDecoration(
                color: isLightMode ? colors.bgB0 : colors.bgB1,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: items
                    .map(
                      (item) => NotificationCard(notification: item),
                    )
                    .toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
