import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';
import 'package:defifundr_mobile/infrastructure/bloc_infrastructure/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: false,
      child: MultiBlocProvider(
        providers: appProviders,
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'DeFiFundr',
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: ThemeMode.system,
          scrollBehavior: const _AppScrollBehavior(),
          routerConfig: AppRouter.router,
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
