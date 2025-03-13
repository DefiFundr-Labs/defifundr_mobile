part of '../_home.dart';

class AmountDonateScreen extends StatefulWidget {
  final String campaignId;
  final String campaignName;
  final String campaignAddress;
  final String goal;
  const AmountDonateScreen({
    required this.campaignId,
    required this.goal,
    required this.campaignName,
    required this.campaignAddress,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _AmountDonateScreenState();
}

class _AmountDonateScreenState extends State<AmountDonateScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final TextEditingController _amountController = TextEditingController();
  final user = sl<AppCache>().getUserDetails();
  final double _availableBalance =
      double.parse(sl<AppCache>().getUserDetails().balance);
  final ValueNotifier<bool> _isAvailableGreaterThanAmount =
      ValueNotifier<bool>(false);
  final ValueNotifier<double> _exchangeRate = ValueNotifier<double>(0.0);
  final ValueNotifier<double> _currentRate = ValueNotifier<double>(0.0);

  @override
  void initState() {
    _amountController.addListener(_availableGreaterThanAmount);
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(
          microseconds: 2000,
        ));
    // animate to vibrate
    _animation = Tween<double>(begin: 1.0, end: 1.1).animate(
        CurvedAnimation(parent: _controller, curve: Curves.elasticInOut));
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    context.read<CurrentEthPriceBloc>().add(GetCurrentPriceEvent());
    context.read<CurrentEthPriceBloc>().stream.listen((state) {
      state.maybeWhen(
          orElse: () {},
          loaded: (data) {
            if (mounted) {
              setState(() {
                _currentRate.value = double.parse(data);
              });
            }
          });
    });
    super.didChangeDependencies();
  }

  double _exchangeRateDollarToEther() {
    if (mounted) {
      setState(() {
        _exchangeRate.value = _amountController.text.isEmpty
            ? 0.0
            : double.parse(_amountController.text) * _currentRate.value;
      });
    }
    return _exchangeRate.value;
  }

