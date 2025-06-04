import 'package:defifundr_mobile/core/design_system/color_extension/app_color_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:defifundr_mobile/core/routers/routes_constant.dart';

class WithdrawPreviewScreen extends StatelessWidget {
  const WithdrawPreviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorExtension>()!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Coin icon goes here
                    const SizedBox(height: 16.0),
                    const Text(
                      '5 USDC',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    const Text(
                      '≈ \$5.19',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('To', style: TextStyle(color: Colors.grey)),
                        const Text('0x6885afa...6f23b3'),
                      ],
                    ),
                    const SizedBox(height: 12.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Network',
                            style: TextStyle(color: Colors.grey)),
                        Row(
                          children: [
                            // Ethereum icon placeholder
                            const SizedBox(width: 4.0),
                            const Text('Ethereum'),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Fee', style: TextStyle(color: Colors.grey)),
                        const Text('0.0005 ETH (≈ \$1.31)'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: ElevatedButton(
          onPressed: () {
            context.goNamed(RouteConstants.sent);
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            backgroundColor: colors.brandDefault,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: const Text(
            'Confirm',
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
