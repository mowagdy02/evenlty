import 'package:flutter/material.dart';
import 'colors.dart';
import 'styles.dart';

class AppTheme {
  static final ThemeData light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    textTheme: TextTheme(
      headlineLarge: AppStyles.s24SemiBoldLight,
      headlineMedium: AppStyles.s20SemiBoldLight,
      headlineSmall: AppStyles.s18SemiBoldLight,
      displayLarge: AppStyles.s14SemiBoldLight,


      titleLarge: AppStyles.s16MediumLight,
      titleMedium: AppStyles.s14MediumLight,

      bodyLarge: AppStyles.s16RegularLight,
      bodyMedium: AppStyles.s14RegularLight,
      bodySmall: AppStyles.s12RegularLight,
    ),
  );

  static final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    textTheme: TextTheme(
      headlineLarge: AppStyles.s24SemiBoldDark,
      headlineMedium: AppStyles.s20SemiBoldDark,
      headlineSmall: AppStyles.s18SemiBoldDark,
      displayLarge: AppStyles.s14SemiBoldDark,

      titleLarge: AppStyles.s16MediumDark,
      titleMedium: AppStyles.s14MediumDark,

      bodyLarge: AppStyles.s16RegularDark,
      bodyMedium: AppStyles.s14RegularDark,
      bodySmall: AppStyles.s12RegularDark,
    ),
  );
}
