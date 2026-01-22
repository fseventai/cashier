import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  static TextStyle get display => GoogleFonts.plusJakartaSans();

  // Headings
  static TextStyle get h1 => display.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    color: AppColors.emerald600,
    letterSpacing: -0.5,
  );

  static TextStyle get h2 => display.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.charcoal900,
  );

  static TextStyle get h3 => display.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.charcoal900,
  );

  // Body
  static TextStyle get bodyLarge => display.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textMain,
  );

  static TextStyle get bodyMedium => display.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textMain,
  );

  static TextStyle get bodySmall => display.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textMuted,
  );

  static TextStyle get bodyXSmall => display.copyWith(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: AppColors.textMuted,
  );

  // Specific UI elements
  static TextStyle get tableHeader => display.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w700, // font-bold in tailwind
    color: AppColors.emerald900,
    letterSpacing: 0.5, // tracking-wider
  );

  static TextStyle get buttonLabel => display.copyWith(
    fontSize: 10,
    fontWeight: FontWeight.w700,
    color: AppColors.charcoal800,
    letterSpacing: 0.5, // tracking-wider
  );

  static TextStyle get priceLarge => display.copyWith(
    fontSize: 48, // text-5xl
    fontWeight: FontWeight.w800,
    color: AppColors.emerald600,
    letterSpacing: -1.0, // tracking-tighter
  );
}
