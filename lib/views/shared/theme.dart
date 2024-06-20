import 'package:flutter/material.dart';

// Colors

const Color textHeaderColor = Color(0xff04305F);
const Color iconColor = Color(0xff3E5F90); //0xff04305F);

const Color categoryIconLightColor = Color(0xffFFFFFF);
const Color categoryIconLightBackgroundColor = Color(0xffD5E3FF);
const Color categoryIconDarkColor = Color(0xff04305F);
const Color categoryIconDarkBackgroundColor = Color(0xff3E5F90);

const Color containerColor = Color(0xffEDF5FE);
const Color containerColorSplash = Color(0xffa7c8ff);
const Color fridgeColor = Color(0xffA7C8FF);
const Color backgroundDarkColor = Color(0xff3E5F90);

const Color fontColorBright = Color(0xffEDF5FE);
const Color fontColorLight = Color(0xff6C6C6C);
const Color fontColorBlue = Color(0xff3E5F90);
const Color fontColorWarning = Color(0xffA7382F);
const Color primaryBlue = Color(0xff3E5F90);
const Color selectedCategory = Color(0xffA7C8FF);

// TextStyles
const TextStyle headerStyle = TextStyle(color: textHeaderColor);
const TextStyle productTileNameStyle =
    TextStyle(color: fontColor, fontSize: 20);
const TextStyle productTileCategoryStyle =
    TextStyle(color: fontColor, fontSize: 15);
const TextStyle productTileDaysLeftStyle =
    TextStyle(color: fontColor, fontSize: 14);

const Color backgroundLightColor = Colors.white;
const Color textLightColor = Colors.black87;
const Color accentColor = Color(0xff7ACBFF);



// LIGHT THEME COLORS
const Color baseThemeColor = Colors.blueAccent;
const Color loadingScreenBackgroundColor = Color(0xff04305F);
const Color backgroundHeaderColor = Color(0xffa7c8ff);
const Color fontColor = Color(0xff191C20);

const Color primaryColor = Color(0xff3E5F90);
const Color secondaryColor = Color(0xffA7C8FF);
const Color tertiaryColor = Color(0xffEDF5FE);

// DARK THEME COLORS
const Color darkBaseThemeColor = Color(0xFF264C70);
const Color darkLoadingScreenBackgroundColor = Color(0xFFb3204f);
const Color darkBackgroundHeaderColor = Color(0xff1f1f1f);
const Color darkFontColor = Color(0xffEDF5FE);

const Color darkPrimaryColor = Color(0xff1a1a1a);
const Color darkSecondaryColor = Color(0xff1f1f1f);
const Color darkTertiaryColor = Color(0xff3a3a3a);
const Color darkHighlightColor = Color(0xff3E5F90);

final ThemeData lightTheme = ThemeData(
  appBarTheme: const AppBarTheme(
      backgroundColor: backgroundHeaderColor,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: fontColor,
        fontSize: 24,
      ),
      iconTheme: IconThemeData(
        color: fontColor,
      )),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black, fontSize: 16),
    bodyMedium: TextStyle(color: Colors.black, fontSize: 14),
  ),
  colorScheme: const ColorScheme(
    background: Colors.white,
    brightness: Brightness.light,
    primary: primaryColor,
    onPrimary: Color(0xffEDF5FE),
    secondary: secondaryColor,
    onSecondary: Color(0xffEDF5FE),
    tertiary: tertiaryColor,
    error: Color(0xffA7382F),
    onError: Color(0xffEDF5FE),
    onBackground: Color(0xff191C20),
    surface: Colors.white,
    onSurface: Color(0xff7ACBFF),
  ),
);


final ThemeData darkTheme = ThemeData(
  appBarTheme: const AppBarTheme(
      backgroundColor: darkBackgroundHeaderColor,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: darkFontColor,
        fontSize: 24,
      ),
      iconTheme: IconThemeData(
        color: darkFontColor,
      )),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white70, fontSize: 16),
    bodyMedium: TextStyle(color: Colors.white70, fontSize: 14),
  ),
  colorScheme: const ColorScheme(
    background: Color(0xFF2B2B2B),
    brightness: Brightness.dark,
    primary: darkPrimaryColor,
    secondary: darkSecondaryColor,
    tertiary: darkTertiaryColor,
    onPrimary: Color(0xffEDF5FE),
    onSecondary: darkHighlightColor,
    error: Color(0xffA7382F),
    onError: Color(0xffEDF5FE),
    onBackground: Color(0xff191C20),
    surface: Colors.white,
    onSurface: Color(0xff7ACBFF),
  ),
);

// ThemeData lightMode = ThemeData(
//     brightness: Brightness.light,
//     colorScheme: ColorScheme.light(
//
//     )
// )

// ThemeData lightTheme = ThemeData(
//   primaryColor: backgroundHeaderColor,
//   primaryColorDark: textHeaderColor
// );
//
// ThemeData darkTheme = ThemeData(
//   primarySwatch: Colors.grey,
//   accentColor: Colors.lightBlue,
//   scaffoldBackgroundColor: Colors.black87,
//   textTheme: TextTheme(
//     bodyText1: TextStyle(color: Colors.white),
//     headline1: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
//   ),
//   appBarTheme: AppBarTheme(
//     color: Colors.grey[850],
//     elevation: 4,
//   ),
// );
