
import 'dart:io';

import 'package:arrivo/domain/configure/colors.dart';
import 'package:arrivo/domain/configure/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class ThemeService {
  static InputDecoration grabTextFieldDecoration(// Text Field Label Name
    String tfName, 
    { 
      // Enable Edit?
      bool enabled = true, 
      // Show Label?
      bool showLabel = true, 
      // Show Border?
      bool showBorder = true,
      // Show Filled Color ?
      bool showFilled = true, 
      // Is Password Text Field?
      bool isPassword = false, 
      // Suffix Icon Button Function
      VoidCallback? onSuffixPressed, 
      // Icon Controller for Password Text Field
      bool showPass = false, 
      // Show Prefix Icon?
      bool showPrefix = false,
      // Show Suffix Icon? 
      bool showSuffix = false,
      // Prefix Icon Data 
      Icon prefixIcon = const Icon(Icons.search, color: ColorConfig.grey),
      // Suffix Icon Data
      Icon suffixIcon = const Icon(Icons.search, color: ColorConfig.grey),
      Widget? prefixWidget,
      // Hint Text
      String? hintText
    }
  ){
    return InputDecoration(
      enabled: enabled,
      prefixIcon: showPrefix ? (prefixWidget ?? prefixIcon) : null,
      suffixIcon: showSuffix
      ? IconButton(
          icon: isPassword 
          ? Icon(showPass 
              ? Icons.visibility : Icons.visibility_off,
              color: ColorConfig.grey,
            )
          : suffixIcon,
          onPressed: onSuffixPressed)
      : null,
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      errorMaxLines: 4,
      fillColor: ColorConfig.grey.withOpacity(0.1),
      filled: showFilled,
      focusedBorder: showBorder ? focusBorder : noneBorder,
      enabledBorder: showBorder ? focusBorder : noneBorder,
      focusedErrorBorder: showBorder ? errorBorder : noneBorder,
      errorBorder: showBorder ? errorBorder : noneBorder,
      disabledBorder: disableBorder,
      hintStyle: regularTextStyle(color: ColorConfig.grey),
      labelStyle: regularTextStyle(),
      errorStyle: regularTextStyle().copyWith(color: ColorConfig.error, fontSize: 10),
      labelText: showLabel ? tfName : null,
      hintText: hintText ?? tfName
    );
  }

  //--------------------//
  //    D.Grey Color
  //--------------------//
  static final OutlineInputBorder focusBorder = OutlineInputBorder(
    borderSide: BorderSide(color: ColorConfig.grey, width: 1.5),
    borderRadius: BorderRadius.circular(10),
  );

  //------------------//
  //    Error Color
  //------------------//
  static final OutlineInputBorder errorBorder = OutlineInputBorder(
    borderSide: BorderSide(color: ColorConfig.error, width: 1.5),
    borderRadius: BorderRadius.circular(10),
  );

  //------------------//
  //    Grey Color
  //------------------//
  static final OutlineInputBorder disableBorder = OutlineInputBorder(
    borderSide: BorderSide(color: ColorConfig.grey, width: 1.5),
    borderRadius: BorderRadius.circular(10),
  );

  //-------------------------//
  //    Transparent Color
  //-------------------------//
  static final OutlineInputBorder noneBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: ColorConfig.transparent, width: 0.0),
    borderRadius: BorderRadius.circular(10),
  );

   static final List<BoxShadow> defaultBoxShadow = [
    BoxShadow(
      color: ColorConfig.black.withOpacity(0.3),
      offset: const Offset(
        0.0,
        3.0,
      ),
      blurRadius: 3.0,
      spreadRadius: 0.1
    )
  ];


  //==============================================================================================================================//
  //                                                     Status bar Style
  //==============================================================================================================================//
  static SystemUiOverlayStyle defaultStatusBarStyle() {
    return SystemUiOverlayStyle(
      statusBarColor: ColorConfig.white,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: (Platform.isIOS || Platform.isMacOS) ? Brightness.light : Brightness.light,
    );
  }

  static MaterialColor createMaterialColor(Color color) {
    List<int> strengths = <int>[50, 100, 200, 300, 400, 500, 600, 700, 800, 900];
    Map<int, Color> swatch = <int, Color>{};

    final int r = color.red, g = color.green, b = color.blue;

    for (int strength in strengths) {
      swatch[strength] = Color.fromRGBO(r, g, b, 1);
    }

    return MaterialColor(color.value, swatch);
  }

  static TextStyle getTextStyle({TextFamily? textFamily, double? fontSize, Color? color}) {
    return TextStyle(
      fontSize: fontSize ?? 14,
      color: color ?? ColorConfig.black,
      fontFamily: textFamily == TextFamily.regular
          ? 'HNRegular'
          : textFamily == TextFamily.light
              ? 'HNLight'
              : 'HNBold',
    );
  }

  static TextStyle regularTextStyle({double? fontSize, Color? color, TextDecoration? textDecoration, FontStyle? fontStyle, FontWeight? fontWeight}) {
    return TextStyle(
      fontSize: fontSize ?? 14,
      color: color ?? ColorConfig.black,
      decoration: textDecoration,
      fontStyle: fontStyle,
      fontWeight: fontWeight,
      fontFamily: 'Lato-Regular',
    );
  }

  static TextStyle lightTextStyle({double? fontSize, Color? color, TextDecoration? textDecoration, FontStyle? fontStyle}) {
    return TextStyle(
      fontSize: fontSize ?? 14,
      color: color ?? ColorConfig.black,
      decoration: textDecoration,
      fontStyle: fontStyle,
      fontFamily: 'Lato-Light',
    );
  }

  static TextStyle boldTextStyle({double? fontSize, Color? color, TextDecoration? textDecoration, FontStyle? fontStyle}) {
    return TextStyle(
      fontSize: fontSize ?? 14,
      color: color ?? ColorConfig.black,
      decoration: textDecoration,
      fontStyle: fontStyle,
      fontWeight: FontWeight.bold,
      // fontFamily: 'Lato-Bold',
    );
  }

  static TextStyle mediumTextStyle({double? fontSize, Color? color, TextDecoration? textDecoration, FontStyle? fontStyle}) {
    return TextStyle(
      fontSize: fontSize ?? 14,
      color: color ?? ColorConfig.black,
      decoration: textDecoration,
      fontStyle: fontStyle,
      fontFamily: 'HNMedium',
    );
  }

  static TextStyle underlineTextStyle({double? fontSize, double? spacing, double? thickness}) {
    return TextStyle(
      shadows: [
        Shadow(
          color: Colors.white,
          offset: Offset(0, -spacing!),
        ),
      ],
      fontSize: fontSize ?? 14,
      color: Colors.transparent,
      decoration: TextDecoration.underline,
      decorationColor: Colors.white,
      decorationThickness: thickness,
      fontFamily: 'HNBold',
    );
  }

  static TextStyle titleTextStyle() {
    return const TextStyle(
      fontSize: 16.0,
      color: ColorConfig.black,
      fontFamily: 'HNBold',
    );
  }
}  





