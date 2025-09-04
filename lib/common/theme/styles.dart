part of '../theme.dart';

abstract class AppTextStyles {
  static TextStyle interW400Black(double fontSize) {
    return TextStyle(
      fontFamily: FontFamily.inter,
      height: 1,
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
      color: AppColors.black,
    );
  }

  static TextStyle interW400Grey(double fontSize) {
    return TextStyle(
      fontFamily: FontFamily.inter,
      height: 1,
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
      color: AppColors.grey,
    );
  }

  static TextStyle interW300Black(double fontSize) {
    return TextStyle(
      fontFamily: FontFamily.inter,
      height: 1,
      fontSize: fontSize,
      fontWeight: FontWeight.w300,
      color: AppColors.black,
    );
  }

}