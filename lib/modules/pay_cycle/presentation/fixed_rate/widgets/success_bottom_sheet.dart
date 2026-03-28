import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum SuccessActionType {
  milestoneSubmitted,
  milestoneDeleted,
  milestoneAdded,
  workSubmissionSubmitted,
  workSubmissionDeleted,
  deliverableSubmitted,
  deliverableDeleted,
  workdaySubmitted,
  workdayDeleted,
  weeksSubmitted,
  weeksDeleted,
}

class SuccessBottomSheet extends StatelessWidget {
  final SuccessActionType actionType;
  final String? title;
  final String? subtitle;
  final Widget? icon;
  final Color? iconBackgroundColor;

  const SuccessBottomSheet({
    Key? key,
    required this.actionType,
    this.title,
    this.subtitle,
    this.icon,
    this.iconBackgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String displayTitle = title ?? _getDefaultTitle();
    final String displaySubtitle = subtitle ?? _getDefaultSubtitle();

    return Container(
      decoration: BoxDecoration(
        color: context.theme.colors.bgB1,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64.w,
              height: 64.w,
              decoration: BoxDecoration(
                  color: iconBackgroundColor ?? context.theme.colors.brandFill,
                  shape: BoxShape.circle),
              child: Center(
                child: icon ??
                    SvgPicture.asset(
                      (actionType == SuccessActionType.deliverableSubmitted ||
                              actionType == SuccessActionType.deliverableDeleted)
                          ? Assets.icons.listChecks
                          : (actionType == SuccessActionType.workdaySubmitted ||
                                  actionType == SuccessActionType.workdayDeleted ||
                                  actionType == SuccessActionType.weeksSubmitted ||
                                  actionType == SuccessActionType.weeksDeleted)
                              ? Assets.icons.calendarDot
                              : Assets.icons.clockUser,
                      width: 32.w,
                      height: 32.h,
                      colorFilter: ColorFilter.mode(
                        context.theme.colors.brandDefault,
                        BlendMode.srcIn,
                      ),
                    ),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              displayTitle,
              style: context.theme.fonts.heading2Bold.copyWith(
                color: context.theme.colors.textPrimary,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              displaySubtitle,
              textAlign: TextAlign.center,
              style: context.theme.fonts.textMdRegular.copyWith(
                color: context.theme.colors.textSecondary,
              ),
            ),
            SizedBox(height: 32.h),
            PrimaryButton(
              onPressed: () {
                context.router.maybePop();
                if (actionType == SuccessActionType.milestoneDeleted ||
                    actionType == SuccessActionType.milestoneSubmitted ||
                    actionType == SuccessActionType.workSubmissionDeleted ||
                    actionType == SuccessActionType.workSubmissionSubmitted ||
                    actionType == SuccessActionType.deliverableDeleted ||
                    actionType == SuccessActionType.deliverableSubmitted ||
                    actionType == SuccessActionType.workdayDeleted ||
                    actionType == SuccessActionType.workdaySubmitted ||
                    actionType == SuccessActionType.weeksDeleted ||
                    actionType == SuccessActionType.weeksSubmitted) {
                  context.router.maybePop();
                }
              },
              text: 'Ok',
            ),
          ],
        ),
      ),
    );
  }

  String _getDefaultTitle() {
    switch (actionType) {
      case SuccessActionType.milestoneSubmitted:
        return 'Milestone submitted';
      case SuccessActionType.milestoneDeleted:
        return 'Milestone deleted';
      case SuccessActionType.milestoneAdded:
        return 'Milestone added';
      case SuccessActionType.workSubmissionSubmitted:
        return 'Hours worked submitted';
      case SuccessActionType.workSubmissionDeleted:
        return 'Submission deleted';
      case SuccessActionType.deliverableSubmitted:
        return 'Deliverable submitted';
      case SuccessActionType.deliverableDeleted:
        return 'Deliverable deleted';
      case SuccessActionType.workdaySubmitted:
        return 'Workdays submitted';
      case SuccessActionType.workdayDeleted:
        return 'Workdays deleted';
      case SuccessActionType.weeksSubmitted:
        return 'Weeks worked submitted';
      case SuccessActionType.weeksDeleted:
        return 'Weeks worked deleted';
    }
  }

  String _getDefaultSubtitle() {
    switch (actionType) {
      case SuccessActionType.milestoneSubmitted:
        return 'Milestone now awaiting approval. An email has been sent to your client.';
      case SuccessActionType.milestoneDeleted:
        return 'An email has been sent to your client.';
      case SuccessActionType.milestoneAdded:
        return 'An email has been sent to your client.';
      case SuccessActionType.workSubmissionSubmitted:
        return 'Submission now awaiting approval. An email has been sent to your client.';
      case SuccessActionType.workSubmissionDeleted:
        return 'The submission has been deleted successfully.';
      case SuccessActionType.deliverableSubmitted:
        return 'Submission now awaiting approval. An email has been sent to your client.';
      case SuccessActionType.deliverableDeleted:
        return 'The deliverable has been deleted successfully.';
      case SuccessActionType.workdaySubmitted:
        return 'Submission now awaiting approval. An email has been sent to your client.';
      case SuccessActionType.workdayDeleted:
        return 'The workdays have been deleted successfully.';
      case SuccessActionType.weeksSubmitted:
        return 'Submission now awaiting approval. An email has been sent to your client.';
      case SuccessActionType.weeksDeleted:
        return 'The weeks worked have been deleted successfully.';
    }
  }
}
