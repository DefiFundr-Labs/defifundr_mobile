import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';
import 'package:defifundr_mobile/core/services/snackbar_service.dart';
import 'package:defifundr_mobile/feature/common/widgets/animated_snackbar.dart';
import 'package:defifundr_mobile/infrastructure/bloc_infrastructure/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(410, 890),
      minTextAdapt: true,
      splitScreenMode: false,
      child: MultiBlocProvider(
        providers: appProviders,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'DeFiFundr',
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode: ThemeMode.system,
              scrollBehavior: const _AppScrollBehavior(),
              routeInformationProvider: AppRouter.router.routeInformationProvider,
              routeInformationParser: AppRouter.router.routeInformationParser,
              routerDelegate: AppRouter.router.routerDelegate,
            ),
            Directionality(
              textDirection: TextDirection.ltr,
              child: ListenableBuilder(
                listenable: SnackbarService(),
                builder: (context, child) {
                  final data = SnackbarService().currentSnackbarData;
                  if (data == null) return SizedBox();
                  return AnimatedSnackbar(snackbarData: data);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppScrollBehavior extends ScrollBehavior {
  const _AppScrollBehavior();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics();
  }
}
