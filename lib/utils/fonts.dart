part of 'utils.dart';

class AppTypography {
  static final TextStyle _font = GoogleFonts.montserrat(color: Colors.white);

  static final font16w400 = _font.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static final font16w700 = _font.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  static final font14w400 = _font.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static final font16w600 = _font.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static final font20w600 = _font.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static final font16w600underline = _font.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    decoration: TextDecoration.underline,
  );

  static final font24w700 = _font.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );

  static final font12w400 =
      _font.copyWith(fontSize: 12, fontWeight: FontWeight.w400);

  static final font16w500 =
      _font.copyWith(fontSize: 16, fontWeight: FontWeight.w500);

  static final font28w600 = _font.copyWith(
    fontSize: 28,
    fontWeight: FontWeight.w600,
  );

  static final font18w400 = _font.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );
}
