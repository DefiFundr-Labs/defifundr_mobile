import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/enums/app_text_field_enums.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/shared/common/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/common/snackbar/app_snackbar.dart';
import 'package:defifundr_mobile/core/shared/common/textfield/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class RequestTerminationScreen extends StatefulWidget {
  final String clientName;
  final String noticePeriod;

  const RequestTerminationScreen({
    Key? key,
    required this.clientName,
    required this.noticePeriod,
  }) : super(key: key);

  @override
  State<RequestTerminationScreen> createState() =>
      _RequestTerminationScreenState();
}

class _RequestTerminationScreenState extends State<RequestTerminationScreen> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _explanationController = TextEditingController();

  DateTime? selectedDate;

  final List<String> reasons = [
    'Project completed',
    'Mutual agreement',
    'Performance issues',
    'Budget constraints',
    'Change in business direction',
    'Other',
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: context.theme.colors.brandDefault,
              onPrimary: context.theme.colors.contrastWhite,
              onSurface: context.theme.colors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        _dateController.text = _formatDate(picked);
      });
    }
  }

  void _submitRequest() {
    if (selectedDate != null &&
        _reasonController.text.isNotEmpty &&
        _explanationController.text.isNotEmpty) {
      showModalBottomSheet(
        context: context,
        isDismissible: false,
        enableDrag: false,
        backgroundColor: Colors.transparent,
        builder: (context) => _TerminationSuccessBottomSheet(
          onDone: () {
            context.router.maybePop();
            context.router.maybePop();
          },
        ),
      );
    } else {
      AppSnackbar.showError(context, 'Please fill in all required fields');
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    final months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${date.day} ${months[date.month]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;

    return Scaffold(
      backgroundColor: colors.bgB1,
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 60),
        child: DeFiRaiseAppBar(
          centerTitle: true,
          textStyle: fonts.heading3SemiBold,
          isBack: true,
          title: '',
          actions: const [],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Request Termination',
                    style: fonts.heading2Bold.copyWith(
                      color: colors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'You\'re about to request termination for this contract. Please provide a reason for this request.',
                    style: fonts.textMdRegular.copyWith(
                      color: colors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12.sp),
                    decoration: BoxDecoration(
                      color: colors.orangeFill,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: colors.orangeStroke,
                      ),
                    ),
                    child: Text.rich(
                      TextSpan(
                        style: fonts.textMdRegular.copyWith(
                          color: colors.textSecondary,
                        ),
                        children: [
                          const TextSpan(text: 'Your contract with '),
                          TextSpan(
                            text: widget.clientName,
                            style: fonts.textMdSemiBold.copyWith(
                              color: colors.textPrimary,
                            ),
                          ),
                          const TextSpan(text: ' has a '),
                          TextSpan(
                            text: widget.noticePeriod,
                            style: fonts.textMdSemiBold.copyWith(
                              color: colors.textPrimary,
                            ),
                          ),
                          const TextSpan(text: ' notice period.'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  AppTextField(
                    controller: _dateController,
                    hintText: 'Proposed termination date',
                    readOnly: true,
                    onTap: () => _selectDate(context),
                    suffixType: SuffixType.customIcon,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: SvgPicture.asset(
                        Assets.icons.calendar,
                        colorFilter: ColorFilter.mode(
                          colors.textSecondary,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  AppTextField(
                    controller: _reasonController,
                    labelText: 'Termination reason',
                  ),
                  SizedBox(height: 20.h),
                  AppTextField(
                    controller: _explanationController,
                    hintText: 'Explanation for the reason above',
                    maxLine: 6,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Please provide details such as specific examples of the reason above.',
                    style: fonts.textSmRegular.copyWith(
                      color: colors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'Attachment (Optional)',
                    style: fonts.textMdMedium.copyWith(
                      color: colors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  GestureDetector(
                    onTap: () {},
                    child: PrimaryButton(
                      borderColor: context.theme.colors.brandStroke,
                      text: 'Click to upload',
                      onPressed: () {},
                      borderRadius: BorderRadius.circular(8.r),
                      color: context.theme.colors.brandFill,
                      textColor: context.theme.colors.brandDefaultContrast,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  SizedBox(
                    width: context.screenWidth(),
                    child: Text.rich(
                      TextSpan(
                        style: fonts.textSmRegular.copyWith(
                          color: colors.textSecondary,
                        ),
                        children: [
                          const TextSpan(text: 'Supported formats: '),
                          TextSpan(
                            text: 'JPG, PNG, HEIC or PDF.',
                            style: fonts.textSmMedium.copyWith(
                              color: colors.textPrimary,
                            ),
                          ),
                          const TextSpan(text: ' Use '),
                          TextSpan(
                            text: '.ZIP',
                            style: fonts.textSmMedium.copyWith(
                              color: colors.textPrimary,
                            ),
                          ),
                          const TextSpan(
                              text: ' to upload multiple documents.'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
            child: PrimaryButton(
              onPressed: _submitRequest,
              text: 'Request termination',
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _dateController.dispose();
    _reasonController.dispose();
    _explanationController.dispose();
    super.dispose();
  }
}

class _TerminationSuccessBottomSheet extends StatelessWidget {
  final VoidCallback onDone;

  const _TerminationSuccessBottomSheet({required this.onDone});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;

    return Container(
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
                  child: SvgPicture.asset(Assets.icons.termination,
                      height: 48.h, width: 48.w)),
            ),
            SizedBox(height: 16.h),
            Text(
              'Termination requested',
              style: fonts.heading2Bold.copyWith(
                color: colors.textPrimary,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'An email has been sent for your request to be reviewed.',
              textAlign: TextAlign.center,
              style: fonts.textMdRegular.copyWith(
                color: colors.textSecondary,
              ),
            ),
            SizedBox(height: 32.h),
            PrimaryButton(
              onPressed: onDone,
              text: 'Done',
            ),
          ],
        ),
      ),
    );
  }
}
