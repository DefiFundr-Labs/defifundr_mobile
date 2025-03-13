import 'dart:io';

import 'package:defiraiser_mobile/core/global/constants/app_icons.dart';
import 'package:defiraiser_mobile/core/global/constants/app_texts.dart';
import 'package:defiraiser_mobile/core/global/constants/size.dart';
import 'package:defiraiser_mobile/core/global/themes/color_scheme.dart';
import 'package:defiraiser_mobile/core/shared/appbar/appbar.dart';
import 'package:defiraiser_mobile/core/shared/button/buttons.dart';
import 'package:defiraiser_mobile/core/shared/custom_tooast/custom_tooast.dart';
import 'package:defiraiser_mobile/core/shared/textfield/textfield.dart';
import 'package:defiraiser_mobile/core/utils/loading_overlay.dart';
import 'package:defiraiser_mobile/features/donation/presentation/state/create_donation/bloc/create_donation_bloc.dart';
import 'package:defiraiser_mobile/features/donation/presentation/widget/select_category_widget.dart';
import 'package:defiraiser_mobile/features/donation/presentation/widget/select_dead_line_widget.dart';
import 'package:defiraiser_mobile/features/home/domain/entities/campaign_categories_entity/campaign_category_entities.dart';
import 'package:defiraiser_mobile/features/home/presentation/_home.dart';
import 'package:defiraiser_mobile/features/home/presentation/state/get_current_eth_price_bloc/bloc/current_eth_price_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:images_picker/images_picker.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CreateDonationScreen extends StatefulWidget {
  const CreateDonationScreen({super.key});

  @override
  State<StatefulWidget> createState() => _DonationScreenViewState();
}

