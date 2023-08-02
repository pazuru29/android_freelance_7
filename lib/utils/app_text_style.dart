import 'dart:ui';

class AppTextStyles {
  //Special
  static const AppStyle specialNumber = AppStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.0037,
  );

  //Header
  static const AppStyle headerSemibold = AppStyle(
    fontSize: 34,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.0037,
  );

  static const AppStyle headerRegular = AppStyle(
    fontSize: 22,
    fontWeight: FontWeight.w400,
  );

  //Body
  static const AppStyle bold1 = AppStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
  );

  static const AppStyle bold2 = AppStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );

  static const AppStyle bodySemibold = AppStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  static const AppStyle bodyRegular = AppStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.0037,
  );

  //Caption
  static const AppStyle captionRegular = AppStyle(
    fontSize: 17,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.0037,
  );

  static const AppStyle captionMedium = AppStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.0037,
  );

  //Bebas Neue Header
  static const AppStyle number1 = AppStyle(
    fontSize: 120,
    fontWeight: FontWeight.w700,
    fontFamily: 'Bebas Neue',
  );

  static const AppStyle number2 = AppStyle(
    fontSize: 100,
    fontWeight: FontWeight.w700,
    fontFamily: 'Bebas Neue',
  );
}

class AppStyle {
  final double fontSize;
  final FontWeight fontWeight;
  final String fontFamily;
  final double letterSpacing;

  const AppStyle({
    required this.fontSize,
    required this.fontWeight,
    this.fontFamily = 'SF Pro',
    this.letterSpacing = 0,
  });
}
