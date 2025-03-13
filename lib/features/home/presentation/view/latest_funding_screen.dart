part of '../_home.dart';

class LatestFundraiserWidget extends StatefulWidget {
  const LatestFundraiserWidget({
    super.key,
  });

  @override
  State<LatestFundraiserWidget> createState() => _LatestFundraiserWidgetState();
}

class _LatestFundraiserWidgetState extends State<LatestFundraiserWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(child:
        BlocBuilder<CampaignsBloc, CampaignsState>(builder: (context, state) {
      return BlocBuilder<CategoriesBlocBloc, CategoriesBlocState>(
        builder: (context, stated) {
          return stated.maybeMap(
              error: (e) => SizedBox.shrink(),
              orElse: () => Column(children: [
                    VerticalMargin(5),
                    state.maybeWhen(
                      orElse: () => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.sp),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.sp),
                              child: Text(
                                AppTexts.latestFundRaiser,
                                style: TextStyle(
                                    color: AppColors.black100,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      error: (e) => SizedBox.shrink(),
                    ),
                    VerticalMargin(10),
                    SizedBox(
                        width: context.screenWidth(),
                        height: 250.sp,
                        child: state.maybeWhen(
                          orElse: () => Container(),
                          loading: () => LoadingCampaign(),
                          loaded: (success) => AnimationLimiter(
                              child: ListView.builder(
                                  itemCount: success.data!.length,
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(
                                      parent: AlwaysScrollableScrollPhysics()),
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 25.sp),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return latestFundingWidget(
                                        context, success, index);
                                  })),
                        )),
                    VerticalMargin(30),
                  ]));
        },
      );
    }));
  }

  Widget latestFundingWidget(
      BuildContext context, CampaignResponse success, int index) {
    return GestureDetector(
      onTap: () {
        context.goNamed(RouteConstants.singleDonation,
            extra: success.data![index]);
      },
      child: AnimationConfiguration.staggeredList(
          position: index,
          duration: const Duration(milliseconds: 200),
          child: SlideAnimation(
              horizontalOffset: 30,
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.sp),
                  child: Container(
                    width: 200.sp,
                    padding: EdgeInsets.symmetric(
                        horizontal: 10.sp, vertical: 10.sp),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: AppColors.white100,
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 120.sp,
                          width: 200.sp,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.grey200.withOpacity(0.5),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: CachedNetworkImage(
                                imageUrl: success.data![index].image,
                                fit: BoxFit.cover,
                                height: 120.sp,
                                placeholder: (context, url) => Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColors.grey100,
                                    ),
                                    child: Shimmer(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          AppColors.grey100,
                                          AppColors.white100,
                                        ],
                                      ),
                                      child: Container(
                                        height: 120,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                    )),
                                errorWidget: (context, url, error) {
                                  return Image.asset(
                                    AppImages.avatar(1),
                                    height: 12,
                                    fit: BoxFit.cover,
                                    width: 12,
                                  );
                                }),
                          ),
                        ),
                        VerticalMargin(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "By",
                              style: Config.b2(context).copyWith(
                                fontSize: 10,
                                color: AppColors.grey100,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            HorizontalMargin(5),
                            CachedNetworkImage(
                                imageUrl: success.data![index].user![0].avatar,
                                fit: BoxFit.cover,
                                height: 15,
                                width: 15,
                                placeholder: (context, url) => LoadingImage(),
                                errorWidget: (context, url, error) {
                                  return Image.asset(
                                    AppImages.avatar(1),
                                    height: 12,
                                    fit: BoxFit.cover,
                                    width: 12,
                                  );
                                }),
                            HorizontalMargin(5),
                            Flexible(
                              child: Text(
                                success.data![index].user![0].username != ""
                                    ? "${success.data![index].user![0].username}"
                                    : "Anonymous",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Config.b2(context).copyWith(
                                  fontSize: 10,
                                  color: AppColors.black100,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        VerticalMargin(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                success.data![index].title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Config.b3(context).copyWith(
                                  fontSize: 10,
                                  color: AppColors.black100,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        VerticalMargin(10),
                        linearPercentage(
                            success.data![index].totalAmountDonated,
                            success.data![index].goal,
                            _controller,
                            context,
                            height: 10,
                            width: 200),
                        VerticalMargin(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  AppIcons.ether,
                                  height: 10,
                                  width: 10,
                                ),
                                HorizontalMargin(5),
                                Text(
                                  (success.data![index].goal /
                                          1000000000000000000)
                                      .toString(),
                                  style: Config.b2(context).copyWith(
                                    fontSize: 10,
                                    color: AppColors.black100,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                HorizontalMargin(5),
                                Text(
                                  "ETH",
                                  style: Config.b2(context).copyWith(
                                    fontSize: 10,
                                    color: AppColors.grey100,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              DateTime.tryParse(success.data![index].deadline!)!
                                  .endTime(),
                              style: Config.b2(context).copyWith(
                                fontSize: 10,
                                color: AppColors.grey100,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ))),
    );
  }
}

class LoadingCampaign extends StatelessWidget {
  const LoadingCampaign({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 2,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        padding: EdgeInsets.symmetric(horizontal: 25.sp),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
                width: 200.sp,
                height: 120.sp,
                padding:
                    EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: AppColors.white100,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                      baseColor: AppColors.grey300.withOpacity(0.2),
                      highlightColor: AppColors.white100.withOpacity(0.2),
                      child: Container(
                          height: 120.sp,
                          width: 200.sp,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.grey200.withOpacity(0.5),
                          )),
                    ),
                    VerticalMargin(15),
                    Shimmer.fromColors(
                      baseColor: AppColors.grey300.withOpacity(0.2),
                      highlightColor: AppColors.white100.withOpacity(0.2),
                      child: Container(
                          height: 16.sp,
                          width: 100.sp,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.grey200.withOpacity(0.5),
                          )),
                    ),
                    VerticalMargin(10),
                    Shimmer.fromColors(
                      baseColor: AppColors.grey300.withOpacity(0.2),
                      highlightColor: AppColors.white100.withOpacity(0.2),
                      child: Container(
                          height: 16.sp,
                          width: 140.sp,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.grey200.withOpacity(0.5),
                          )),
                    ),
                    VerticalMargin(10),
                    Shimmer.fromColors(
                      baseColor: AppColors.grey300.withOpacity(0.2),
                      highlightColor: AppColors.white100.withOpacity(0.2),
                      child: Container(
                          height: 16.sp,
                          width: 200.sp,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.grey200.withOpacity(0.5),
                          )),
                    ),
                  ],
                )),
          );
        });
  }
}
