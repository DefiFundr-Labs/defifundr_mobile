import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/routers/routes_constant.dart';
import 'package:defifundr_mobile/feature/fixed_rate_contract_creation/data/workspace_items.dart';
import 'package:defifundr_mobile/feature/fixed_rate_contract_creation/presentation/widgets/workspace_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class WorkspaceScreen extends StatelessWidget {
  const WorkspaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: context.theme.scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        title: Text(
          'Workspace',
          style: context.textTheme.headlineLarge?.copyWith(fontSize: 24.sp),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 12,
            children: workSpaceItems.map((item) {
              return WorkspaceCard(
                  image: item.image,
                  title: item.title,
                  subtitle: item.subtitle,
                  onTap: () =>
                      context.pushNamed(RouteConstants.contractsScreen));
            }).toList(),
          )),
    );
  }
}
