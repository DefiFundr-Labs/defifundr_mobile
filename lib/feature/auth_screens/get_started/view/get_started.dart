import 'package:flutter/material.dart';
import 'package:defifundr_mobile/core/constants/assets.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Background image
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.background),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 70),

              // Defifundr logo
              Image.asset(
                AppAssets.logo,
                height: 30,
              ),

              const SizedBox(height: 20),

              // Success text
              const Text(
                "You're all done!",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),

              const Text(
                "You Can Now Enjoy Your App",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),

              Expanded(
                child: Center(
                  child: Image.asset(AppAssets.rocket, height: 373),
                ),
              ),

              // Get Started button
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20, bottom: 30),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black87,
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: const Text(
                    "Get Started",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
