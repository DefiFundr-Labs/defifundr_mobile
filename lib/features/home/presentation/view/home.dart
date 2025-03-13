part of '../_home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final isHide = ValueNotifier<bool>(true);
  final RefreshController _refreshController1 =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  final user = sl<AppCache>().getUserDetails();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white200,
        body: SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,
          header: const MaterialClassicHeader(
            color: AppColors.black100,
            backgroundColor: AppColors.white100,
          ),
          onRefresh: () async {
            //  refresh bloc
            context.read<CategoriesBlocBloc>().add(FetchCategories());
            context.read<CampaignsBloc>().add(FetchCampaigns());
            context.read<GetUserDetailsBloc>().add(GetUserEventEq());

            _refreshController1.refreshCompleted();
          },
          controller: _refreshController1,
          child: CustomScrollView(
            shrinkWrap: true,
            slivers: [
              SliverAppBar(
                  snap: false,
                  automaticallyImplyLeading: false,
                  pinned: true,
                  floating: true,
                  backgroundColor: Colors.transparent,
                  actions: [
                    GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.only(right: 15.sp, top: 10.sp),
                        child: Stack(
                          children: const [],
                        ),
                      ),
                    ),
                  ],
                  expandedHeight: 300.sp,
                  flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      background: Stack(children: [
                        Container(
                          height: 300.sp,
                          width: context.screenWidth(),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(40),
                                bottomRight: Radius.circular(40)),
                            image: DecorationImage(
                              image: AssetImage(AppImages.background),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // Positioned(
                        //   top: 90,
                        //   left: 20,
                        //   child: Container(
                        //     height: 60,
                        //     width: 60,
                        //     decoration: BoxDecoration(
                        //       image: DecorationImage(
                        //         image: AssetImage(AppImages.LoaderLogo),
                        //         fit: BoxFit.cover,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Positioned(
                          top: 90.sp,
                          left: 20.sp,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                HorizontalMargin(10),
                                BlocBuilder<GetUserDetailsBloc,
                                    GetUserDetailsState>(
                                  builder: (context, state) {
                                    return GestureDetector(
                                        onTap: state.maybeMap(
                                            orElse: () => null,
                                            loadDetails: (l) => () {
                                                  context.goNamed(RouteConstants
                                                      .selectAvatar2);
                                                }),
                                        child: state.maybeMap(
                                          orElse: () => LoadingImage(),
                                          error: (e) => CircleAvatar(
                                              radius: 30.sp,
                                              backgroundColor:
                                                  Colors.transparent,
                                              backgroundImage: AssetImage(
                                                  AppImages.avatar(1))),
                                          loadDetails: (l) =>
                                              CachedNetworkImage(
                                                  imageUrl: state.maybeWhen(
                                                    orElse: () => "",
                                                    loadDetails: (success) =>
                                                        success.avatar,
                                                  ),
                                                  fit: BoxFit.cover,
                                                  height: 60.sp,
                                                  width: 60.sp,
                                                  placeholder: (context, url) =>
                                                      LoadingImage(),
                                                  errorWidget:
                                                      (context, url, error) {
                                                    return CircleAvatar(
                                                      radius: 30.sp,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      backgroundImage:
                                                          AssetImage(
                                                              AppImages.avatar(
                                                                  1)),
                                                    );
                                                  }),
                                        ));
                                  },
                                ),
                                //
                              ]),
                        ),
                        _balanceWidget(context)
                      ]))),
              DiscoverCampaign(),
              LatestFundraiserWidget(),
            ],
          ),
        ));
  }

  Positioned _balanceWidget(BuildContext context) {
    return Positioned(
        bottom: 0,
        left: context.screenWidth() * 0.05,
        child: BlocBuilder<GetUserDetailsBloc, GetUserDetailsState>(
          builder: (context, state) {
            return Container(
              height: 170.sp,
              width: context.screenWidth() * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: AppColors.black100,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(AppTexts.balance,
                      style: Config.b1(context).copyWith(
                          color: AppColors.white100, fontSize: 12.sp)),
                  VerticalMargin(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 8.sp),
                        child: Text("ETH",
                            style: Config.b1(context).copyWith(
                              color: AppColors.white100,
                            )),
                      ),
                      HorizontalMargin(10),
                      Text(
                          state.maybeWhen(
                            orElse: () => double.tryParse(user.balance)!
                                .toStringAsFixed(3)
                                .toString(),
                            loadDetails: (data) =>
                                double.tryParse(data.balance)!
                                    .toStringAsFixed(3)
                                    .toString(),
                            loading: () => '●●●',
                          ),
                          style: Config.h2(context).copyWith(
                            color: AppColors.white100,
                          )),
                      HorizontalMargin(10),
                      // InkWell(
                      //     onTap: () {
                      //       setState(() {
                      //         isHide.value = !isHide.value;
                      //       });
                      //     },
                      //     child: SvgPicture.asset(
                      //         isHide.value
                      //             ? AppIcons.balanceEye
                      //             : AppIcons.balanceEyeClose,
                      //         color: AppColors.white100,
                      //         height: 14,
                      //         width: 14)),
                    ],
                  ),
                  VerticalMargin(10),
                  _topUpButton(context)
                ],
              ),
            );
          },
        ));
  }

  Container _searchBar(BuildContext context) {
    return Container(
        height: 60.sp,
        width: context.screenWidth() * 0.73,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: AppColors.white100,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HorizontalMargin(10),
              SvgPicture.asset(AppIcons.search,
                  color: AppColors.black200, height: 20, width: 20),
              HorizontalMargin(10),
              Text(
                AppTexts.searchCampaign,
                style: TextStyle(color: AppColors.black200, fontSize: 16),
              )
            ],
          ),
        ));
  }

  AnimatedBuilder _topUpButton(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        child: GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
              elevation: 0.0,
              builder: (_) {
                return Container(
                  height: context.screenHeight() * 0.45,
                  width: context.screenWidth(),
                  decoration: BoxDecoration(
                    color: AppColors.white100,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // VerticalMargin(50),
                      QrImageView(
                        data: user.address,
                        version: QrVersions.auto,
                        size: 170.sp,
                        embeddedImage: AssetImage(AppImages.appLogoQr),
                        embeddedImageStyle: QrEmbeddedImageStyle(
                          size: Size(40, 40),
                        ),
                      ),
                      VerticalMargin(20),
                      Text(
                        AppTexts.walletAddr,
                        style: Config.b1(context).copyWith(
                          color: AppColors.black100,
                          fontSize: 15.sp,
                        ),
                      ),
                      VerticalMargin(10),
                      Text(
                        user.address,
                        style: Config.b3(context).copyWith(
                          color: AppColors.secondaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                        ),
                      ),
                      VerticalMargin(10),
                      GestureDetector(
                          onTap: () async {
                            Clipboard.setData(ClipboardData(text: user.address))
                                .then((_) {
                              Navigator.pop(context);
                              context.showToast(
                                title: AppTexts.copied,
                                context: context,
                                toastDurationInSeconds: 1,
                                isSuccess: true,
                              );
                            });
                          },
                          child: Container(
                            height: 50.sp,
                            width: 160.sp,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.grey200,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Text(
                                  //   AppTexts.copyAddr,
                                  //   style: Config.b3(context).copyWith(
                                  //     color: AppColors.primaryColor,
                                  //     fontWeight: FontWeight.bold,
                                  //   ),
                                  // ),
                                  // HorizontalMargin(5),
                                  SvgPicture.asset(AppIcons.copy)
                                ]),
                          ))
                    ],
                  ),
                );
              },
            );
          },
          child: Container(
            height: 40.sp,
            width: context.screenWidth() * 0.4,
            decoration: BoxDecoration(
              color: AppColors.black200,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppIcons.wallet,
                  color: AppColors.white100,
                  height: 20.sp,
                  width: 20.sp,
                ),
                HorizontalMargin(5),
                Text(AppTexts.topUp,
                    style: Config.b1(context).copyWith(
                      color: AppColors.white100,
                      fontSize: 11.sp,
                    )),
              ],
            ),
          ),
        ),
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, 0 * (1 - _animationController.value)),
            child: child,
          );
        });
  }
}

class LoadingImage extends StatelessWidget {
  final double? height;
  final double? width;
  const LoadingImage({
    this.height,
    this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: AppColors.grey300.withOpacity(0.2),
        highlightColor: AppColors.white100.withOpacity(0.3),
        child: Container(
          width: width ?? 50.sp,
          height: height ?? 50.sp,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ));
  }
}
