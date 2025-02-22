import 'package:defifundr_mobile/features/authentication/auth_service_locator.dart';
import 'package:defifundr_mobile/features/authentication/presentation/forget_password/state/bloc/forget_password_bloc.dart';
import 'package:defifundr_mobile/features/authentication/presentation/login/states/bloc/login_state_bloc.dart';
import 'package:defifundr_mobile/features/authentication/presentation/login/states/get_user_details/bloc/get_user_details_bloc.dart';
import 'package:defifundr_mobile/features/authentication/presentation/login/states/set_profile_avatar/bloc/set_profile_avatar_bloc.dart';
import 'package:defifundr_mobile/features/authentication/presentation/signup/states/bloc/sign_up_bloc.dart';
import 'package:defifundr_mobile/features/authentication/presentation/signup/states/check_user_bloc/bloc/check_username_bloc.dart';
import 'package:defifundr_mobile/features/authentication/presentation/signup/states/create_password_bloc/bloc/create_password_bloc.dart';
import 'package:defifundr_mobile/features/authentication/presentation/signup/states/let_get_started_bloc/lets_get_started_bloc.dart';
import 'package:defifundr_mobile/features/authentication/presentation/signup/states/verify_bloc/bloc/verify_otp_bloc.dart';
import 'package:defifundr_mobile/features/donation/presentation/state/create_donation/bloc/create_donation_bloc.dart';
import 'package:defifundr_mobile/features/donation/presentation/state/get_donation/bloc/get_donation_bloc.dart';
import 'package:defifundr_mobile/features/donation/presentation/state/my_campaigns/bloc/my_campaigns_bloc.dart';
import 'package:defifundr_mobile/features/home/home_service_locator.dart';
import 'package:defifundr_mobile/features/home/presentation/state/campaign_by_category/bloc/campaign_by_campaign_bloc.dart';
import 'package:defifundr_mobile/features/home/presentation/state/campaigns/bloc/campaigns_bloc.dart';
import 'package:defifundr_mobile/features/home/presentation/state/categories_bloc/bloc/categories_bloc_bloc.dart';
import 'package:defifundr_mobile/features/home/presentation/state/get_current_eth_price_bloc/bloc/current_eth_price_bloc.dart';
import 'package:defifundr_mobile/features/home/presentation/state/get_donors/bloc/get_donors_bloc.dart';
import 'package:defifundr_mobile/features/home/presentation/state/make_donation_bloc/bloc/make_donations_bloc.dart';
import 'package:defifundr_mobile/features/profile/presentation/state/change_password_bloc/bloc/change_password_bloc.dart';
import 'package:defifundr_mobile/features/profile/presentation/state/change_username_bloc/bloc/change_username_bloc.dart';
import 'package:defifundr_mobile/features/profile/presentation/state/get_private_key_bloc/bloc/get_private_key_bloc.dart';
import 'package:defifundr_mobile/features/profile/presentation/state/set_biometrics_bloc/set_biometrics_bloc_bloc.dart';
import 'package:defifundr_mobile/features/profile/profile_service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';

List<SingleChildWidget> get appProviders {
  return [
    BlocProvider<LoginStateBloc>(
      create: (context) => authLocator<LoginStateBloc>(),
    ),
    BlocProvider<SignUpBloc>(
      create: (context) => authLocator<SignUpBloc>(),
    ),
    BlocProvider<ForgetPasswordBloc>(
      create: (context) => authLocator<ForgetPasswordBloc>(),
    ),
    BlocProvider<VerifyOtpBloc>(
      create: (context) => authLocator<VerifyOtpBloc>(),
    ),
    BlocProvider<CreatePasswordBloc>(
      create: (context) => authLocator<CreatePasswordBloc>(),
    ),
    BlocProvider<SetProfileAvatarBloc>(
      create: (context) => authLocator<SetProfileAvatarBloc>(),
    ),
    BlocProvider<CheckUsernameBloc>(
      create: (context) => authLocator<CheckUsernameBloc>(),
    ),
    BlocProvider<CategoriesBlocBloc>(
      create: (context) =>
          homeLocator<CategoriesBlocBloc>()..add(FetchCategories()),
    ),
    BlocProvider<CampaignsBloc>(
      create: (context) => homeLocator<CampaignsBloc>()..add(FetchCampaigns()),
    ),
    BlocProvider<MyCampaignsBloc>(
      create: (context) =>
          homeLocator<MyCampaignsBloc>()..add(FetchMyCampaigns()),
    ),
    BlocProvider<GetDonationBloc>(
      create: (context) =>
          homeLocator<GetDonationBloc>()..add(FetchDonations()),
    ),
    BlocProvider<CampaignByCampaignBloc>(
      create: (context) => homeLocator<CampaignByCampaignBloc>()
        ..add(FetchCampaignByCategoryEvent()),
    ),
    BlocProvider<CurrentEthPriceBloc>(
      create: (context) =>
          homeLocator<CurrentEthPriceBloc>()..add(GetCurrentPriceEvent()),
    ),
    BlocProvider<MakeDonationsBloc>(
      create: (context) => homeLocator<MakeDonationsBloc>(),
    ),
    BlocProvider<GetDonorsBloc>(
      create: (context) => homeLocator<GetDonorsBloc>()..add(DonationEvent()),
    ),
    BlocProvider<GetUserDetailsBloc>(
      create: (context) =>
          homeLocator<GetUserDetailsBloc>()..add(GetUserEventEq()),
    ),
    BlocProvider<CreateDonationBloc>(
      create: (context) => homeLocator<CreateDonationBloc>(),
    ),
    BlocProvider<SetBiometricsBlocBloc>(
      create: (context) => profileLocator<SetBiometricsBlocBloc>(),
    ),
    BlocProvider<ChangeUsernameBloc>(
      create: (context) => profileLocator<ChangeUsernameBloc>(),
    ),
    BlocProvider<ChangePasswordBloc>(
      create: (context) => profileLocator<ChangePasswordBloc>(),
    ),
    BlocProvider<GetPrivateKeyBloc>(
      create: (context) => profileLocator<GetPrivateKeyBloc>(),
    ),
    BlocProvider<LetsGetStartedBloc>(
      create: (context) => profileLocator<LetsGetStartedBloc>(),
    ),
  ];
}
