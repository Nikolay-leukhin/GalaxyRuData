part of 'utils.dart';

class AppTypography {
  static final TextStyle _font = GoogleFonts.montserrat(color: Colors.white);

  static final font16w400  =_font.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static final font16w600  =_font.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static final font24w700  =_font.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );
}