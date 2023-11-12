part of 'utils.dart';

class AppGradients {
  static const pinIndicatorGradient = RadialGradient(
    center: Alignment(0.48, 0.62),
    radius: 0.8,
    colors: [Color(0xFF4AFFC8), Color(0xFF60FF67), Color(0xFFB3FF85)],
  );

  static const skyBlue = LinearGradient(
    end: Alignment.topRight,
    begin: Alignment.bottomLeft,
    colors: [Color(0xFF30F0E2), Color(0xFF04C2FB), Color(0xFF1788FA)],
  );

  static const radialSky = RadialGradient(
    center: Alignment( - 0.41,- 0.70),
    radius: 8,
    colors: [Color(0xFF55A3FF), Color(0xFF1A75B7), Color(0xFF0049D8)],
  );
}
