import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:her_wellness_calender/features/auth/splash/presentation/controllers/splash_controller.dart';

import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final compact = size.height < 680;
    final logoSize = compact ? 92.0 : 108.0;
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFFF1F3), Color(0xFFFFFBFC), Color(0xFFF5FCFA)],
          ),
        ),
        child: Stack(
          children: [
            const Positioned.fill(
              child: CustomPaint(painter: _SplashTexturePainter()),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: size.height * (compact ? 0.23 : 0.27),
              child: const CustomPaint(painter: _SplashFoldPainter()),
            ),
            SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 32,
                    right: 32,
                    top: size.height * (compact ? 0.13 : 0.17),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _LogoBadge(size: logoSize),
                      SizedBox(height: compact ? 26 : 34),
                      Text(
                        WellnessConstants.appTitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: WellnessColors.primaryDeep,
                          fontSize: compact ? 36 : 42,
                          fontWeight: FontWeight.w800,
                          height: 1,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'TRACK. UNDERSTAND. THRIVE.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF75666E),
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          height: 1.4,
                          letterSpacing: 0,
                        ),
                      ),
                      SizedBox(height: compact ? 54 : 70),
                      Container(
                        width: 88,
                        height: 3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(999),
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFF8CA8), Color(0xFFFFD5DF)],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'INITIALIZING CARE',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFD7C6CC),
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LogoBadge extends StatelessWidget {
  const _LogoBadge({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFCEBFC4).withValues(alpha: 0.35),
            blurRadius: 28,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      padding: EdgeInsets.all(size * 0.18),
      child: Image.asset(
        'assets/images/wozone_logo.png',
        fit: BoxFit.contain,
      ),
    );
  }
}

class _SplashTexturePainter extends CustomPainter {
  const _SplashTexturePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final sheenPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withValues(alpha: 0.20),
          Colors.white.withValues(alpha: 0.0),
          WellnessColors.glowPeach.withValues(alpha: 0.16),
        ],
        stops: const [0.0, 0.48, 1.0],
      ).createShader(Offset.zero & size);

    final path = Path()
      ..moveTo(size.width * 0.05, 0)
      ..quadraticBezierTo(
        size.width * 0.55,
        size.height * 0.12,
        size.width,
        size.height * 0.02,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, sheenPaint);
  }

  @override
  bool shouldRepaint(covariant _SplashTexturePainter oldDelegate) => false;
}

class _SplashFoldPainter extends CustomPainter {
  const _SplashFoldPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final basePaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFFFEEE8), Color(0xFFF8D7CC), Color(0xFFEFC6BC)],
      ).createShader(Offset.zero & size);

    final basePath = Path()
      ..moveTo(0, size.height * 0.18)
      ..cubicTo(
        size.width * 0.22,
        size.height * 0.34,
        size.width * 0.42,
        0,
        size.width * 0.64,
        size.height * 0.18,
      )
      ..cubicTo(
        size.width * 0.82,
        size.height * 0.33,
        size.width * 0.92,
        size.height * 0.22,
        size.width,
        size.height * 0.08,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(basePath, basePaint);

    final highlightPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..color = Colors.white.withValues(alpha: 0.42);
    final shadowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..color = const Color(0xFFC89288).withValues(alpha: 0.26);

    for (var i = 0; i < 7; i++) {
      final y = size.height * (0.18 + i * 0.105);
      final path = Path()
        ..moveTo(-size.width * 0.05, y)
        ..cubicTo(
          size.width * 0.24,
          y + size.height * 0.18,
          size.width * 0.42,
          y - size.height * 0.12,
          size.width * 0.68,
          y + size.height * 0.05,
        )
        ..cubicTo(
          size.width * 0.83,
          y + size.height * 0.15,
          size.width * 0.95,
          y + size.height * 0.04,
          size.width * 1.06,
          y - size.height * 0.06,
        );
      canvas.drawPath(path.shift(const Offset(0, 5)), shadowPaint);
      canvas.drawPath(path, highlightPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _SplashFoldPainter oldDelegate) => false;
}
