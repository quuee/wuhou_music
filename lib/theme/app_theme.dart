
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';


///白天模式
ThemeData lightTheme = FlexThemeData.light(
  colors: const FlexSchemeColor(
    primary: Color(0xff065808),
    primaryContainer: Color(0xff9ee29f),
    secondary: Color(0xff365b37),
    secondaryContainer: Color(0xffaebdaf),
    tertiary: Color(0xff2c7e2e),
    tertiaryContainer: Color(0xffb8e6b9),
    appBarColor: Color(0xffb8e6b9),
    error: Color(0xffb00020),
  ),
  surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
  blendLevel: 7,
  appBarStyle: FlexAppBarStyle.material,
  appBarOpacity: 0.87,
  transparentStatusBar: false,
  appBarElevation: 12.5,
  subThemesData: const FlexSubThemesData(
    useTextTheme: true,
    useM2StyleDividerInM3: true,
    tabBarIndicatorWeight: 5,
    tabBarIndicatorTopRadius: 6,
  ),
  keyColors: const FlexKeyColors(
    useSecondary: true,
    useTertiary: true,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
  swapLegacyOnMaterial3: true,
  // To use the Playground font, add GoogleFonts package and uncomment
  // fontFamily: GoogleFonts.notoSans().fontFamily,
);


///夜间模式
ThemeData darkTheme = FlexThemeData.dark(
  colors: const FlexSchemeColor(
    primary: Color(0xff629f80),
    primaryContainer: Color(0xff274033),
    secondary: Color(0xff81b39a),
    secondaryContainer: Color(0xff4d6b5c),
    tertiary: Color(0xff88c5a6),
    tertiaryContainer: Color(0xff356c50),
    appBarColor: Color(0xff356c50),
    error: Color(0xffcf6679),
  ),
  surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
  blendLevel: 13,
  transparentStatusBar: false,
  subThemesData: const FlexSubThemesData(
    useTextTheme: true,
    useM2StyleDividerInM3: true,
    tabBarIndicatorWeight: 5,
    tabBarIndicatorTopRadius: 6,
  ),
  keyColors: const FlexKeyColors(
    useSecondary: true,
    useTertiary: true,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
  swapLegacyOnMaterial3: true,
  // To use the Playground font, add GoogleFonts package and uncomment
  // fontFamily: GoogleFonts.notoSans().fontFamily,
);