  _availableGreaterThanAmount() {
    if (mounted) {
      setState(() {
        if (_amountController.text.isEmpty ||
            double.parse(_amountController.text) == 0.0 ||
            double.parse(_amountController.text) < 0.0 ||
            double.parse(_amountController.text) == 0 ||
            _amountController.text == "0.00" ||
            _amountController.text == "" ||
            _amountController.text == "0.0" ||
            _amountController.text == "0.000" ||
            _amountController.text == "0.0000" ||
            _amountController.text == "0.") {
          _isAvailableGreaterThanAmount.value = false;
          return;
        } else if (double.parse(_amountController.text) >
            (_availableBalance - 0.001)) {
          _isAvailableGreaterThanAmount.value = false;
          return;
        } else {
          _isAvailableGreaterThanAmount.value = true;
          return;
        }
      });
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _controller.dispose();
    _isAvailableGreaterThanAmount.dispose();
    _exchangeRate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white200,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.sp),
        child: DeFiRaiseAppBar(
          title: AppTexts.amount2Donate,
          isBack: true,
        ),
      ),
      body: Column(
        children: [
          VerticalMargin(5),
          Expanded(
            child: SizedBox(
              width: context.screenWidth(0.8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.only(top: 15.sp),
                      child: Text(
                        "ETH",
                        style: Config.b3(context).copyWith(
                          fontSize: 14.sp,
                          color: AppColors.black100,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  HorizontalMargin(10),
                  ScaleTransition(
                    scale: _animation,
                    child: AutoSizeText(
                      maxFontSize: 50,
                      _amountController.text.isEmpty
                          ? '0.00'
                          : _amountController.text,
                      softWrap: true,
                      // stepGranularity: 0.4,
                      overflow: TextOverflow.fade,
                      style: Config.h1(context).copyWith(
                          color: _isAvailableGreaterThanAmount.value ||
                                  !_amountController.text.isNotEmpty ||
                                  _amountController.text == "0.00" ||
                                  _amountController.text == "0.0" ||
                                  _amountController.text == "0.000" ||
                                  _amountController.text == "0.0000" ||
                                  _amountController.text == "0." ||
                                  _amountController.text == "0"
                              ? AppColors.black100
                              : AppColors.errorColor,
                          fontSize: 60.sp,
                          decoration: _isAvailableGreaterThanAmount.value ||
                                  !_amountController.text.isNotEmpty ||
                                  _amountController.text == "0.00" ||
                                  _amountController.text == "0.000" ||
                                  _amountController.text == "0.0000" ||
                                  _amountController.text == "0.0" ||
                                  _amountController.text == "0." ||
                                  _amountController.text == "0"
                              ? TextDecoration.none
                              : TextDecoration.lineThrough,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
          VerticalMargin(1),
          AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return MaterialButton(
                  onPressed: () {
                    // Animate the button
                    _controller.forward();
                    // _availableBalance = _amountController.text;
                    HapticFeedback.mediumImpact();
                    SystemSound.play(SystemSoundType.alert);
                    setState(() {
                      if (_availableBalance == 0.0) {
                        return;
                      }
                      _amountController.text =
                          (_availableBalance - 0.001).toStringAsPrecision(4);
                    });
                  },
                  // shape: const CircleBorder(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: AppColors.black200,
                  elevation: 0.0,
                  padding: EdgeInsets.symmetric(horizontal: 10.sp),
                  minWidth: 20.sp,
                  // height: 35.0,
                  child: Padding(
                    padding: EdgeInsets.all(8.sp),
                    child: Text(
                      'Use Max',
                      style: Config.b1(context).copyWith(
                        fontSize: 8.sp,
                        color: AppColors.white100,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }),
          VerticalMargin(30),
          Text(
            AppTexts.availableBalance.toUpperCase(),
            style: Config.b3(context).copyWith(
              fontSize: 11.sp,
              color: AppColors.grey300,
              fontWeight: FontWeight.w100,
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                _availableBalance.toStringAsFixed(4),
                style: Config.b1(context).copyWith(
                  fontSize: 19.sp,
                  color: AppColors.black100,
                  fontWeight: FontWeight.bold,
                ),
              ),
              HorizontalMargin(2),
              Text(
                'ETH',
                style: Config.b1(context).copyWith(
                  fontSize: 19.sp,
                  color: AppColors.black100,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          VerticalMargin(2),
          BlocListener<CurrentEthPriceBloc, CurrentEthPriceState>(
            listener: (context, state) {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'USD ${_exchangeRateDollarToEther().toStringAsFixed(2)}',
                  style: Config.b2(context).copyWith(
                    fontSize: 14.sp,
                    color: AppColors.secondaryColor,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ],
            ),
          ),
          // Spacer(),
          VerticalMargin(20),
          Align(
              alignment: Alignment.bottomCenter,
              child: CustomKeyboard(
                onTap: (value) {
                  if (mounted) {
                    setState(() {
                      // if the length is greater 8 do nothing
                      if (_amountController.text.length > 8) {
                        return;
                      } else if (_amountController.text.isEmpty &&
                          value == '.') {
                        _amountController.text = '0$value';
                      }
                      // only one . is allowed
                      else if (_amountController.text.contains('.') &&
                          value == '.') {
                        return;
                      }
                      // if the first character is 0 and the second is not . add . + new value
                      else if (_amountController.text.startsWith('0') &&
                          _amountController.text.length == 1 &&
                          value != '.') {
                        _amountController.text = value;
                      } else {
                        _amountController.text = _amountController.text + value;
                      }
                      _controller.reset();
                      _controller.forward();
                    });
                  }
                },
                onBackspaceTap: () {
                  if (mounted) {
                    setState(() {
                      _controller.reset();
                      _controller.forward();
                      if (_amountController.text.length > 1) {
                        _amountController.text = _amountController.text
                            .substring(0, _amountController.text.length - 1);
                      } else {
                        _amountController.clear();
                      }
                    });
                  }
                },
                onBackspaceLongPress: () {
                  if (mounted) {
                    setState(() {
                      _amountController.clear();
                    });
                  }
                },
              )),
          VerticalMargin(20),
          AppButton(
            text: AppTexts.proceed,
            isRounded: true,
            isActive: _isAvailableGreaterThanAmount.value,
            onTap: () {
              if (_isAvailableGreaterThanAmount.value &&
                  double.tryParse(_amountController.text)! <=
                      double.tryParse(widget.goal)!) {
                context.pushNamed(RouteConstants.donationConfirmation,
                    queryParameters: {
                      "amount": _amountController.text,
                      "campaignId": widget.campaignId.toString(),
                      "campaignName": widget.campaignName,
                      "address": widget.campaignAddress,
                      "amountInUsd": (_currentRate.value *
                              double.parse(_amountController.text))
                          .toString(),
                      "goal": widget.goal,
                    });
              } else if (double.tryParse(widget.goal)! >=
                  double.tryParse(_amountController.text)!) {
                // show snackbar
                context.showToast(
                  title: "Amount should be less than the goal",
                  context: context,
                  toastDurationInSeconds: 1,
                  isSuccess: false,
                );
              }
            },
            textColor: AppColors.white100,
            color: AppColors.black200,
          ),
          VerticalMargin(50),
        ],
      ),
    );
  }
}