class _DonationScreenViewState extends State<CreateDonationScreen>
    with SingleTickerProviderStateMixin, LoadingOverlayMixin {
  OverlayEntry? _overlayEntry;
  late AnimationController _controller;
  final RefreshController _refreshController1 =
      RefreshController(initialRefresh: false);
  final TextEditingController _campaignNameController = TextEditingController();
  final TextEditingController _campaignDescController = TextEditingController();
  final TextEditingController _selectedCategory = TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();
  final TextEditingController _campaignGoalController = TextEditingController();
  final ValueNotifier<double> _currentRate = ValueNotifier<double>(0.0);
  final ValueNotifier<double> _exchangeRate = ValueNotifier<double>(0.0);
  final ValueNotifier<bool> _isEnabled = ValueNotifier<bool>(false);
  // selected date
  DateTime? _selectedDate;
  final format = NumberFormat("#,##0.00", "en_US");

  final FocusNode _nameNode = FocusNode();
  final FocusNode _descNode = FocusNode();
  final FocusNode _goalNode = FocusNode();
  final FocusNode _categoryNode = FocusNode();
  final FocusNode _deadlineNode = FocusNode();

  var formKey = GlobalKey<FormState>();
  bool autoValidate = false;

  double _exchangeRateDollarToEther() {
    if (mounted) {
      setState(() {
        _exchangeRate.value = _campaignGoalController.text.isEmpty
            ? 0.0
            : (double.parse(_campaignGoalController.text
                        .replaceAll('ETH', '')
                        .replaceAll(',', '')
                        .replaceAll('.', '')) /
                    10000) *
                _currentRate.value;
      });
    }
    return _exchangeRate.value;
  }

  @override
  void initState() {
    setState(() {
      _campaignNameController.addListener(_checkChangedConfrim);
      _campaignDescController.addListener(_checkChangedConfrim);
      _campaignGoalController.addListener(_checkChangedConfrim);
      _selectedCategory.addListener(_checkChangedConfrim);
      _deadlineController.addListener(_checkChangedConfrim);
    });

    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _controller.forward();
    super.initState();
  }

  @override
  didChangeDependencies() {
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

  _checkChangedConfrim() {
    setState(() {
      _isEnabled.value = _campaignNameController.text.isNotEmpty &&
          _campaignDescController.text.isNotEmpty &&
          _campaignGoalController.text.isNotEmpty &&
          _selectedCategory.text.isNotEmpty &&
          images.isNotEmpty &&
          _deadlineController.text.isNotEmpty;
    });
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(context.screenWidth(), 60),
        child: DeFiRaiseAppBar(
          isBack: true,
          title: AppTexts.createDonation,
          actions: [],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: formKey,
          autovalidateMode: autoValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: ListView(
            shrinkWrap: true,
            children: [
              VerticalMargin(20),
              AppTextField(
                controller: _campaignNameController,
                hintText: AppTexts.campaignName,
                inputType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                focusNode: _nameNode,
                textInputAction: TextInputAction.next,
              ),
              VerticalMargin(20),
              AppTextField(
                controller: _campaignDescController,
                hintText: AppTexts.campaignDesc,
                inputType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                focusNode: _descNode,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  return value!.length < 80
                      ? value.isEmpty
                          ? null
                          : 'Description must be greater than 80 characters'
                      : null;
                },
              ),
              VerticalMargin(20),
              AppTextField(
                controller: _campaignGoalController,
                hintText: AppTexts.campaignGoal,
                inputFormatters: [
                  // FilteringTextInputFormatter.allow(
                  //     RegExp(r'(^\d*[\.\,]?\d{0,10})')),
                  // always add a decimal to the end of the input if it's not there
                  // CurrencyTextInputFormatter(

                  // name: '',
                  // decimalDigits: 4,
                  // symbol: 'ETH  ',
                  // locale: 'en_US',
                  // ),
                ],
                inputType: TextInputType.numberWithOptions(decimal: true),
                onChanged: (value) {
                  _exchangeRateDollarToEther();
                },
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset(
                    AppIcons.ether,
                    width: 10,
                    height: 10,
                    color: AppColors.grey200,
                  ),
                ),
                focusNode: _goalNode,
                textInputAction: TextInputAction.next,
              ),
              BlocListener<CurrentEthPriceBloc, CurrentEthPriceState>(
                listener: (context, state) {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: context.screenWidth() - 50,
                      child: Text(
                        'USD ${format.format(_exchangeRateDollarToEther())}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Config.b2(context).copyWith(
                          fontSize: 14.0,
                          color: AppColors.secondaryColor,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              VerticalMargin(10),
              AppTextField(
                controller: _selectedCategory,
                hintText: AppTexts.selectCategory,
                inputType: TextInputType.text,
                label: AppTexts.selectCategory,
                textCapitalization: TextCapitalization.words,
                readOnly: true,
                onTap: () {
                  _pickModel(context).then((value) {
                    if (value != null) {
                      setState(() {
                        _selectedCategory.text = value.name;
                      });
                    }
                  });
                },
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset(
                    AppIcons.arrowDown,
                    width: 10,
                    height: 10,
                    color: AppColors.grey200,
                  ),
                ),
                focusNode: _categoryNode,
                textInputAction: TextInputAction.next,
              ),
              VerticalMargin(20),
              AppTextField(
                controller: _deadlineController,
                hintText: AppTexts.deadline,
                inputType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                readOnly: true,
                onTap: () {
                  _deadLinePicker(context).then((value) {
                    setState(() {
                      if (value != null) {
                        _deadlineController.text =
                            DateFormat.yMMMEd().format(value);
                        _selectedDate = value;
                      }
                    });
                  });
                },
                label: AppTexts.deadline,
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset(
                    AppIcons.arrowDown,
                    width: 10,
                    height: 10,
                    color: AppColors.grey200,
                  ),
                ),
                focusNode: _deadlineNode,
                textInputAction: TextInputAction.next,
              ),
              VerticalMargin(20),
              images.isEmpty
                  ? Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            selectImage();
                          },
                          child: Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.grey100,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.add,
                                color: AppColors.grey200,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Expanded(
                      child: SizedBox(
                        child: ListView(shrinkWrap: true, children: [
                          SizedBox(
                              width: context.screenWidth(),
                              height: 80,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: images.length,
                                  physics: AlwaysScrollableScrollPhysics(
                                    parent: BouncingScrollPhysics(),
                                  ),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Material(
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                          clipBehavior: Clip.antiAlias,
                                          child: SizedBox(
                                            height: 40,
                                            width: 80,
                                            child: Stack(
                                              children: [
                                                Positioned.fill(
                                                  child: Image.file(
                                                    images[index],
                                                    fit: BoxFit.cover,
                                                    height: 40,
                                                    width: 80,
                                                  ),
                                                ),
                                                Positioned(
                                                    top: -10,
                                                    right: -10,
                                                    child: IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            images.remove(
                                                                images[index]);
                                                          });
                                                        },
                                                        icon: Icon(
                                                          Icons.cancel,
                                                          size: 20,
                                                          color: AppColors
                                                              .white100,
                                                        ))),
                                              ],
                                            ),
                                          )),
                                    );
                                  }))
                        ]),
                      ),
                    ),
              VerticalMargin(20),
              BlocListener<CreateDonationBloc, CreateDonationState>(
                listener: _listener,
                child: AppButton(
                    text: "Create Donation",
                    textColor: AppColors.white100,
                    color: AppColors.primaryColor,
                    isRounded: false,
                    isActive: _isEnabled.value,
                    onTap: () {
                      if (!_isEnabled.value) {
                        return;
                      } else {
                        BlocProvider.of<CreateDonationBloc>(context).add(
                          CreateDonationEventEq(
                            amount: (double.parse(_campaignGoalController.text
                                        .replaceAll('ETH', '')
                                        .replaceAll(',', '')
                                        .replaceAll('.', '')) /
                                    10000)
                                .toString(),
                            category: _selectedCategory.text,
                            deadline: _selectedDate!.toIso8601String(),
                            description: _campaignDescController.text,
                            images: images[0],
                            title: _campaignNameController.text,
                          ),
                        );
                      }
                    }),
              ),
              VerticalMargin(10),
              _note(),
              VerticalMargin(70),
            ],
          ),
        ),
      ),
    );
  }

  void _listener(BuildContext context, CreateDonationState state) {
    state.maybeWhen(orElse: () {
      _overlayEntry?.remove();
    }, loading: () {
      _overlayEntry = showLoadingOverlay(context, _overlayEntry);
    }, error: (message) {
      _overlayEntry?.remove();
      context.showToast(
        title: message,
        context: context,
        toastDurationInSeconds: 1,
        isSuccess: false,
      );
    }, loaded: (response) {
      _overlayEntry?.remove();
      context.showToast(
        title: "Donation created successfully",
        context: context,
        toastDurationInSeconds: 1,
        isSuccess: true,
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SuccessScreen(
            campaignHash: response,
          ),
        ),
      );
    });
  }

  _note() {
    return Text(
      '* Creating a donation may cost you some gas fee. You will be charged only if your donation is successful.\n* It may take a few minutes for your donation to be visible on the blockchain.',
      style: Config.h3(context).copyWith(
        color: AppColors.grey100,
        fontWeight: FontWeight.w500,
        fontSize: 10,
      ),
    );
  }

  Future<Datum?> _pickModel(BuildContext context) {
    return showModalBottomSheet<Datum>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      elevation: 0,
      builder: (_) {
        return SelectCategoryWidget();
      },
    );
  }

  Future<DateTime?> _deadLinePicker(BuildContext context) {
    return showModalBottomSheet<DateTime>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      elevation: 0,
      builder: (_) {
        return SelectDeadLinePicker();
      },
    );
  }

  List<File> images = [];
  void selectImage() async {
    List<Media>? res = await ImagesPicker.pick(
      cropOpt: CropOption(
        aspectRatio: CropAspectRatio.custom,
        cropType: CropType.rect,
      ),
      gif: true,
      count: 1 - images.length,
      pickType: PickType.image,
    );

    if (res != null) {
      setState(() {
        // remove the first image which is the camera image
        images.addAll(res.map((e) => File(e.path)).toList());
        print(images);
      });
    } else if (res == null) {}
  }
}
