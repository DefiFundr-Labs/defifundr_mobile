import 'package:defifundr_mobile/core/constants/app_icons.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/enums/blockchain_type.dart';
import 'package:defifundr_mobile/core/shared/overlay/blockchain_wallet_loader.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/multi_factor_authentication_screen/widgets/primary_button.dart';
import 'package:defifundr_mobile/infrastructure/web3auth/bloc/auth_bloc.dart';
import 'package:defifundr_mobile/infrastructure/web3auth/bloc/auth_event.dart';
import 'package:defifundr_mobile/infrastructure/web3auth/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class Web3AuthTestPage extends StatefulWidget {
  const Web3AuthTestPage({super.key});

  @override
  State<Web3AuthTestPage> createState() => _Web3AuthTestPageState();
}

class _Web3AuthTestPageState extends State<Web3AuthTestPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  // Add this to track email state
  bool _isEmailValid = false;

  // Animation controller for blockchain switching
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _messageController.text = 'Hello from Web3Auth!';

    // Initialize animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _emailController.addListener(_validateEmail);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _messageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _validateEmail() {
    setState(() {
      _isEmailValid = _emailController.text.trim().isNotEmpty &&
          _emailController.text.contains('@') &&
          _emailController.text.contains('.');
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        // Handle error messages
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: colors.redDefault,
            ),
          );
        }

        // Handle wallet loading state changes
        if (state.status == AuthStatus.loadingWallet) {
          // Fade in animation when loading wallet
          _animationController.forward();
        } else if (state.status == AuthStatus.authenticated &&
            _animationController.value > 0) {
          // Fade out animation when wallet loading is complete
          _animationController.reverse();
        }
      },
      builder: (context, state) {
        if (state.status == AuthStatus.initial ||
            state.status == AuthStatus.initializing) {
          return _buildLoadingScreen(context);
        }

        if (state.status == AuthStatus.initializationFailed) {
          return _buildErrorScreen(
            state.errorMessage ?? 'Initialization failed',
            context,
          );
        }

        return Scaffold(
          backgroundColor: colors.bgB0,
          appBar: AppBar(
            title: Text(
              'Web3Auth Test',
              style: fonts.textLgBold,
            ),
            backgroundColor: colors.bgB0,
          ),
          body: Stack(
            children: [
              // Main content
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: state.isAuthenticated
                      ? _buildLoggedInView(state, context)
                      : _buildLoginView(state, context),
                ),
              ),

              // Show wallet loading overlay when switching blockchains
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Visibility(
                    visible: state.status == AuthStatus.loadingWallet ||
                        _animationController.value > 0,
                    child: Opacity(
                      opacity: _fadeAnimation.value,
                      child: BlockchainWalletLoader(
                        blockchainType: state.selectedBlockchain,
                        isVisible: true,
                        onDismiss: state.status == AuthStatus.loadingWallet
                            ? null
                            : () {
                                _animationController.reverse();
                              },
                      ),
                    ),
                  );
                },
              ),

              // Message signing overlay
              if (state.status == AuthStatus.signingMessage)
                Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: Container(
                      width: 0.8.sw,
                      padding: EdgeInsets.all(24.w),
                      decoration: BoxDecoration(
                        color: context.theme.colors.bgB0,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(
                            color: colors.activeButton,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'Signing Message',
                            style: fonts.textLgSemiBold,
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Please wait while we sign your message...',
                            style: fonts.textSmRegular.copyWith(
                              color: colors.textSecondary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLoadingScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? colors.bgB0 // Light mode color
          : colors.bgB1,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: context.theme.colors.activeButton,
            ),
            SizedBox(height: 16.h),
            const Text('Initializing Web3Auth...'),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorScreen(
    String errorMessage,
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? colors.bgB0 // Light mode color
          : colors.bgB1,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                color: context.theme.colors.blueActive,
                size: 64.w,
              ),
              SizedBox(height: 16.h),
              Text(
                'Initialization Failed',
                style: context.theme.fonts.textLgBold,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              Text(
                errorMessage,
                textAlign: TextAlign.center,
                style: context.theme.fonts.textMdRegular.copyWith(
                  color: context.theme.colors.textSecondary,
                ),
              ),
              SizedBox(height: 24.h),
              PrimaryButton(
                text: 'Retry',
                onPressed: () =>
                    context.read<AuthBloc>().add(const InitializeAuth()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginView(
    AuthState state,
    BuildContext context,
  ) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;
    final isAuthenticating = state.status == AuthStatus.authenticating;

    return ListView(
      padding: EdgeInsets.symmetric(vertical: 24.h),
      children: [
        Container(
          width: 80.w,
          height: 80.w,
          margin: EdgeInsets.only(bottom: 24.h),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: colors.activeButton.withOpacity(0.1),
            borderRadius: BorderRadius.circular(40.r),
          ),
          child: Icon(
            Icons.account_balance_wallet,
            size: 40.w,
            color: colors.activeButton,
          ),
        ),
        Text(
          'Web3Auth Login',
          style: fonts.bodyMedium,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 24.h),
        TextFormField(
          controller: _emailController,
          decoration: InputDecoration(
            labelText: 'Email Address',
            hintText: 'Enter your email',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28.r),
            ),
            prefixIcon: const Icon(Icons.email_outlined),
          ),
          keyboardType: TextInputType.emailAddress,
          enabled: !isAuthenticating,
        ),
        SizedBox(height: 16.h),
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: _emailController,
          builder: (context, value, child) {
            return PrimaryButton(
              text: 'Login with Email',
              onPressed: () {
                if (_emailController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Please enter an email address'),
                      backgroundColor: colors.redDefault,
                    ),
                  );
                  return;
                }
                context
                    .read<AuthBloc>()
                    .add(LoginWithEmail(_emailController.text));
              },
              isLoading: isAuthenticating,
              isEnabled: value.text.isNotEmpty,
            );
          },
        ),
        SizedBox(height: 24.h),
        Row(
          children: [
            Expanded(
                child: Divider(color: colors.inactiveButton, thickness: 1)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                'OR',
                style: TextStyle(color: colors.textSecondary),
              ),
            ),
            Expanded(
                child: Divider(color: colors.inactiveButton, thickness: 1)),
          ],
        ),
        SizedBox(height: 24.h),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: isAuthenticating
                    ? null
                    : () =>
                        context.read<AuthBloc>().add(const LoginWithGoogle()),
                icon: const Icon(Icons.g_mobiledata, size: 24),
                label: const Text('Google'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28.r),
                    side: BorderSide(color: colors.blueActive),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: isAuthenticating
                    ? null
                    : () =>
                        context.read<AuthBloc>().add(const LoginWithApple()),
                icon: const Icon(Icons.apple, size: 20),
                label: const Text('Apple'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLoggedInView(
    AuthState state,
    BuildContext context,
  ) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;
    final userInfo = state.userInfo;
    final blockchainName = state.selectedBlockchain.toString().split('.').last;
    final blockchainSymbol = _getBlockchainSymbol(state.selectedBlockchain);

    // Only disable during signing messages, not during wallet loading
    // since wallet loading has its own overlay
    final isSigningMessage = state.status == AuthStatus.signingMessage;

    return ListView(
      padding: EdgeInsets.symmetric(vertical: 24.h),
      children: [
        // User Info Card
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: colors.activeButton.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: colors.activeButton,
                    child: Text(
                      userInfo?.name?.isNotEmpty == true
                          ? userInfo!.name![0].toUpperCase()
                          : 'U',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome ${userInfo?.name ?? 'User'}',
                          style: fonts.textLgSemiBold,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          userInfo?.email ?? 'No email',
                          style: fonts.textSmRegular.copyWith(
                            color: colors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        SizedBox(height: 24.h),

        // Blockchain Selection with loading indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Select Blockchain',
              style: fonts.textLgSemiBold,
            ),
            // Show a small indicator when loading
            if (state.status == AuthStatus.loadingWallet)
              SizedBox(
                width: 18.w,
                height: 18.w,
                child: CircularProgressIndicator(
                  strokeWidth: 2.w,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      _getBlockchainColor(state.selectedBlockchain, context)),
                ),
              ),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildBlockchainButton(
              text: 'Ethereum',
              isSelected: state.selectedBlockchain == BlockchainType.ethereum,
              onTap:
                  isSigningMessage || state.status == AuthStatus.loadingWallet
                      ? null
                      : () => context
                          .read<AuthBloc>()
                          .add(const ChangeBlockchain(BlockchainType.ethereum)),
              context: context,
            ),
            _buildBlockchainButton(
              text: 'Solana',
              isSelected: state.selectedBlockchain == BlockchainType.solana,
              onTap:
                  isSigningMessage || state.status == AuthStatus.loadingWallet
                      ? null
                      : () => context
                          .read<AuthBloc>()
                          .add(const ChangeBlockchain(BlockchainType.solana)),
              context: context,
            ),
            _buildBlockchainButton(
                text: 'StarkNet',
                isSelected: state.selectedBlockchain == BlockchainType.starknet,
                onTap: isSigningMessage ||
                        state.status == AuthStatus.loadingWallet
                    ? null
                    : () => context
                        .read<AuthBloc>()
                        .add(const ChangeBlockchain(BlockchainType.starknet)),
                context: context),
          ],
        ),

        SizedBox(height: 24.h),

        // Wallet Info Card with loading indicators
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: colors.bgB0,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: colors.bgB3),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$blockchainName Wallet',
                    style: fonts.textLgSemiBold,
                  ),
                  SvgPicture.asset(
                    _getBlockchainIcon(state.selectedBlockchain),
                    color:
                        _getBlockchainColor(state.selectedBlockchain, context),
                  ),
                ],
              ),
              Divider(height: 24.h, color: colors.blueActive),

              // Address with shimmer effect during loading
              _buildWalletInfoItem(
                title: 'Address',
                value: state.walletAddress ?? 'Loading...',
                isLoading: state.status == AuthStatus.loadingWallet,
                context: context,
              ),
              SizedBox(height: 16.h),

              // Balance with shimmer effect during loading
              _buildWalletInfoItem(
                title: 'Balance',
                value: state.walletBalance != null
                    ? '${state.walletBalance} $blockchainSymbol'
                    : 'Loading...',
                isLoading: state.status == AuthStatus.loadingWallet,
                context: context,
              ),
            ],
          ),
        ),

        SizedBox(height: 24.h),

        // // ProviderId
        // Text(
        //   'Provider ID',
        //   style: fonts.textLgSemiBold,
        // ),
        // SizedBox(height: 12.h),
        // Container(
        //   decoration: BoxDecoration(
        //     color: colors.bgB0,
        //     borderRadius: BorderRadius.circular(16.r),
        //     border: Border.all(color: colors.bgB3),
        //   ),
        //   child: Padding(
        //     padding: EdgeInsets.all(16.w),
        //     child: Text(
        //       state.providerId ?? 'Loading...',
        //       style: fonts.textLgSemiBold,
        //     ),
        //   ),
        // ),
        // SizedBox(height: 16.h),

        // Signing Section
        Text(
          'Sign Message',
          style: fonts.textLgSemiBold,
        ),
        SizedBox(height: 12.h),
        TextFormField(
          controller: _messageController,
          decoration: InputDecoration(
            labelText: 'Message',
            hintText: 'Enter a message to sign',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28.r),
            ),
          ),
          maxLines: 2,
          enabled:
              !isSigningMessage && state.status != AuthStatus.loadingWallet,
        ),
        SizedBox(height: 16.h),
        PrimaryButton(
          text: 'Sign Message',
          onPressed: () => context
              .read<AuthBloc>()
              .add(SignMessage(_messageController.text)),
          isLoading: isSigningMessage,
          isEnabled: _messageController.text.isNotEmpty &&
              state.status != AuthStatus.loadingWallet,
        ),

        // Signature Display
        if (state.signature != null) ...[
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: colors.greenFill.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: colors.greenDefault.withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Signature',
                      style: fonts.textLgSemiBold.copyWith(
                        color: colors.greenDefault,
                      ),
                    ),
                    Icon(Icons.check_circle, color: colors.greenDefault),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  state.signature!,
                  style: fonts.bodyMedium,
                ),
              ],
            ),
          ),
        ],

        SizedBox(height: 24.h),

        // Logout button
        PrimaryButton(
          text: 'Logout',
          onPressed: () =>
              context.read<AuthBloc>().add(const LogoutRequested()),
          isEnabled:
              !isSigningMessage && state.status != AuthStatus.loadingWallet,
        ),
      ],
    );
  }

  Widget _buildWalletInfoItem({
    required String title,
    required String value,
    required bool isLoading,
    required BuildContext context,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.theme.fonts.textSmSemiBold.copyWith(
            color: context.theme.colors.textSecondary,
          ),
        ),
        SizedBox(height: 4.h),
        isLoading
            ? Container(
                height: 16.h,
                width: 150.w,
                decoration: BoxDecoration(
                  color: context.theme.colors.bgB0.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(4.r),
                ),
              )
            : Text(
                value,
                style: context.theme.fonts.textMdRegular,
              ),
      ],
    );
  }

  Widget _buildBlockchainButton({
    required String text,
    required bool isSelected,
    required VoidCallback? onTap,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected
              ? context.theme.colors.textPrimary
              : context.theme.colors.inactiveButton,
          borderRadius: BorderRadius.circular(28.r),
          border: Border.all(
            color: isSelected
                ? context.theme.colors.bgB1
                : context.theme.colors.bgB0,
          ),
        ),
        child: Text(
          text,
          style: context.theme.fonts.textSmSemiBold.copyWith(
            color: isSelected ? Colors.white : context.theme.colors.textPrimary,
          ),
        ),
      ),
    );
  }

  String _getBlockchainSymbol(BlockchainType type) {
    switch (type) {
      case BlockchainType.ethereum:
        return 'ETH';
      case BlockchainType.solana:
        return 'SOL';
      case BlockchainType.starknet:
        return 'STRK';
      default:
        return '';
    }
  }

  String _getBlockchainIcon(BlockchainType type) {
    switch (type) {
      case BlockchainType.ethereum:
        return AppIcons.ethereumIcon;
      case BlockchainType.solana:
        return AppIcons.appIcon;
      case BlockchainType.starknet:
        return AppIcons.stellar;
      default:
        return AppIcons.stellar;
    }
  }

  Color _getBlockchainColor(BlockchainType type, BuildContext context) {
    final colors = context.theme.colors;

    switch (type) {
      case BlockchainType.ethereum:
        return colors.activeButton;
      case BlockchainType.solana:
        return colors.activeButton;
      case BlockchainType.starknet:
        return colors.activeButton;
      default:
        return colors.activeButton;
    }
  }
}
