import 'package:defiraiser_mobile/core/global/constants/app_texts.dart';
import 'package:defiraiser_mobile/core/global/constants/size.dart';
import 'package:defiraiser_mobile/core/routers/routes_constants.dart';
import 'package:defiraiser_mobile/core/shared/appbar/appbar.dart';
import 'package:defiraiser_mobile/features/donation/presentation/state/get_donation/bloc/get_donation_bloc.dart';
import 'package:defiraiser_mobile/features/home/presentation/widget/donation_widget.dart';
import 'package:defiraiser_mobile/features/home/presentation/widget/empty_campaign_categories.dart';
import 'package:defiraiser_mobile/features/home/presentation/widget/loading_campaigns_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DonationScreenView extends StatefulWidget {
  const DonationScreenView({super.key});

  @override
  State<StatefulWidget> createState() => _DonationScreenViewState();
}

class _DonationScreenViewState extends State<DonationScreenView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final RefreshController _refreshController1 =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _controller.forward();
    super.initState();
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
        preferredSize: Size(context.screenWidth(), 40),
        child: DeFiRaiseAppBar(
          isBack: false,
          title: AppTexts.donation,
          actions: [],
        ),
      ),
      body: Column(
        children: [
          VerticalMargin(20),
          _buildSearchCampaign(),
        ],
      ),
    );
  }

  _buildSearchCampaign() {
    return BlocBuilder<GetDonationBloc, GetDonationState>(
        builder: (context, state) {
      return state.maybeWhen(
          orElse: () => Container(),
          loading: () => LoadingCampaigns(),
          error: (error) => Center(child: Text(error)),
          loaded: (success) => Expanded(
                  child: SmartRefresher(
                enablePullDown: true,
                enablePullUp: false,
                header: const WaterDropHeader(),
                onRefresh: () async {
                  //  refresh bloc
                  context.read<GetDonationBloc>().add(FetchDonations());
                  _refreshController1.refreshCompleted();
                },
                controller: _refreshController1,
                child: success.data!.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        itemCount: success.data!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              context.goNamed(RouteConstants.singleDonation,
                                  extra: success.data![index]);
                            },
                            child: AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 200),
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: BuildDonationWidget(
                                    campaign: success.data![index],
                                    controller: _controller,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : EmptyCampaignCategories(
                        title: "No donations yet",
                        description:
                            "There are no donations yet, but you can be the first to donate to this campaign",
                      ),
              )));
    });
  }
}
