import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/design_system.dart';
import 'package:defifundr_mobile/core/extensions/l10n_extension.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/modules/more/presentation/widgets/app_language_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _langShownKey = 'onboarding_language_sho';

List<_OnboardingSlide> _buildSlides(BuildContext context) => [
      _OnboardingSlide(
        imagePath: Assets.images.onboardingImage.onboarding3.path,
        title: context.l10n.onboardingSlide1Title,
        subtitle: context.l10n.onboardingSlide1Subtitle,
      ),
      _OnboardingSlide(
        imagePath: Assets.images.onboardingImage.onboarding1.path,
        title: context.l10n.onboardingSlide2Title,
        subtitle: context.l10n.onboardingSlide2Subtitle,
      ),
      _OnboardingSlide(
        imagePath: Assets.images.onboardingImage.onboarding2.path,
        title: context.l10n.onboardingSlide3Title,
        subtitle: context.l10n.onboardingSlide3Subtitle,
      ),
    ];

@RoutePage()
class OnboardingIntroScreen extends StatefulWidget {
  const OnboardingIntroScreen({super.key});

  @override
  State<OnboardingIntroScreen> createState() => _OnboardingIntroScreenState();
}

class _OnboardingIntroScreenState extends State<OnboardingIntroScreen> {
  final _pageController = PageController();
  final _currentPage = ValueNotifier<int>(0);
  late List<_OnboardingSlide> _slides;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _showLanguageOnFirstLaunch());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _slides = _buildSlides(context);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _currentPage.dispose();
    super.dispose();
  }

  Future<void> _showLanguageOnFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(_langShownKey) ?? false) return;
    await prefs.setBool(_langShownKey, true);
    if (mounted) showAppLanguageBottomSheet(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const _Background(),
          PageView.builder(
            controller: _pageController,
            onPageChanged: (i) => _currentPage.value = i,
            itemCount: _slides.length,
            itemBuilder: (_, i) => _SlideWidget(slide: _slides[i]),
          ),
          ValueListenableBuilder<int>(
            valueListenable: _currentPage,
            builder: (_, page, __) =>
                _ProgressBar(current: page, total: _slides.length),
          ),
          const _BottomActions(),
        ],
      ),
    );
  }
}

class _Background extends StatelessWidget {
  const _Background();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColorDark.bgB0, AppColorDark.bgB3],
        ),
      ),
      child: const SizedBox.expand(),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.current, required this.total});

  final int current;
  final int total;

  @override
  Widget build(BuildContext context) {
    final white = context.theme.colors.contrastWhite;

    return Positioned(
      top: 60.h,
      left: 20.w,
      right: 20.w,
      child: Row(
        children: List.generate(total, (i) {
          return Expanded(
            child: Container(
              height: 4.h,
              margin: EdgeInsets.only(right: i < total - 1 ? 8.w : 0),
              decoration: BoxDecoration(
                color: i == current ? white : white.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _BottomActions extends StatelessWidget {
  const _BottomActions();

  @override
  Widget build(BuildContext context) {
    final white = context.theme.colors.contrastWhite;

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 30.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PrimaryButton(
              text: context.l10n.onboardingCreateAccount,
              onPressed: () =>
                  context.router.push(const CreateAccountRoute()),
            ),
            SizedBox(height: 4.h),
            GestureDetector(
              onTap: () => context.router.push(const LoginRoute()),
              child: SizedBox(
                width: double.infinity,
                height: 48.h,
                child: Center(
                  child: Text(
                    context.l10n.onboardingLogIn,
                    style: context.theme.fonts.textBaseMedium
                        .copyWith(color: white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SlideWidget extends StatelessWidget {
  const _SlideWidget({required this.slide});

  final _OnboardingSlide slide;

  @override
  Widget build(BuildContext context) {
    final white = context.theme.colors.contrastWhite;

    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 90.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
            child: Image.asset(
              slide.imagePath,
              height: 386.h,
              width: 300.w,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 24.h),
          SizedBox(
            width: 300.w,
            child: Column(
              children: [
                Text(
                  slide.title,
                  textAlign: TextAlign.center,
                  style: context.theme.fonts.heading2Bold
                      .copyWith(color: white),
                ),
                SizedBox(height: 8.h),
                Text(
                  slide.subtitle,
                  textAlign: TextAlign.center,
                  style: context.theme.fonts.textMdMedium
                      .copyWith(color: white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingSlide {
  const _OnboardingSlide({
    required this.imagePath,
    required this.title,
    required this.subtitle,
  });

  final String imagePath;
  final String title;
  final String subtitle;
}
