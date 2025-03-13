part of '../_home.dart';

class ViewDonorsScreens extends StatefulWidget {
  final String campaignId;
  const ViewDonorsScreens({required this.campaignId, super.key});

  @override
  State<StatefulWidget> createState() => _ViewDonorsScreensState();
}

class _ViewDonorsScreensState extends State<ViewDonorsScreens> {
  final RefreshController _refreshController1 =
      RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: DeFiRaiseAppBar(
          title: AppTexts.viewDonors,
          isBack: true,
        ),
      ),
      body: Column(
        children: [
          _buildDonorsList(),
        ],
      ),
    );
  }

  Widget _buildDonorsList() {
    return Expanded(
      child: BlocBuilder<GetDonorsBloc, GetDonorsState>(
        bloc: context.read<GetDonorsBloc>()
          ..add(DonationEvent(campaignId: widget.campaignId)),
        builder: (context, state) {
          return state.maybeWhen(orElse: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }, loaded: (donors) {
            return SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              header: const WaterDropHeader(),
              onRefresh: () async {
                //  refresh bloc
                context
                    .read<GetDonorsBloc>()
                    .add(DonationEvent(campaignId: widget.campaignId));
                _refreshController1.refreshCompleted();
              },
              controller: _refreshController1,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: donors.data!.length,
                itemBuilder: (context, index) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 500),
                    child: SlideAnimation(
                      verticalOffset: 1.0,
                      child: FadeInAnimation(
                        child: _buildDonorItem(
                          donors: donors.data![index],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }, error: (message) {
            return Center(
              child: Text(message),
            );
          });
        },
      ),
    );
  }

  Widget _buildDonorItem({
    required Donors donors,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 25),
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.white100,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(children: [
            CachedNetworkImage(
                imageUrl: donors.image!,
                fit: BoxFit.cover,
                height: 60,
                width: 60,
                placeholder: (context, url) => LoadingImage(),
                errorWidget: (context, url, error) {
                  return Image.asset(
                    AppImages.avatar(1),
                    height: 20,
                    fit: BoxFit.cover,
                    width: 20,
                  );
                }),
            HorizontalMargin(10),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                donors.username,
                style: Config.b2(context).copyWith(
                  color: AppColors.secondaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              VerticalMargin(5),
              Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      AppIcons.ether,
                      height: 15,
                      width: 15,
                      color: AppColors.grey100,
                    ),
                    HorizontalMargin(5),
                    Text(
                      '${donors.amount} ETH',
                      style: Config.b2(context).copyWith(
                        color: AppColors.black100,
                        fontSize: 12,
                      ),
                    ),
                  ]),
              Text(
                '${donors.donor}',
                style: Config.b2(context).copyWith(
                  color: AppColors.grey300,
                  fontSize: 10,
                ),
              )
            ]),
          ])),
    );
  }
}
