import 'package:defiraiser_mobile/core/global/constants/size.dart';
import 'package:defiraiser_mobile/core/global/themes/color_scheme.dart';
import 'package:defiraiser_mobile/core/shared/button/buttons.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class SelectDeadLinePicker extends StatefulWidget {
  const SelectDeadLinePicker({
    super.key,
  });

  @override
  State<SelectDeadLinePicker> createState() =>
      _SelectPostCategoryBottomSheetSheetState();
}

class _SelectPostCategoryBottomSheetSheetState
    extends State<SelectDeadLinePicker> {
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    setState(() {
      selectedDate = DateTime.now();
    });
    super.initState();
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      selectedDate = args.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.55,
        decoration: const BoxDecoration(
          color: AppColors.white100,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 48,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE3E9F2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ],
              ),
              const VerticalMargin(24),
              // Container(
              //   height: 300,
              //   decoration: BoxDecoration(
              //     color: AppColors.white100,
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   child: ScrollDatePicker(
              //     selectedDate: selectedDate,
              //     // minimumDate: minDate,
              //     // start from today to 10 years later
              //     minimumDate: DateTime(now.year + 1, now.month, now.day),
              //     scrollViewOptions: DatePickerScrollViewOptions(
              //       day: ScrollViewDetailOptions(
              //           margin: const EdgeInsets.symmetric(horizontal: 20),
              //           selectedTextStyle: Config.b1(context)
              //               .copyWith(color: AppColors.black100),
              //           textStyle: Config.b1(context)
              //               .copyWith(color: AppColors.black100)),
              //       month: ScrollViewDetailOptions(
              //           selectedTextStyle: Config.b1(context)
              //               .copyWith(color: AppColors.black100),
              //           textStyle: Config.b1(context)
              //               .copyWith(color: AppColors.black100)),
              //       year: ScrollViewDetailOptions(
              //           margin: const EdgeInsets.only(left: 20),
              //           selectedTextStyle: Config.b1(context)
              //               .copyWith(color: AppColors.black100),
              //           textStyle: Config.b1(context)
              //               .copyWith(color: AppColors.black100)),
              //     ),
              //     options: const DatePickerOptions(
              //       // backgroundColor: AppColors.g,
              //       diameterRatio: 1.5,
              //       isLoop: false,
              //     ),
              //     locale: const Locale('en'),
              //     onDateTimeChanged: (DateTime value) {
              //       setState(() => selectedDate = value);
              //     },
              //   ),
              // ),
              SfDateRangePicker(
                onSelectionChanged: _onSelectionChanged,
                selectionMode: DateRangePickerSelectionMode.single,
                // prevent date before today
                minDate: DateTime.now(),
                // show month slider
                showNavigationArrow: true,
              ),
              const VerticalMargin(40),
              AppButton(
                  text: 'Continue',
                  isActive: true,
                  textColor: AppColors.white100,
                  color: AppColors.black100,
                  onTap: () {
                    print(selectedDate);
                    Navigator.of(context).pop(selectedDate);
                  })
            ]));
  }
}
