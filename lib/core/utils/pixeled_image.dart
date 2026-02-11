import 'dart:math';

import 'package:flutter/material.dart';

class PixelatedAvatar extends StatefulWidget {
  final double size;
  final int gridSize;
  final List<Color> colorPalette;
  final double borderRadius;
  final String? seed;

  const PixelatedAvatar({
    Key? key,
    this.size = 40,
    this.gridSize = 10,
    this.colorPalette = const [
      Color(0xFF7770C3),
      Color(0xFFF6686D),
      Color(0xFFB96C97),
      Color(0xFF936EB0),
      Color(0xFF5373DB),
      Color(0xFFE76977),
      Color(0xFF3075F3),
      Color(0xFFAB6DA0),
    ],
    this.borderRadius = 8.0,
    this.seed,
  }) : super(key: key);

  @override
  State<PixelatedAvatar> createState() => _PixelatedAvatarState();
}

class _PixelatedAvatarState extends State<PixelatedAvatar> {
  late List<List<Color>> pixelGrid;
  late Random random;

  @override
  void initState() {
    super.initState();

    random = widget.seed != null ? Random(widget.seed.hashCode) : Random();
    generatePixelGrid();
  }

  void generatePixelGrid() {
    pixelGrid = List.generate(
      widget.gridSize,
      (row) => List.generate(
        widget.gridSize,
        (col) =>
            widget.colorPalette[random.nextInt(widget.colorPalette.length)],
      ),
    );
  }

  void regenerate() {
    setState(() {
      random = Random();
      generatePixelGrid();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.seed == null ? regenerate : null,
      child: Container(
        width: widget.size,
        height: widget.size,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
        ),
        child: CustomPaint(
          painter: PixelAvatarPainter(pixelGrid: pixelGrid),
          size: Size(widget.size, widget.size),
        ),
      ),
    );
  }
}

class PixelAvatarPainter extends CustomPainter {
  final List<List<Color>> pixelGrid;

  PixelAvatarPainter({required this.pixelGrid});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final pixelSize = size.width / pixelGrid.length;

    for (int row = 0; row < pixelGrid.length; row++) {
      for (int col = 0; col < pixelGrid[row].length; col++) {
        paint.color = pixelGrid[row][col];

        final rect = Rect.fromLTWH(
          col * pixelSize,
          row * pixelSize,
          pixelSize,
          pixelSize,
        );

        canvas.drawRect(rect, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class AvatarPalettes {
  static const List<Color> purplePink = [
    Color(0xFF7770C3),
    Color(0xFFF6686D),
    Color(0xFFB96C97),
    Color(0xFF936EB0),
    Color(0xFF5373DB),
    Color(0xFFE76977),
    Color(0xFF3075F3),
    Color(0xFFAB6DA0),
    Color(0xFFA56DA4),
    Color(0xFFBF6B92),
    Color(0xFF3D74EA),
    Color(0xFFD56A83),
  ];

  static const List<Color> yellowPurple = [
    Color(0xFFAE953D),
    Color(0xFFBEA437),
    Color(0xFFFADD24),
    Color(0xFFECD028),
    Color(0xFF3D2961),
    Color(0xFF644E55),
    Color(0xFF1D0B6C),
    Color(0xFF362364),
    Color(0xFF16046E),
    Color(0xFFE5C92B),
    Color(0xFFF5D825),
    Color(0xFF5D4857),
  ];

  static const List<Color> ocean = [
    Color(0xFF0077BE),
    Color(0xFF00A8CC),
    Color(0xFF0099CC),
    Color(0xFF007BA7),
    Color(0xFF005F75),
    Color(0xFF003D4A),
    Color(0xFF80E0FF),
    Color(0xFF4DC3E6),
    Color(0xFF26A8CC),
  ];

  static const List<Color> sunset = [
    Color(0xFFFF6B6B),
    Color(0xFFFF8E53),
    Color(0xFFFF6B9D),
    Color(0xFFC44569),
    Color(0xFFF8B500),
    Color(0xFFFF7675),
    Color(0xFFFD79A8),
    Color(0xFFE17055),
    Color(0xFFFF9FF3),
  ];

  static const List<Color> forest = [
    Color(0xFF27AE60),
    Color(0xFF2ECC71),
    Color(0xFF00B894),
    Color(0xFF00A085),
    Color(0xFF16A085),
    Color(0xFF1ABC9C),
    Color(0xFF55A3FF),
    Color(0xFF26DE81),
    Color(0xFF2DD4BF),
  ];

  static const List<Color> monochrome = [
    Color(0xFF2C3E50),
    Color(0xFF34495E),
    Color(0xFF4A4A4A),
    Color(0xFF6C7B7F),
    Color(0xFF95A5A6),
    Color(0xFFBDC3C7),
    Color(0xFFD5DBDB),
    Color(0xFFECF0F1),
    Color(0xFFF8F9FA),
  ];
}
