import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/constants/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileCompletionCard extends StatelessWidget {
  final int percentage;

  const ProfileCompletionCard({
    Key? key,
    required this.percentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              SvgPicture.asset(AppAssets.lock),
              const SizedBox(width: 21),
              Text(
                'Complete Profile',
                style: DefiFundrFonts.h3(context)
                    .copyWith(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              const Spacer(),
              SizedBox(
                width: 40,
                height: 40,
                child: Stack(
                  children: [
                    CircularProgressIndicator(
                      value: percentage / 100,
                      strokeWidth: 4,
                      backgroundColor: const Color(0xFFEEEEEE),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFF3F51B5)),
                    ),
                    Center(
                      child: Text(
                        '$percentage%',
                        style: DefiFundrFonts.h3(context)
                            .copyWith(fontSize: 9, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
