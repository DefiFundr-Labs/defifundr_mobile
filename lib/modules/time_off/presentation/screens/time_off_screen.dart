import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common/appbar/appbar.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/utils/ellipsify.dart';
import 'package:defifundr_mobile/modules/time_tracking/data/models/contract.dart';
import 'package:defifundr_mobile/modules/time_off/data/models/time_off.dart';
import 'package:defifundr_mobile/modules/time_off/presentation/widgets/time_off_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';
import '../../data/models/contract.dart';
import '../widgets/balance_card.dart';
import '../widgets/contract_selection_bottom_sheet.dart';
import '../widgets/time_off_card_container.dart';

@RoutePage()
class TimeOffScreen extends StatefulWidget {
  final String contractTitle;

  const TimeOffScreen({
    Key? key,
    required this.contractTitle,
  }) : super(key: key);

  @override
  State<TimeOffScreen> createState() => _TimeOffScreenState();
}

class _TimeOffScreenState extends State<TimeOffScreen> {
  late String selectedContractTitle;
  late String selectedContractId;
  late TextEditingController contractController;

  final List<TimeOffContract> availableContracts = [
    TimeOffContract(
      id: '1',
      title: 'NovaWorks Marketing Campaign',
      type: ContractType.fixedRate,
      paymentAmount: '',
      paymentFrequency: '',
      isActive: true,
    ),
    TimeOffContract(
      id: '2',
      title: 'Quikdash Mobile & Web App Redesign',
      type: ContractType.fixedRate,
      paymentAmount: '',
      paymentFrequency: '',
      isActive: true,
    ),
    TimeOffContract(
      id: '3',
      title: 'Weave Finance Mobile & Web App Redesign',
      type: ContractType.fixedRate,
      paymentAmount: '',
      paymentFrequency: '',
      isActive: true,
    ),
    TimeOffContract(
      id: '4',
      title: 'DefiFundr Mobile & Web App Redesign',
      type: ContractType.fixedRate,
      paymentAmount: '',
      paymentFrequency: '',
      isActive: true,
    ),
  ];

