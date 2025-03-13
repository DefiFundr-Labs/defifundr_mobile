import 'package:cached_network_image/cached_network_image.dart';
import 'package:defiraiser_mobile/core/global/constants/app_icons.dart';
import 'package:defiraiser_mobile/core/global/constants/app_images.dart';
import 'package:defiraiser_mobile/core/global/constants/size.dart';
import 'package:defiraiser_mobile/core/global/themes/color_scheme.dart';
import 'package:defiraiser_mobile/features/home/domain/entities/campaigns/campaigns_entity.dart';
import 'package:defiraiser_mobile/features/home/presentation/_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

class BuildDonationWidget extends StatelessWidget {
  final Datum? campaign;
  late final AnimationController controller;

  BuildDonationWidget({
    this.campaign,
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return _buildSearchItem(context, controller);
  }

  _buildSearchItem(BuildContext context, AnimationController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.white100,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            _buildCampaignImage(image: campaign!.image),
            HorizontalMargin(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCampaignDonor(context),
                  VerticalMargin(5),
                  _buildCampaignName(context, title: campaign!.title),
                  VerticalMargin(8),
                  linearPercentage(campaign!.totalAmountDonated, campaign!.goal,
                      controller, context,
                      height: 7),
                  VerticalMargin(5),
                  _buildCampaignRaised(context,
                      raised:
                          (campaign!.totalAmountDonated / 1000000000000000000)
                              .toString(),
                      goal: (campaign!.goal / 1000000000000000000).toString()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildCampaignRaised(BuildContext context, {String? raised, String? goal}) {
    return Row(
      children: [
        SvgPicture.asset(
          AppIcons.ether,
          color: AppColors.grey300,
          height: 10,
          width: 10,
          fit: BoxFit.cover,
        ),
        HorizontalMargin(5),
        Text(
          'Raised $raised of $goal',
          style: Config.b1(context).copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 9.0,
            color: AppColors.grey300,
          ),
        ),
      ],
    );
  }

  _buildCampaignName(BuildContext context, {String? title}) {
    return Text(
      title!,
      style: Config.b1(context).copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 12.0,
        color: AppColors.black100,
      ),
    );
  }

  _buildCampaignDonor(BuildContext context) {
    return Row(
      children: [
        Text(
          'By ',
          style: Config.b1(context).copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 9.0,
            color: AppColors.grey300,
          ),
        ),
        CachedNetworkImage(
            imageUrl: campaign!.user![0].avatar,
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
            campaign!.user![0].username != ""
                ? "${campaign!.user![0].username}"
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
    );
  }

  _buildCampaignImage({String? image}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: CachedNetworkImage(
          imageUrl: image!,
          fit: BoxFit.cover,
          height: 80,
          width: 100,
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
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
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
    );
  }
}
