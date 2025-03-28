// ignore_for_file: deprecated_member_use

import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/constants/fonts.dart';
import 'package:defifundr_mobile/core/shared/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/themes/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  int currentIndex = 0;
  late PageController _pageController;
  List<OnboardModel> screens = <OnboardModel>[
    OnboardModel(
      bgImage: AppAssets.onBoardingBg1,
      title: "Pay anyone,\nAnywhere.",
      text:
          "Experience Fast, Secure Crypto & Fiat Payroll & Invoicing with Defifundr",
    ),
    OnboardModel(
        bgImage: AppAssets.onBoardingBg1,
        text:
            "Set up automated payroll schedules and let our system handle timely, secure payouts in fiat or crypto.",
        img: AppAssets.onBoardingFrame1,
        title: "Pay on Time, Every Time"),
    OnboardModel(
        bgImage: AppAssets.onBoardingBg2,
        text:
            "Smart contracts ensure tamper-proof payments, reducing disputes and ensuring full transparency.",
        img: AppAssets.onBoardingFrame2,
        title: "Secure & Transparent Transactions"),
    OnboardModel(
        bgImage: AppAssets.onBoardingBg2,
        text:
            "Get notified about salary payouts, invoice approvals, and compliance updates instantly.",
        img: AppAssets.onBoardingFrame3,
        title: "Instant Notifications & Compliance Alerts"),
  ];

  @override
  void initState() {
    _pageController = PageController(
      initialPage: 0,
    );
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(currentIndex == 0
                    ? AppAssets.onBoardingBg1
                    : AppAssets.onBoardingBg2))),
        child: Column(
          children: [
            SizedBox(height: 70.h),
            ProgressIndicatorWidget(
              currentIndex: currentIndex,
              totalScreens: screens.length,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18),
              child: Container(
                decoration: BoxDecoration(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(currentIndex == 0
                        ? AppAssets.onBoardingLogoWhite
                        : AppAssets.onBoardingLogo),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.white100.withOpacity(0.24)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "For Freelancers",
                            style: DefiFundrFonts.h2(context).copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                                color: currentIndex == 0
                                    ? AppColors.white100
                                    : null),
                          ),
                          2.sbW,
                          Center(
                              child: SvgPicture.asset(
                            AppAssets.arrowRight,
                            color:
                                currentIndex == 0 ? AppColors.white100 : null,
                          ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                  itemCount: screens.length,
                  controller: _pageController,
                  onPageChanged: (int index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 1, child: Container()),
                          if (screens[index].img != null)
                            Center(
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Image.asset(screens[index].img!)),
                            ),
                          Expanded(flex: 1, child: Container()),
                          if (screens[index].title != null)
                            Text(
                              screens[index].title!,
                              textAlign: TextAlign.left,
                              style: DefiFundrFonts.h2(context).copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: currentIndex == 0
                                      ? AppColors.white100
                                      : AppColors.textBlack,
                                  fontSize: 31.sp),
                            ),
                          12.0.sbH,
                          if (screens[index].text != null)
                            Text(
                              screens[index].text!,
                              textAlign: TextAlign.left,
                              style: DefiFundrFonts.b2(context).copyWith(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: currentIndex == 0
                                      ? AppColors.white100
                                      : AppColors.secondaryTextColor),
                            ),
                        ],
                      ),
                    );
                  }),
            ),
            22.sbH,
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: currentIndex == 0 ? 16.w : 32.w),
              child: AppButton(
                color: currentIndex == 0
                    ? AppColors.white100
                    : AppColors.textBlack,
                textColor: currentIndex == 0
                    ? AppColors.textBlack
                    : AppColors.white100,
                text: currentIndex == 3 ? "Get Started" : "Next",
                onTap: () {
                  if (currentIndex != screens.length - 1) {
                    _pageController.animateToPage(currentIndex + 1,
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeIn);
                  }
                },
              ),
            ),
            50.sbH
          ],
        ),
      ),
    );
  }
}

extension WidgetExt on num {
  Widget get sbH => SizedBox(height: toDouble());
  Widget get sbW => SizedBox(width: toDouble());
}

class OnboardModel {
  String? img;
  String? text;
  String? title;
  String? bgImage;
  OnboardModel({this.img, this.text, this.title, this.bgImage});
}

class ProgressIndicatorWidget extends StatelessWidget {
  final int currentIndex;
  final int totalScreens;

  const ProgressIndicatorWidget({
    super.key,
    required this.currentIndex,
    required this.totalScreens,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 5.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            totalScreens,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 2.0),
              width: MediaQuery.of(context).size.width /
                  4.2,
              height: 5.0,
              decoration: BoxDecoration(
                color: index <= currentIndex
                    ? (currentIndex == 0 ? Colors.white : Colors.black)
                    : Colors.grey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
