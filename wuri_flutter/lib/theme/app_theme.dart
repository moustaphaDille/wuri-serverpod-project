import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Les couleurs de la charte Sahel.
class AppColors {
  static const sand = Color(0xFFFAF6F0);
  static const sandDeep = Color(0xFFEFE7DA);
  static const indigo = Color(0xFF1F3A5F);
  static const terracotta = Color(0xFFC8553D);
  static const terracottaTint = Color(0xFFF6DDD6);
  static const indigoTint = Color(0xFFDCE1EA);
  static const border = Color(0xFFE8DFD1);
  static const muted = Color(0xFF6B6558);
  static const shadow = Color(0x1A1F3A5F);
}

/// Ombre douce commune aux éléments en relief.
const softShadow = [
  BoxShadow(color: AppColors.shadow, blurRadius: 16, offset: Offset(0, 6)),
];

ThemeData buildAppTheme() {
  final scheme = ColorScheme.fromSeed(
    seedColor: AppColors.indigo,
    brightness: Brightness.light,
  ).copyWith(
    primary: AppColors.indigo,
    onPrimary: AppColors.sand,
    secondary: AppColors.terracotta,
    onSecondary: Colors.white,
    surface: AppColors.sand,
    onSurface: AppColors.indigo,
    outline: AppColors.border,
  );

  final base = ThemeData(useMaterial3: true, colorScheme: scheme);

  // Police Plus Jakarta Sans (téléchargée au premier lancement, puis gardée).
  final textTheme = GoogleFonts.plusJakartaSansTextTheme(base.textTheme).apply(
    bodyColor: AppColors.indigo,
    displayColor: AppColors.indigo,
  );

  TextStyle? label(FontWeight weight, double size) =>
      textTheme.labelLarge?.copyWith(fontWeight: weight, fontSize: size);

  OutlineInputBorder inputBorder(Color color, [double width = 1]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  return base.copyWith(
    textTheme: textTheme,
    scaffoldBackgroundColor: AppColors.sand,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.sand,
      foregroundColor: AppColors.indigo,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleTextStyle: textTheme.titleLarge?.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w800,
        color: AppColors.indigo,
      ),
    ),
    // Cartes blanches arrondies, avec une ombre douce (pas de bordure).
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 3,
      shadowColor: AppColors.shadow,
      surfaceTintColor: Colors.transparent,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    // Le bouton d'action principal est une pilule terracotta.
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.terracotta,
        foregroundColor: Colors.white,
        disabledBackgroundColor: AppColors.border,
        minimumSize: const Size.fromHeight(52),
        shape: const StadiumBorder(),
        textStyle: label(FontWeight.w700, 15),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.indigo,
        minimumSize: const Size.fromHeight(52),
        side: const BorderSide(color: AppColors.indigo, width: 1.2),
        shape: const StadiumBorder(),
        textStyle: label(FontWeight.w700, 15),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.terracotta,
        textStyle: label(FontWeight.w700, 14),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      labelStyle: const TextStyle(color: AppColors.muted),
      border: inputBorder(AppColors.border),
      enabledBorder: inputBorder(AppColors.border),
      focusedBorder: inputBorder(AppColors.indigo, 1.5),
      errorBorder: inputBorder(const Color(0xFFB3261E)),
      focusedErrorBorder: inputBorder(const Color(0xFFB3261E), 1.5),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.white,
      elevation: 8,
      shadowColor: AppColors.shadow,
      surfaceTintColor: Colors.transparent,
      height: 68,
      indicatorColor: AppColors.terracottaTint,
      indicatorShape: const StadiumBorder(),
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      iconTheme: WidgetStateProperty.resolveWith((states) {
        final selected = states.contains(WidgetState.selected);
        return IconThemeData(
          size: 24,
          color: selected ? AppColors.terracotta : AppColors.muted,
        );
      }),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        final selected = states.contains(WidgetState.selected);
        return textTheme.labelMedium?.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: selected ? AppColors.terracotta : AppColors.muted,
        );
      }),
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.indigo,
      contentTextStyle:
          textTheme.bodyMedium?.copyWith(color: AppColors.sand),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    ),
    segmentedButtonTheme: SegmentedButtonThemeData(
      style: SegmentedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: AppColors.indigo,
        selectedBackgroundColor: AppColors.indigo,
        selectedForegroundColor: AppColors.sand,
        side: const BorderSide(color: AppColors.border),
        shape: const StadiumBorder(),
        textStyle: label(FontWeight.w700, 13),
      ),
    ),
    dividerTheme: const DividerThemeData(color: AppColors.border, space: 1),
  );
}