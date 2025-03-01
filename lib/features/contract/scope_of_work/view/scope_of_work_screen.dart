import 'package:defifundr_mobile/core/constants/app_texts.dart';
import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/shared/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/themes/color_scheme.dart';
import 'package:defifundr_mobile/features/contract/scope_of_work/view/widget/expandable_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ScopeOfWorkScreen extends StatefulWidget {
  const ScopeOfWorkScreen({Key? key}) : super(key: key);

  @override
  State<ScopeOfWorkScreen> createState() => _ScopeOfWorkScreenState();
}

class _ScopeOfWorkScreenState extends State<ScopeOfWorkScreen> {
  final jobs = [
    {
      "title": "Machine Learning Engineer",
      "level": "Level:Senior Engineer",
      "content": """
        Machine Learning Engineers build and optimize ML models for production.
        They work on model training, hyperparameter tuning, and deployment.
        This role requires expertise in TensorFlow, PyTorch, and cloud-based ML platforms such as AWS SageMaker.
      """
    },
    {
      "title": "Data Scientist",
      "level": "Level:Mid-Level Engineer",
      "content": """
        Data Scientists analyze complex datasets to extract insights and build predictive models.
        They use statistical methods, Python (Pandas, NumPy), and machine learning algorithms to solve business problems.
      """
    },
    {
      "title": "Software Engineer",
      "level": "Level:Junior Developer",
      "content": """
        Software Engineers focus on building scalable applications and infrastructure.
        They work with programming languages like Python, Java, and TypeScript to create web services, APIs, and cloud-based applications.
      """
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: PreferredSize(
        preferredSize: Size(context.screenWidth(), 60),
        child: AppBar(
          backgroundColor: AppColors.transparent,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: IconButton(
              icon: SvgPicture.asset(AppAssets.backArrow),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppTexts.scopeOfWork,
                  style: Config.h2(context)
                      .copyWith(fontSize: 26, color: AppColors.titleBlack),
                ),
                VerticalMargin(5),
                Text(
                  AppTexts.createFixedRateContract,
                  style: Config.b3(context)
                      .copyWith(color: AppColors.subtitleGrey, fontSize: 14),
                ),
                VerticalMargin(20),
                Expanded(
                  child: ListView.separated(
                    itemCount: jobs.length,
                    separatorBuilder: (context, index) =>
                        VerticalMargin(20), // 20px space
                    itemBuilder: (context, index) {
                      final jobRole = jobs[index];
                      return ExpandableContainer(
                        title: jobRole['title'] ?? "Unknown Title",
                        subtitle: jobRole['level'] ?? "Unknown Level",
                        content: Text(
                          jobRole['content'] ?? "No Content",
                          style: Config.h2(context).copyWith(
                              fontSize: 11,
                              color: AppColors.secondaryTextColor,
                              fontWeight: FontWeight.w600),
                        ),
                      );
                    },
                  ),
                ),
                VerticalMargin(20),
              ],
            ),
          ),

          // Floating Button Section
          Positioned(
            bottom: 50,
            left: 39,
            right: 39,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: AppButton(
                    text: AppTexts.viewAll,
                    color: AppColors.secondaryTextColor,
                    textColor: AppColors.white100,
                    borderRadius: 30,
                    height: 26,
                    textSize: 9,
                    onTap: () {},
                  ),
                ),
            
                Expanded(
                  child: AppButton(
                    text: AppTexts.select,
                    color: AppColors.black100,
                    textColor: AppColors.white100,
                    borderRadius: 30,
                    height: 26,
                    textSize: 9,
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
