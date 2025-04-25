import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreateTransactionPinScreen extends StatefulWidget {
  const CreateTransactionPinScreen({super.key});

  @override
  State<CreateTransactionPinScreen> createState() =>
      _CreateTransactionPinScreenState();
}

class _CreateTransactionPinScreenState
    extends State<CreateTransactionPinScreen> {
  final TextEditingController _pinController = TextEditingController();
  final int _pinLength = 4;
  String _pin = '';

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  void _onNumberPressed(String number) {
    if (_pin.length < _pinLength) {
      setState(() {
        _pin += number;
      });
    }
  }

  void _onBackspace() {
    if (_pin.isNotEmpty) {
      setState(() {
        _pin = _pin.substring(0, _pin.length - 1);
      });
    }
  }

  Widget _buildPinDot(bool isActive) {
    return Container(
      width: 48,
      height: 48,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        border: Border.all(
          color: isActive ? const Color(0xFFA6B7D4) : const Color(0xFFA6B7D4),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: isActive
          ? Center(
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFFA6B7D4),
                  shape: BoxShape.circle,
                ),
              ),
            )
          : null,
    );
  }

  Widget _buildNumberButton(String number) {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF666666).withOpacity(0.05),
      ),
      child: TextButton(
        onPressed: () => _onNumberPressed(number),
        style: TextButton.styleFrom(
          shape: const CircleBorder(),
          padding: EdgeInsets.zero,
        ),
        child: Text(
          number,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1A1A1A),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: Color(0xFF1A1A1A)),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              height: 36,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFFEEEEEE),
                  width: 1,
                ),
              ),
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/headset.svg',
                      width: 16,
                      height: 16,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFF1A1A1A),
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'Need Help?',
                      style: TextStyle(
                        color: Color(0xFF1A1A1A),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Text(
                'Create transaction pin',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Add a transaction pin to secure your access to your account and get strong and secure',
                style: TextStyle(
                  color: Color(0xFF666666),
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pinLength,
                  (index) => _buildPinDot(index < _pin.length),
                ),
              ),
              const SizedBox(height: 70),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNumberButton('1'),
                      _buildNumberButton('2'),
                      _buildNumberButton('3'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNumberButton('4'),
                      _buildNumberButton('5'),
                      _buildNumberButton('6'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNumberButton('7'),
                      _buildNumberButton('8'),
                      _buildNumberButton('9'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(width: 72),
                      _buildNumberButton('0'),
                      Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF666666).withOpacity(0.05),
                        ),
                        child: IconButton(
                          onPressed: _onBackspace,
                          icon: const Icon(
                            CupertinoIcons.delete_left,
                            color: Color(0xFF1A1A1A),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  color: const Color(0xFF1A1A1A),
                ),
                child: ElevatedButton(
                  onPressed: _pin.length == _pinLength ? () {} : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A1A1A),
                    disabledBackgroundColor:
                        const Color(0xFF1A1A1A).withOpacity(0.5),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
