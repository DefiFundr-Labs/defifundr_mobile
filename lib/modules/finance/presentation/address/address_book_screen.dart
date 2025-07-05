import 'dart:math';

import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/shared/common_ui/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/common_ui/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/utils/pixeled_image.dart';
import 'package:defifundr_mobile/modules/finance/presentation/address/add_address_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Define a data model for a saved address entry
class SavedAddress {
  final String iconPath;
  final String name;
  final String network;
  final String address;

  SavedAddress({
    required this.iconPath,
    required this.name,
    required this.network,
    required this.address,
  });

  // Generate a unique seed based on address and name for consistent avatars
  String get avatarSeed => '$address$name'.hashCode.toString();
}

class AddressBookScreen extends StatefulWidget {
  const AddressBookScreen({super.key});

  @override
  State<AddressBookScreen> createState() => _AddressBookScreenState();
}

class _AddressBookScreenState extends State<AddressBookScreen> {
  // Constants
  static const double _containerPadding = 16.0;
  static const double _borderRadius = 16.0;
  static const double _itemPadding = 16.0;

  // Available color palettes for randomization
  static const List<List<Color>> _availablePalettes = [
    AvatarPalettes.purplePink,
    AvatarPalettes.yellowPurple,
    AvatarPalettes.ocean,
    AvatarPalettes.sunset,
    AvatarPalettes.forest,
    AvatarPalettes.monochrome,
  ];

