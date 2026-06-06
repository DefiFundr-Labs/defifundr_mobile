import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/modules/time_off/data/models/time_off.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/time_off_card_container.dart';
import '../widgets/time_off_item.dart';
import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common/appbar/appbar.dart';

@RoutePage()
class UnpaidTimeOffBalanceScreen extends StatelessWidget {
  final List<TimeOffRequest> upcomingTimeOff = [
    TimeOffRequest(
      id: '1',
      startDate: DateTime(2025, 5, 20),
      endDate: DateTime(2025, 5, 22),
      days: 3,
      type: 'Personal leave',
      status: TimeOffStatus.approved,
      isPaid: false,
    ),
  ];

  final List<TimeOffRequest> pastTimeOff = [
    TimeOffRequest(
      id: '2',
      startDate: DateTime(2025, 4, 10),
      endDate: DateTime(2025, 4, 15),
      days: 6,
      type: 'Personal leave',
      status: TimeOffStatus.used,
      isPaid: false,
    ),
    TimeOffRequest(
      id: '3',
      startDate: DateTime(2025, 3, 31),
      endDate: DateTime(2025, 4, 6),
      days: 11,
      type: 'Sick leave',
      status: TimeOffStatus.used,
      isPaid: false,
    ),
    TimeOffRequest(
      id: '4',
      startDate: DateTime(2025, 3, 15),
      endDate: DateTime(2025, 3, 20),
      days: 6,
      type: 'Family emergency',
      status: TimeOffStatus.used,
      isPaid: false,
    ),
  ];

  UnpaidTimeOffBalanceScreen({Key? key}) : super(key: key);

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
          title: 'Unpaid time off balance',
          actions: [],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TimeOffCardContainer(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    Assets.icons.calendar,
                    color: context.theme.colors.brandDefaultContrast,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Balance',
                    style: context.theme.fonts.textMdRegular.copyWith(
                      color: context.theme.colors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '74 days',
                    style: context.theme.fonts.heading3Bold,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TimeOffCardContainer(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          Assets.icons.calendar,
                          color: context.theme.colors.brandDefaultContrast,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Allowance',
                          style: context.theme.fonts.textSmRegular.copyWith(
                            color: context.theme.colors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '100 days',
                          style: context.theme.fonts.textLgBold,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TimeOffCardContainer(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.event_available_outlined,
                          color: context.theme.colors.greenDefault,
                          size: 20,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Used / scheduled',
                          style: context.theme.fonts.textSmRegular.copyWith(
                            color: context.theme.colors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '26 days',
                          style: context.theme.fonts.textLgBold,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Upcoming time off events',
              style: context.theme.fonts.textMdSemiBold,
            ),
            const SizedBox(height: 8),
            TimeOffCardContainer(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: upcomingTimeOff.asMap().entries.map((entry) {
                  final idx = entry.key;
                  final item = entry.value;
                  return Column(
                    children: [
                      TimeOffItem(timeOff: item),
                      if (idx != upcomingTimeOff.length - 1)
                        const SizedBox(height: 16),
                    ],
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Past time off events',
              style: context.theme.fonts.textMdSemiBold,
            ),
            const SizedBox(height: 8),
            TimeOffCardContainer(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: pastTimeOff.asMap().entries.map((entry) {
                  final idx = entry.key;
                  final item = entry.value;
                  return Column(
                    children: [
                      TimeOffItem(timeOff: item),
                      if (idx != pastTimeOff.length - 1)
                        const SizedBox(height: 16),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
