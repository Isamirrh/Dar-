import 'package:flutter/material.dart';
import 'package:dar_plus/theme/app_colors.dart';

class AppTheme extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark; // Default to dark mode

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        primaryColor: AppColors.primaryLight,
        hintColor: AppColors.accentLight,
        scaffoldBackgroundColor: AppColors.backgroundLight,
        cardColor: AppColors.surfaceLight,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.backgroundLight,
          foregroundColor: AppColors.textLight,
          elevation: 0,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(color: AppColors.textLight, fontSize: 32, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(color: AppColors.textLight, fontSize: 28, fontWeight: FontWeight.bold),
          displaySmall: TextStyle(color: AppColors.textLight, fontSize: 24, fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(color: AppColors.textLight, fontSize: 20, fontWeight: FontWeight.bold),
          headlineSmall: TextStyle(color: AppColors.textLight, fontSize: 18, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(color: AppColors.textLight, fontSize: 16, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(color: AppColors.textLight, fontSize: 16),
          bodyMedium: TextStyle(color: AppColors.textLight, fontSize: 14),
          labelLarge: TextStyle(color: AppColors.textLight, fontSize: 14, fontWeight: FontWeight.bold),
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: AppColors.buttonPrimary,
          textTheme: ButtonTextTheme.primary,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.buttonPrimary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primaryLight,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.surfaceLight,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.textSecondaryLight.withOpacity(0.3), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primaryLight, width: 2),
          ),
          labelStyle: const TextStyle(color: AppColors.textSecondaryLight),
          hintStyle: const TextStyle(color: AppColors.textSecondaryLight),
        ),
        cardTheme: CardTheme(
          color: AppColors.cardBackgroundLight,
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.backgroundLight,
          selectedItemColor: AppColors.primaryLight,
          unselectedItemColor: AppColors.textSecondaryLight,
          type: BottomNavigationBarType.fixed,
        ),
      );

  ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        primaryColor: AppColors.primaryDark,
        hintColor: AppColors.accentDark,
        scaffoldBackgroundColor: AppColors.backgroundDark,
        cardColor: AppColors.surfaceDark,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.backgroundDark,
          foregroundColor: AppColors.textDark,
          elevation: 0,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(color: AppColors.textDark, fontSize: 32, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(color: AppColors.textDark, fontSize: 28, fontWeight: FontWeight.bold),
          displaySmall: TextStyle(color: AppColors.textDark, fontSize: 24, fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(color: AppColors.textDark, fontSize: 20, fontWeight: FontWeight.bold),
          headlineSmall: TextStyle(color: AppColors.textDark, fontSize: 18, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(color: AppColors.textDark, fontSize: 16, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(color: AppColors.textDark, fontSize: 16),
          bodyMedium: TextStyle(color: AppColors.textDark, fontSize: 14),
          labelLarge: TextStyle(color: AppColors.textDark, fontSize: 14, fontWeight: FontWeight.bold),
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: AppColors.buttonPrimary,
          textTheme: ButtonTextTheme.primary,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.buttonPrimary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primaryDark,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.surfaceDark,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.textSecondaryDark.withOpacity(0.3), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primaryDark, width: 2),
          ),
          labelStyle: const TextStyle(color: AppColors.textSecondaryDark),
          hintStyle: const TextStyle(color: AppColors.textSecondaryDark),
        ),
        cardTheme: CardTheme(
          color: AppColors.cardBackgroundDark,
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.backgroundDark,
          selectedItemColor: AppColors.primaryDark,
          unselectedItemColor: AppColors.textSecondaryDark,
          type: BottomNavigationBarType.fixed,
        ),
      );
}
