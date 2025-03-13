import 'package:defiraiser_mobile/core/global/constants/app_icons.dart';
import 'package:defiraiser_mobile/core/global/constants/app_texts.dart';
import 'package:defiraiser_mobile/core/global/constants/size.dart';
import 'package:defiraiser_mobile/core/global/themes/color_scheme.dart';
import 'package:defiraiser_mobile/core/routers/routes_constants.dart';
import 'package:defiraiser_mobile/core/shared/appbar/appbar.dart';
import 'package:defiraiser_mobile/core/shared/custom_tooast/custom_tooast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class ViewPrivateScreen extends StatefulWidget {
  final String address;
  final String privateKey;
  const ViewPrivateScreen(
      {required this.address, required this.privateKey, super.key});

  @override
  State<StatefulWidget> createState() => _ViewPrivateScreenState();
}

class _ViewPrivateScreenState extends State<ViewPrivateScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(context.screenWidth(), 60),
        child: DeFiRaiseAppBar(
          isBack: false,
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              context.goNamed(RouteConstants.home);
            },
          ),
          title: AppTexts.getPrivateKey,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Address ',
                      style: Config.h3(context).copyWith(
                        color: AppColors.grey100,
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                      ),
                    ),
                    HorizontalMargin(5),
                    InkWell(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: widget.address));
                        context.showToast(
                          title: AppTexts.copied,
                          context: context,
                          toastDurationInSeconds: 1,
                          isSuccess: true,
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            widget.address,
                            style: Config.h3(context).copyWith(
                              color: AppColors.black200,
                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                            ),
                          ),
                          HorizontalMargin(5),
                          SvgPicture.asset(
                            AppIcons.copyPaste,
                            height: 15,
                            width: 15,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                VerticalMargin(25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Private Key ',
                      style: Config.h3(context).copyWith(
                        color: AppColors.grey100,
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                      ),
                    ),
                    HorizontalMargin(5),
                    InkWell(
                      onTap: () {
                        Clipboard.setData(
                            ClipboardData(text: widget.privateKey));
                        context.showToast(
                          title: AppTexts.copied,
                          context: context,
                          toastDurationInSeconds: 1,
                          isSuccess: true,
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            "........"
                            "${widget.address.toString().substring(widget.address.toString().length - 8)}",
                            style: Config.h3(context).copyWith(
                              color: AppColors.black200,
                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                            ),
                          ),
                          HorizontalMargin(5),
                          SvgPicture.asset(
                            AppIcons.copyPaste,
                            height: 15,
                            width: 15,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
