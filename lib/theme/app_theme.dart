import 'package:flutter/material.dart';

abstract final class AppColors {
  static const brand = Color(0xFFE84848);
  static const accent = Color(0xFFB45309);
  static const background = Color(0xFFF5F5F7);
  static const surface = Color(0xFFFFFFFF);
  static const field = Color(0xFFF2F2F6);
  static const primaryText = Color(0xFF1A1A1E);
  static const secondaryText = Color(0xFF5B5B66);
  static const mutedText = Color(0xFF6B6D78);
  static const divider = Color(0xFFEDEDF1);
}

abstract final class AppTheme {
  static final light = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme:
        ColorScheme.fromSeed(
          seedColor: AppColors.brand,
          brightness: Brightness.light,
        ).copyWith(
          primary: AppColors.brand,
          surface: AppColors.background,
          onSurface: AppColors.primaryText,
        ),
    splashFactory: InkRipple.splashFactory,
  );
}
