import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/common/components/confetti_wrapper.dart';
import 'package:defifundr_mobile/modules/finance/data/model/withdraw_details_model.dart';
import 'package:defifundr_mobile/modules/finance/presentation/withdraw/bloc/withdraw_bloc/withdraw_bloc.dart';
import 'package:defifundr_mobile/modules/finance/presentation/withdraw/bloc/withdraw_bloc/withdraw_event.dart';
import 'package:defifundr_mobile/modules/finance/presentation/withdraw/bloc/withdraw_bloc/withdraw_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/extensions/l10n_extension.dart';

@RoutePage()
class SentScreen extends StatelessWidget {
  const SentScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConfettiWrapper(
      autoStart: true,
      duration: const Duration(seconds: 5),
      particleIntensity: 1000,
      shouldLoop: false,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: _buildContent(context),
                  ),
                ),
                _buildActionButton(context),
                SizedBox(height: 32.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return BlocBuilder<WithdrawBloc, WithdrawState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSuccessIcon(context),
            SizedBox(height: 32.h),
            _buildTextContent(
                context,
                state.withdrawDetails ??
                    WithdrawDetailsModel(
                        address: "",
                        amount: 0,
                        assetIconPath: "",
                        assetName: "",
                        fee: 0.0,
                        feeCurrency: "",
                        memo: "",
                        networkIconPath: "",
                        networkName: "",
                        recipientAddress: "")),
          ],
        );
      },
    );
  }

  Widget _buildSuccessIcon(BuildContext context) {
    return Container(
      width: 80.w,
      height: 80.h,
      decoration: BoxDecoration(
        color: context.theme.colors.brandFill,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: SvgPicture.asset(
          Assets.icons.checked,
          width: 40.w,
          height: 40.h,
        ),
      ),
    );
  }

  Widget _buildTextContent(BuildContext context, WithdrawDetailsModel details) {
    final fonts = context.theme.fonts;
    final colors = context.theme.colors;

    return Column(
      children: [
        Text(
          context.l10n.sent,
          textAlign: TextAlign.center,
          style: context.theme.textTheme.headlineLarge?.copyWith(
            fontSize: 24.sp,
            color: context.theme.colors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 16.h),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: fonts.textBaseRegular.copyWith(
              color: colors.textPrimary,
            ),
            children: <TextSpan>[
              TextSpan(
                text: '${details.amount}',
                style: fonts.textMdSemiBold.copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: ' ${context.l10n.assetSentTo(details.assetName)}',
                style: fonts.textMdSemiBold.copyWith(
                  color: colors.textPrimary,
                ),
              ),
            ],
          ),
        ),
        Text(
          details.recipientAddress,
          style: fonts.textBaseRegular
              .copyWith(color: colors.textPrimary, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return PrimaryButton(
      text: context.l10n.continueText,
      isEnabled: true,
      onPressed: () {
        context.read<WithdrawBloc>().add(const ClearWithdrawDetails());
        context.router.replace(const FinanceHomeRoute());
      },
    );
  }
}