  final List<TimeOffRequest> allTimeOffs = [
    TimeOffRequest(
      id: '1',
      startDate: DateTime(2025, 6, 3),
      endDate: DateTime(2025, 6, 7),
      days: 5,
      type: 'Sick leave',
      status: TimeOffStatus.pending,
      isPaid: true,
    ),
    TimeOffRequest(
      id: '2',
      startDate: DateTime(2025, 5, 20),
      endDate: DateTime(2025, 5, 22),
      days: 3,
      type: 'Personal leave',
      status: TimeOffStatus.approved,
      isPaid: false,
    ),
    TimeOffRequest(
      id: '3',
      startDate: DateTime(2025, 5, 1),
      endDate: DateTime(2025, 5, 5),
      days: 5,
      type: 'Vacation',
      status: TimeOffStatus.rejected,
      isPaid: true,
    ),
    TimeOffRequest(
      id: '4',
      startDate: DateTime(2025, 4, 10),
      endDate: DateTime(2025, 4, 15),
      days: 6,
      type: 'Personal leave',
      status: TimeOffStatus.used,
      isPaid: false,
    ),
    TimeOffRequest(
      id: '5',
      startDate: DateTime(2025, 3, 31),
      endDate: DateTime(2025, 4, 6),
      days: 11,
      type: 'Sick leave',
      status: TimeOffStatus.used,
      isPaid: false,
    ),
    TimeOffRequest(
      id: '6',
      startDate: DateTime(2025, 3, 15),
      endDate: DateTime(2025, 3, 20),
      days: 6,
      type: 'Family emergency',
      status: TimeOffStatus.used,
      isPaid: false,
    ),
    TimeOffRequest(
      id: '7',
      startDate: DateTime(2025, 3, 6),
      endDate: DateTime(2025, 3, 10),
      days: 5,
      type: 'Personal leave',
      status: TimeOffStatus.rejected,
      isPaid: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    selectedContractTitle = widget.contractTitle;
    selectedContractId = '2';
    contractController = TextEditingController(text: selectedContractTitle);
  }

  @override
  void dispose() {
    contractController.dispose();
    super.dispose();
  }

  void _showContractSelection() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ContractSelectionBottomSheet(
        contracts: availableContracts,
        selectedContractId: selectedContractId,
        onContractSelected: (contract) {
          setState(() {
            selectedContractTitle = contract.title;
            selectedContractId = contract.id;
            contractController.text = contract.title;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final upcomingTimeOffs = allTimeOffs.take(2).toList();
    final historyTimeOffs = allTimeOffs.skip(2).toList();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(context.screenWidth(), 60),
        child: DeFiRaiseAppBar(
          centerTitle: true,
          textStyle: context.theme.fonts.heading3SemiBold,
          isBack: true,
          title: 'Time off',
          actions: [],
        ),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: _showContractSelection,
            child: Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
              decoration: BoxDecoration(
                color: context.theme.colors.bgB0,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: context.theme.colors.strokeSecondary),
              ),
              child: Row(
                children: [
                  Text(
                    'Showing for: ',
                    style: context.theme.fonts.textMdRegular.copyWith(
                      color: context.theme.colors.textSecondary,
                    ),
                  ),
                  Expanded(
                    child: Text(
                        ellipsify(word: selectedContractTitle, maxLength: 25),
                        style: context.theme.fonts.textMdMedium),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: context.theme.colors.textSecondary,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    BalanceCard(
                      title: 'Paid time off balance',
                      days: 12,
                      onViewDetails: () {},
                    ),
                    const SizedBox(height: 16),
                    BalanceCard(
                      title: 'Unpaid time off balance',
                      days: 12,
                      onViewDetails: () {},
                      onTap: () {
                        context.router.push(UnpaidTimeOffBalanceRoute());
                      },
                    ),
                    const SizedBox(height: 24),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Upcoming time off',
                          style: context.theme.fonts.textMdSemiBold),
                    ),
                    const SizedBox(height: 8),
                    if (upcomingTimeOffs.isEmpty)
                      TimeOffCardContainer(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: context.theme.colors.textSecondary,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'No upcoming time off event',
                              style: context.theme.fonts.textMdRegular.copyWith(
                                color: context.theme.colors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      TimeOffCardContainer(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        child: Column(
                          children:
                              upcomingTimeOffs.asMap().entries.map((entry) {
                            final idx = entry.key;
                            final item = entry.value;
                            return Column(
                              children: [
                                TimeOffItem(timeOff: item),
                                if (idx != upcomingTimeOffs.length - 1)
                                  const SizedBox(height: 16),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Text('Time off history',
                            style: context.theme.fonts.textMdSemiBold),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            context.router.push(const TimeOffHistoryRoute());
                          },
                          child: Row(
                            children: [
                              Text(
                                'See all',
                                style: context.theme.fonts.textSmSemiBold
                                    .copyWith(
                                        color: context
                                            .theme.colors.brandDefaultContrast),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color:
                                    context.theme.colors.brandDefaultContrast,
                                size: 12,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (historyTimeOffs.isEmpty)
                      TimeOffCardContainer(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 24.h),
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              Assets.icons.emptyrecords,
                              width: 60,
                              height: 60,
                            ),
                            const SizedBox(height: 16),
                            Text('No time off records yet',
                                style: context.theme.fonts.textMdSemiBold),
                            Text(
                              'When you apply for and take time off, it’ll show up here.',
                              textAlign: TextAlign.center,
                              style: context.theme.fonts.textMdRegular.copyWith(
                                color: context.theme.colors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      TimeOffCardContainer(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 16.h),
                        child: Column(
                          children:
                              historyTimeOffs.asMap().entries.map((entry) {
                            final idx = entry.key;
                            final item = entry.value;
                            return Column(
                              children: [
                                TimeOffItem(timeOff: item),
                                if (idx != historyTimeOffs.length - 1)
                                  const SizedBox(height: 16),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16.0),
            child: PrimaryButton(
              onPressed: () =>
                  context.router.push(const NewTimeOffRequestRoute()),
              text: 'Request time off',
            ),
          ),
        ],
      ),
    );
  }
}
