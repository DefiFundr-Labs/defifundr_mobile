part of '../_home.dart';

class SearchCampaignScreen extends StatefulWidget {
  const SearchCampaignScreen({
    super.key,
  });

  @override
  State<SearchCampaignScreen> createState() => _SearchCampaignScreenState();
}

class _SearchCampaignScreenState extends State<SearchCampaignScreen>
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
    return Scaffold(
      backgroundColor: AppColors.white200,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: DeFiRaiseAppBar(
          title: AppTexts.searchCampaign,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              VerticalMargin(20),
              SearchTextField(
                hintText: AppTexts.searchCampaign,
                onChanged: (value) {},
                prefixIcon: SizedBox(
                  width: 16,
                  height: 16,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(
                      AppIcons.search,
                      color: AppColors.grey300,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              VerticalMargin(20),
              _buildSearchCampaign(),
            ],
          ),
        ),
      ),
    );
  }

  _buildSearchCampaign() {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        itemCount: 20,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 200),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: BuildDonationWidget(
                  controller: _controller,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
