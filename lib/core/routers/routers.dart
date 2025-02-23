part of '_routes.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter _router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: RouteConstants.initial,
    redirect: (context, state) async {
      final info = sl<SecureStorage>();
      final infoList = sl<AppCache>().getUserDetails();

      if (infoList.username != '') {
        // if it is biometric, then go to login not initial screen
        if (state.location == RouteConstants.initial) {
          return '/login/lastLogin';
        } else {
          return null;
        }
      } else {
        return null;
      }
    },
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
        path: '/welcome',
        name: RouteConstants.welcome,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: WelcomeScreen(
              email:
                  state.queryParameters['email'] ?? 'hamiltontyler24@gmail.com',
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity:
                    CurveTween(curve: Curves.easeInOutCirc).animate(animation),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        path: '/selectNationality',
        name: RouteConstants.selectNationality,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: SelectNationalityScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: CurveTween(curve: Curves.easeInOutCirc)
                    .animate(animation),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
          path: '/',
          name: RouteConstants.initial,
          builder: (context, state) => PasscodeScreen(
                key: state.pageKey,
              ),
          routes: [
            GoRoute(
              path: 'login',
              name: RouteConstants.login,
              pageBuilder: (context, state) {
                return CustomTransitionPage(
                  key: state.pageKey,
                  child: const LoginScreen(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    // Change the opacity of the screen using a Curve based on the the animation's
                    // value
                    return FadeTransition(
                      opacity: CurveTween(curve: Curves.easeInOutCirc)
                          .animate(animation),
                      child: child,
                    );
                  },
                );
              },
              routes: [
                GoRoute(
                  path: 'lastLogin',
                  name: RouteConstants.lastLogin,
                  pageBuilder: (context, state) {
                    return CustomTransitionPage(
                      key: state.pageKey,
                      child: const LastUserLoginScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        // Change the opacity of the screen using a Curve based on the the animation's
                        // value
                        return FadeTransition(
                          opacity: CurveTween(curve: Curves.easeInOutCirc)
                              .animate(animation),
                          child: child,
                        );
                      },
                    );
                  },
                ),
                GoRoute(
                    path: 'resetPassword',
                    name: RouteConstants.resetPassword,
                    pageBuilder: (context, state) {
                      return CustomTransitionPage(
                        key: state.pageKey,
                        child: ResetEmailScreen(
                          user: state.queryParameters['user'] ?? '',
                        ),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          // Change the opacity of the screen using a Curve based on the the animation's
                          // value
                          return FadeTransition(
                            opacity: CurveTween(curve: Curves.easeInOutCirc)
                                .animate(animation),
                            child: child,
                          );
                        },
                      );
                    },
                    routes: [
                      GoRoute(
                        path: 'resetOtp',
                        name: RouteConstants.resetOtp,
                        pageBuilder: (context, state) {
                          return CustomTransitionPage(
                            key: state.pageKey,
                            child: ResetOTPScreen(
                              email: state.queryParameters['email'] ?? '',
                            ),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              // Change the opacity of the screen using a Curve based on the the animation's
                              // value
                              return FadeTransition(
                                opacity: CurveTween(curve: Curves.easeInOutCirc)
                                    .animate(animation),
                                child: child,
                              );
                            },
                          );
                        },
                      ),
                    ]),
                GoRoute(
                  path: 'resetConfirmPassword',
                  name: RouteConstants.resetConfirmPassword,
                  pageBuilder: (context, state) {
                    return CustomTransitionPage(
                      key: state.pageKey,
                      child: ResetPasswordScreen(
                        otp: state.queryParameters['otp'] ?? '',
                        email: state.queryParameters['email'] ?? '',
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        // Change the opacity of the screen using a Curve based on the the animation's
                        // value
                        return FadeTransition(
                          opacity: CurveTween(curve: Curves.easeInOutCirc)
                              .animate(animation),
                          child: child,
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            GoRoute(
              path: 'register',
              name: RouteConstants.register,
              pageBuilder: (context, state) {
                return CustomTransitionPage(
                  key: state.pageKey,
                  child: CreateAccountScreen(
                    email: state.queryParameters['email'] ?? '',
                    username: state.queryParameters['username'] ?? '',
                  ),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    // Change the opacity of the screen using a Curve based on the the animation's
                    // value
                    return FadeTransition(
                      opacity: CurveTween(curve: Curves.easeInOutCirc)
                          .animate(animation),
                      child: child,
                    );
                  },
                );
              },
            ),
            // GoRoute(
            //   path: 'import_wallet',
            //   name: RouteConstants.importWallet,
            //   pageBuilder: (context, state) {
            //     return CustomTransitionPage(
            //       key: state.pageKey,
            //       child: ImportWalletScreen(),
            //       transitionsBuilder:
            //           (context, animation, secondaryAnimation, child) {
            //         // Change the opacity of the screen using a Curve based on the the animation's
            //         // value
            //         return FadeTransition(
            //           opacity: CurveTween(curve: Curves.easeInOutCirc)
            //               .animate(animation),
            //           child: child,
            //         );
            //       },
            //     );
            //   },
            // ),
            // GoRoute(
            //   path: 'verifyEmail',
            //   name: RouteConstants.verifyEmail,
            //   pageBuilder: (context, state) {
            //     return CustomTransitionPage(
            //       key: state.pageKey,
            //       child: VerifyOTPScreen(
            //         username: state.queryParameters['username'] ?? '',
            //         email: state.queryParameters['email'] ?? '',
            //       ),
            //       transitionsBuilder:
            //           (context, animation, secondaryAnimation, child) {
            //         // Change the opacity of the screen using a Curve based on the the animation's
            //         // value
            //         return FadeTransition(
            //           opacity: CurveTween(curve: Curves.easeInOutCirc)
            //               .animate(animation),
            //           child: child,
            //         );
            //       },
            //     );
            //   },
            // ),
            GoRoute(
              path: 'confirmPassword',
              name: RouteConstants.confirmPassword,
              pageBuilder: (context, state) {
                return CustomTransitionPage(
                  key: state.pageKey,
                  child: CreatePasswordScreen(
                    username: state.queryParameters['username'] ?? '',
                  ),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    // Change the opacity of the screen using a Curve based on the the animation's
                    // value
                    return FadeTransition(
                      opacity: CurveTween(curve: Curves.easeInOutCirc)
                          .animate(animation),
                      child: child,
                    );
                  },
                );
              },
            ),
            GoRoute(
              path: 'selectAvatar',
              name: RouteConstants.selectAvatar,
              pageBuilder: (context, state) {
                return CustomTransitionPage(
                  key: state.pageKey,
                  child: const SelectAvatarScreen(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    // Change the opacity of the screen using a Curve based on the the animation's
                    // value
                    return FadeTransition(
                      opacity: CurveTween(curve: Curves.easeInOutCirc)
                          .animate(animation),
                      child: child,
                    );
                  },
                );
              },
            ),
            GoRoute(
                path: 'home',
                name: RouteConstants.home,
                pageBuilder: (context, state) {
                  return CustomTransitionPage(
                    key: state.pageKey,
                    child: const BottomNavigationController(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      // Change the opacity of the screen using a Curve based on the the animation's
                      // value
                      return FadeTransition(
                        opacity: CurveTween(curve: Curves.easeInOutCirc)
                            .animate(animation),
                        child: child,
                      );
                    },
                  );
                },
                routes: [
                  GoRoute(
                    path: 'createDonation',
                    name: RouteConstants.createDonation,
                    pageBuilder: (context, state) {
                      return CustomTransitionPage(
                        key: state.pageKey,
                        child: CreateDonationScreen(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          // Change the opacity of the screen using a Curve based on the the animation's
                          // value
                          return FadeTransition(
                            opacity: CurveTween(curve: Curves.easeInOutCirc)
                                .animate(animation),
                            child: child,
                          );
                        },
                      );
                    },
                  ),
                  GoRoute(
                    path: 'changePassword',
                    name: RouteConstants.changePassword,
                    pageBuilder: (context, state) {
                      return CustomTransitionPage(
                        key: state.pageKey,
                        child: ChangePasswordScreen(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          // Change the opacity of the screen using a Curve based on the the animation's
                          // value
                          return FadeTransition(
                            opacity: CurveTween(curve: Curves.easeInOutCirc)
                                .animate(animation),
                            child: child,
                          );
                        },
                      );
                    },
                  ),
                  GoRoute(
                    path: 'editProfile',
                    name: RouteConstants.editProfile,
                    pageBuilder: (context, state) {
                      return CustomTransitionPage(
                        key: state.pageKey,
                        child: EditProfileScreen(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          // Change the opacity of the screen using a Curve based on the the animation's
                          // value
                          return FadeTransition(
                            opacity: CurveTween(curve: Curves.easeInOutCirc)
                                .animate(animation),
                            child: child,
                          );
                        },
                      );
                    },
                  ),
                  GoRoute(
                      path: 'security',
                      name: RouteConstants.security,
                      pageBuilder: (context, state) {
                        return CustomTransitionPage(
                          key: state.pageKey,
                          child: SecurityScreen(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            // Change the opacity of the screen using a Curve based on the the animation's
                            // value
                            return FadeTransition(
                              opacity: CurveTween(curve: Curves.easeInOutCirc)
                                  .animate(animation),
                              child: child,
                            );
                          },
                        );
                      },
                      routes: [
                        GoRoute(
                            path: 'privateKey',
                            name: RouteConstants.privateKey,
                            pageBuilder: (context, state) {
                              return CustomTransitionPage(
                                key: state.pageKey,
                                child: ViewPrivateScreen(
                                  address:
                                      state.queryParameters['address'] ?? '',
                                  privateKey:
                                      state.queryParameters['privateKey'] ?? '',
                                ),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  // Change the opacity of the screen using a Curve based on the the animation's
                                  // value
                                  return FadeTransition(
                                    opacity:
                                        CurveTween(curve: Curves.easeInOutCirc)
                                            .animate(animation),
                                    child: child,
                                  );
                                },
                              );
                            })
                      ]),
                  GoRoute(
                    path: 'selectAvatar2',
                    name: RouteConstants.selectAvatar2,
                    pageBuilder: (context, state) {
                      return CustomTransitionPage(
                        key: state.pageKey,
                        child: SelectAvatarScreen2(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          // Change the opacity of the screen using a Curve based on the the animation's
                          // value
                          return FadeTransition(
                            opacity: CurveTween(curve: Curves.easeInOutCirc)
                                .animate(animation),
                            child: child,
                          );
                        },
                      );
                    },
                  ),
                  GoRoute(
                      path: 'singleDonation',
                      name: RouteConstants.singleDonation,
                      pageBuilder: (context, state) {
                        return CustomTransitionPage(
                          key: state.pageKey,
                          child: DonationView(
                            campaign: state.extra as Datum,
                          ),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            // Change the opacity of the screen using a Curve based on the the animation's
                            // value
                            return FadeTransition(
                              opacity: CurveTween(curve: Curves.easeInOutCirc)
                                  .animate(animation),
                              child: child,
                            );
                          },
                        );
                      },
                      routes: [
                        GoRoute(
                          path: 'viewDonors',
                          name: RouteConstants.viewDonors,
                          pageBuilder: (context, state) {
                            return CustomTransitionPage(
                              key: state.pageKey,
                              child: ViewDonorsScreens(
                                campaignId:
                                    state.queryParameters['campaignId'] ?? '',
                              ),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return FadeTransition(
                                  opacity:
                                      CurveTween(curve: Curves.easeInOutCirc)
                                          .animate(animation),
                                  child: child,
                                );
                              },
                            );
                          },
                        ),
                        GoRoute(
                            path: 'amountToDonate',
                            name: RouteConstants.amountToDonate,
                            pageBuilder: (context, state) {
                              return CustomTransitionPage(
                                key: state.pageKey,
                                child: AmountDonateScreen(
                                  campaignId:
                                      state.queryParameters['campaignId'] ?? '',
                                  campaignName:
                                      state.queryParameters['campaignName'] ??
                                          '',
                                  campaignAddress: state
                                          .queryParameters['campaignAddress'] ??
                                      '',
                                  goal: state.queryParameters['goal'] ?? '',
                                ),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  // Change the opacity of the screen using a Curve based on the the animation's
                                  // value
                                  return FadeTransition(
                                    opacity:
                                        CurveTween(curve: Curves.easeInOutCirc)
                                            .animate(animation),
                                    child: child,
                                  );
                                },
                              );
                            },
                            routes: [
                              GoRoute(
                                path: 'donationConfirmation',
                                name: RouteConstants.donationConfirmation,
                                pageBuilder: (context, state) {
                                  return CustomTransitionPage(
                                    key: state.pageKey,
                                    child: ConfirmDonationDetailsScreen(
                                      campaignName: state.queryParameters[
                                              'campaignName'] ??
                                          '',
                                      amount:
                                          state.queryParameters['amount'] ?? '',
                                      amountInUsd: state
                                              .queryParameters['amountInUsd'] ??
                                          '',
                                      campaignId:
                                          state.queryParameters['campaignId'] ??
                                              '',
                                      address:
                                          state.queryParameters['address'] ??
                                              '',
                                    ),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      // Change the opacity of the screen using a Curve based on the the animation's
                                      // value
                                      return FadeTransition(
                                        opacity: CurveTween(
                                                curve: Curves.easeInOutCirc)
                                            .animate(animation),
                                        child: child,
                                      );
                                    },
                                  );
                                },
                              ),
                            ]),
                      ]),
                  GoRoute(
                    path: 'getCampaignCategory',
                    name: RouteConstants.getCampaignCategory,
                    pageBuilder: (context, state) {
                      return CustomTransitionPage(
                        key: state.pageKey,
                        child: CategoryCampaignScreen(
                          category: state.queryParameters['category'] ?? '',
                          id: state.queryParameters['id'] ?? '',
                        ),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          // Change the opacity of the screen using a Curve based on the the animation's
                          // value
                          return FadeTransition(
                            opacity: CurveTween(curve: Curves.easeInOutCirc)
                                .animate(animation),
                            child: child,
                          );
                        },
                      );
                    },
                  ),
                  GoRoute(
                    path: 'walletConfirmation',
                    name: RouteConstants.walletConfirmation,
                    pageBuilder: (context, state) {
                      return CustomTransitionPage(
                        key: state.pageKey,
                        child: WalletConfirmetionScreen(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: CurveTween(curve: Curves.easeInOutCirc)
                                .animate(animation),
                            child: child,
                          );
                        },
                      );
                    },
                  ),
                  // GoRoute(
                  //   path: 'pasteYourRecoveryPhrase',
                  //   name: RouteConstants.pasteYourRecoveryPhrase,
                  //   pageBuilder: (context, state) {
                  //     return CustomTransitionPage(
                  //       key: state.pageKey,
                  //       child: PasteRecoveryPhraseScreen(),
                  //       transitionsBuilder:
                  //           (context, animation, secondaryAnimation, child) {
                  //         // Change the opacity of the screen using a Curve based on the the animation's
                  //         // value
                  //         return FadeTransition(
                  //           opacity: CurveTween(curve: Curves.easeInOutCirc)
                  //               .animate(animation),
                  //           child: child,
                  //         );
                  //       },
                  //     );
                  //   },
                  // ),
                ]),
          ]),
    ],
  );

  static GoRouter get router => _router;
}
