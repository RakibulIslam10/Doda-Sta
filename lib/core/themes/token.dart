import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'model.dart';
part 'custom_colors.dart';

part 'themes.dart';

// LIGHT THEME DATA - - - - - - - - - - - - - - - - -

//    appBar: AppBar(
//       title: Text('Login'),
//       systemOverlayStyle: SystemUiOverlayStyle(
//         statusBarColor: Colors.red, // যে color চান
//         statusBarIconBrightness: Brightness.light,
//         statusBarBrightness: Brightness.dark,
//       ),
//     ),



//    return AnnotatedRegion<SystemUiOverlayStyle>(
//       value: SystemUiOverlayStyle(
//         statusBarColor: Colors.blue, // যে color চান
//         statusBarIconBrightness: Brightness.light, // white icons
//         statusBarBrightness: Brightness.dark, // iOS এর জন্য
//       ),

final ThemeData lightThemeData = ThemeData.light().copyWith(
  primaryColor: CustomColors.primary,
  dividerColor: Colors.transparent,
  brightness: Brightness.light,
  splashColor: Colors.transparent,
  colorScheme: ColorScheme.light(tertiary: CustomColors.tertiary),
  scaffoldBackgroundColor: CustomColors.whiteColor,
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  ),
  textTheme: ThemeData.light().textTheme.apply(
    // fontFamily: GoogleFonts.montserrat().fontFamily,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      backgroundColor: CustomColors.primary,
      side: BorderSide(color: CustomColors.primary),
    ),
  ),
);

// DARK THEME DATA - - - - - - - - - - - - - - - - -

final ThemeData darkThemeData = ThemeData.dark().copyWith(
  primaryColor: CustomColors.primaryDark,
  colorScheme: ColorScheme.dark(surface: CustomColors.tertiaryDark),
  scaffoldBackgroundColor: CustomColors.backgroundDark,
  brightness: Brightness.dark,
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
  ),
  textTheme: ThemeData.dark().textTheme.apply(
    // fontFamily: GoogleFonts.inter().fontFamily,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      backgroundColor: CustomColors.primary,
      side: BorderSide(color: CustomColors.primary),
    ),
  ),
);