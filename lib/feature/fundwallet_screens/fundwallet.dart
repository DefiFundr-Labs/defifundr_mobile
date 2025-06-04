import 'package:defifundr_mobile/core/constants/app_icons.dart';
import 'package:defifundr_mobile/core/constants/app_texts.dart';
import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:defifundr_mobile/feature/fundwallet_screens/fundwallet_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class FundWalletScreen extends StatefulWidget {
  const FundWalletScreen({super.key});

  @override
  State<FundWalletScreen> createState() => _FundWalletScreenState();
}

class _FundWalletScreenState extends State<FundWalletScreen> {
  List<CoinObject> coins = [
  CoinObject(imageUrl: AppIcons.solanaIcon, coinShortName: 'SOL', coinFullName: 'Solana', amount: 0, networkAmount: 0),
  CoinObject(imageUrl: AppIcons.ethereumIcon, coinShortName: 'ETH', coinFullName: 'Ethereum', amount: 0, networkAmount: 0),
];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgB1,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.arrow_back_ios),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.black)),
                    child: Row(
                      children: [
                        Icon(Icons.question_mark),
                        Text(
                          AppTexts.needHelp,
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                              color: Color(0xff18181B),
                              letterSpacing: 0,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              height: 16 / 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Fund Wallet",
                  style: TextStyle(
                      fontFamily: "Hanken Grotesk",
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: AppColors.textPrimary),
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                "Top up your wallet to cover transaction fees when creating contracts and sending invoices.",
                style: TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    color: AppColors.textSecondary),
              ),
              SizedBox(height: 24.h),
              Container(
                  decoration: BoxDecoration(
                      color: AppColors.bgB0,
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: List.generate(coins.length, (index) => CoinTile(
                      object: coins[index],
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => FundWalletDetails()));
                      },
                    )),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class CoinTile extends StatelessWidget {
  final CoinObject object;
  final VoidCallback? onTap;
  const CoinTile({
    super.key, this.onTap, required this.object,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  AppIcons.ethereumIcon,
                  width: 36.w,
                  height: 36.w,
                ),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      object.coinShortName,
                      style: TextStyle(
                          fontFamily: "Hanken Grotesk",
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          color: AppColors.textPrimary),
                    ),
                    Text(
                      object.coinFullName,
                      style: TextStyle(
                          fontFamily: "Hanken Grotesk",
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                          color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "\$${object.amount}",
                  style: TextStyle(
                      fontFamily: "Hanken Grotesk",
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: AppColors.textPrimary),
                ),
                Text(
                  "${object.amount} ${object.coinShortName}",
                  style: TextStyle(
                      fontFamily: "Hanken Grotesk",
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      color: AppColors.textSecondary),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CoinObject {
  final String imageUrl;
  final String coinShortName;
  final String coinFullName;
  final double amount;
  final double networkAmount;

  CoinObject(
      {required this.imageUrl,
      required this.coinShortName,
      required this.coinFullName,
      required this.amount,
      required this.networkAmount});
}


