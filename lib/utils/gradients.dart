part of 'utils.dart';

class AppGradients {
  static const pinIndicator = RadialGradient(
    center: Alignment(0.48, 0.62),
    radius: 0.8,
    colors: [Color(0xFF4AFFC8), Color(0xFF60FF67), Color(0xFFB3FF85)],
  );

  static const lightBlue = RadialGradient(
    center: Alignment.center,
    radius: 5,
    colors: [
      Color(0xFF0F7CD1),
      Color(0xff3799FB),
    ],
  );

  static const skyBlue = LinearGradient(
    end: Alignment.topRight,
    begin: Alignment.bottomLeft,
    colors: [Color(0xFF30F0E2), Color(0xFF04C2FB), Color(0xFF1788FA)],
  );

  static const radialSky = RadialGradient(
    center: Alignment(-0.11, -0.70),
    radius: 8,
    colors: [Color(0xFF55A3FF), Color(0xFF1A75B7), Color(0xFF0049D8)],
  );

  static const oceanBlue = LinearGradient(
    begin: Alignment(-1, 0),
    end: Alignment(1, 0),
    colors: [
      Color(0xFF45DDC2),
      Color(0xFF00C8FB),
      Color(0xFF3799FA),
      Color(0xFF007CF9)
    ],
  );

  static const space = LinearGradient(
    end: Alignment(-0.96, -0.29),
    begin: Alignment(0.96, 0.29),
    colors: [
      Color(0xFF42FFD8),
      Color(0xFF00C8FB),
      Color(0xFF2791FA),
      Color(0xFF007CF9)
    ],
  );
}