  // Method to get a consistent color palette for an address
  List<Color> _getPaletteForAddress(SavedAddress address) {
    final random = Random(address.avatarSeed.hashCode);
    return _availablePalettes[random.nextInt(_availablePalettes.length)];
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fontTheme = context.theme.fonts;

    return Scaffold(
      appBar: DeFiRaiseAppBar(
        title: 'Address book',
        textStyle: fontTheme.heading3SemiBold.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 18.sp,
        ),
        isBack: true,
        actions: [],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _supportedAddresses.isEmpty
                  ? _buildEmptyState(colors, fontTheme)
                  : _buildAddressList(colors, fontTheme),
            ),
            _buildAddButton(colors, fontTheme),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(colors, fontTheme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: colors.bgB1,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                Icons.account_balance_wallet_outlined,
                size: 48.w,
                color: colors.textSecondary,
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              'No saved addresses yet',
              style: fontTheme.heading3SemiBold.copyWith(
                color: colors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12.h),
            Text(
              'Save your go-to crypto addresses so sending funds is faster and safer.',
              style: fontTheme.textBaseMedium.copyWith(
                color: colors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressList(colors, fontTheme) {
    return Container(
      margin: const EdgeInsets.all(_containerPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_borderRadius),
        color: colors.bgB0,
      ),
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(height: 10.sp),
        padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 15.sp),
        itemCount: _supportedAddresses.length,
        itemBuilder: (context, index) => _buildAddressItem(context, index),
      ),
    );
  }

  Widget _buildAddressItem(BuildContext context, int index) {
    final colors = context.theme.colors;
    final fontTheme = context.theme.fonts;
    final address = _supportedAddresses[index];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: InkWell(
        onTap: () => Navigator.pop(context, address.address),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: _itemPadding),
          child: Row(
            children: [
              // Randomized PixelatedAvatar based on address
              PixelatedAvatar(
                size: 40.w,
                gridSize: 8, // Slightly smaller grid for more detailed look
                colorPalette: _getPaletteForAddress(address),
                seed: address.avatarSeed,
                borderRadius: 8.r,
              ),
              SizedBox(width: 12.w),
              // Address details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      address.name,
                      style: fontTheme.textBaseSemiBold.copyWith(
                        color: colors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            _formatAddress(address.address),
                            style: fontTheme.textSmRegular.copyWith(
                              color: colors.textSecondary,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: colors.bgB2,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Text(
                            address.network,
                            style: fontTheme.textXsMedium.copyWith(
                              color: colors.textSecondary,
                              fontSize: 10.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Options button
              InkWell(
                onTap: () => _showAddressOptions(context, address, index),
                borderRadius: BorderRadius.circular(20.r),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.more_horiz,
                    color: colors.textSecondary,
                    size: 20.w,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddButton(colors, fontTheme) {
    return Container(
      padding: const EdgeInsets.all(_containerPadding),
      child: PrimaryButton(
        text: 'Add new address',
        onPressed: () async {
          final newAddress = await Navigator.push<SavedAddress>(
            context,
            MaterialPageRoute(
              builder: (context) => const AddAddressScreen(),
            ),
          );
          if (newAddress != null) {
            _addAddress(newAddress);
          }
        },
      ),
    );
  }

  void _showAddressOptions(
      BuildContext context, SavedAddress address, int index) {
    final colors = context.theme.colors;
    final fontTheme = context.theme.fonts;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: colors.strokeSecondary,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 20.h),
            // Show the avatar in the bottom sheet too
            PixelatedAvatar(
              size: 60.w,
              gridSize: 8,
              colorPalette: _getPaletteForAddress(address),
              seed: address.avatarSeed,
              borderRadius: 12.r,
            ),
            SizedBox(height: 16.h),
            Text(
              address.name,
              style: fontTheme.heading3SemiBold,
            ),
            SizedBox(height: 8.h),
            Text(
              _formatAddress(address.address),
              style: fontTheme.textSmRegular.copyWith(
                color: colors.textSecondary,
              ),
            ),
            SizedBox(height: 24.h),
            _buildBottomSheetOption(
              icon: Icons.copy,
              title: 'Copy address',
              onTap: () {
                Navigator.pop(context);
                _copyAddress(address.address);
              },
              colors: colors,
              fontTheme: fontTheme,
            ),
            _buildBottomSheetOption(
              icon: Icons.edit,
              title: 'Edit',
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement edit functionality
              },
              colors: colors,
              fontTheme: fontTheme,
            ),
            _buildBottomSheetOption(
              icon: Icons.delete_outline,
              title: 'Delete',
              onTap: () {
                Navigator.pop(context);
                _removeAddress(index);
                _showSnackBar('Address removed');
              },
              colors: colors,
              fontTheme: fontTheme,
              isDestructive: true,
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSheetOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required colors,
    required fontTheme,
    bool isDestructive = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Row(
          children: [
            Icon(
              icon,
              color: isDestructive ? Colors.red : colors.textSecondary,
              size: 20.w,
            ),
            SizedBox(width: 16.w),
            Text(
              title,
              style: fontTheme.textBaseMedium.copyWith(
                color: isDestructive ? Colors.red : colors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addAddress(SavedAddress newAddress) {
    setState(() {
      _supportedAddresses.add(newAddress);
    });
  }

  void _removeAddress(int index) {
    setState(() {
      _supportedAddresses.removeAt(index);
    });
  }

  void _copyAddress(String address) {
    Clipboard.setData(ClipboardData(text: address));
    _showSnackBar('Address copied to clipboard');
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  String _formatAddress(String address) {
    if (address.length <= 24) return address;
    return '${address.substring(0, 10)}...${address.substring(address.length - 10)}';
  }

  // Extracted static data for better maintainability
  static List<SavedAddress> _supportedAddresses = [
    SavedAddress(
      iconPath: Assets.images.ethPng.path,
      name: 'Alice\'s Wallet',
      network: 'Ethereum',
      address: '0xC524b945dDB20f703338f4696102D10bbC12629C',
    ),
    SavedAddress(
      iconPath: Assets.images.starknet.path,
      name: 'Bob\'s Trading',
      network: 'Starknet',
      address: '0xCa14007Eff0dB1F8135f4C25B34De49AB0d42766',
    ),
    SavedAddress(
      iconPath: Assets.images.ethPng.path,
      name: 'Charlie\'s DeFi',
      network: 'Universal address',
      address: '0xD735b945dDB20f703338f4696102D10bbC12629D',
    ),
    SavedAddress(
      iconPath: Assets.images.optimism.path,
      name: 'Diana\'s Vault',
      network: 'Optimism',
      address: '0xE846c056eDB30f813449f4696102D10bbC12629E',
    ),
    SavedAddress(
      iconPath: Assets.images.arbitrum.path,
      name: 'Eve\'s Gaming',
      network: 'Arbitrum',
      address: '0xF957d167fDC40f924550f4696102D10bbC12629F',
    ),
    SavedAddress(
      iconPath: Assets.images.matic.path,
      name: 'Frank\'s NFTs',
      network: 'Polygon',
      address: '0xA068e278gED50fa35661f4696102D10bbC12629A',
    ),
    SavedAddress(
      iconPath: Assets.images.bnb.path,
      name: 'Grace\'s Staking',
      network: 'BNB Chain',
      address: '0xB179f389hFE60fb46772f4696102D10bbC12629B',
    ),
  ];
}
