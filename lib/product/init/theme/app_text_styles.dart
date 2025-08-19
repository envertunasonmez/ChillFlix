import 'package:chillflix_app/product/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle headLineStyle({
    double? fontSize = 18.0,
    Color? color = ColorConstants.whiteColor,
    FontWeight? fontWeight = FontWeight.w500,
  }) {
    return GoogleFonts.figtree(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
    );
  }

  static TextStyle bodyStyle({
    double? fontSize = 16.0,
    Color? color = ColorConstants.whiteColor,
    FontWeight? fontWeight = FontWeight.normal,
    TextDecoration? decoration,
  }) {
    return GoogleFonts.figtree(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      decoration: decoration,
    );
  }

  static TextStyle buttonStyle({
    double? fontSize = 16.0,
    Color? color = ColorConstants.whiteColor,
    FontWeight? fontWeight = FontWeight.w400,
  }) {
    return GoogleFonts.figtree(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
    );
  }

  static TextStyle appbarStyle({
    double? fontSize = 20.0,
    Color? color = ColorConstants.whiteColor,
    FontWeight? fontWeight = FontWeight.w500,
  }) {
    return GoogleFonts.figtree(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
    );
  }
}