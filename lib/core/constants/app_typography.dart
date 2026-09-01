import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTypography {
  static TextStyle headlineXl({Color color = AppColors.onSurface}) {
    return GoogleFonts.quicksand(
      fontSize: 32,
      fontWeight: FontWeight.w800,
      height: 1.25,
      color: color,
    );
  }

  static TextStyle headlineLg({Color color = AppColors.onSurface}) {
    return GoogleFonts.quicksand(
      fontSize: 26,
      fontWeight: FontWeight.w800,
      height: 1.3,
      color: color,
    );
  }

  static TextStyle headlineMd({Color color = AppColors.onSurface}) {
    return GoogleFonts.quicksand(
      fontSize: 21,
      fontWeight: FontWeight.w700,
      height: 1.35,
      color: color,
    );
  }

  static TextStyle bodyLg({Color color = AppColors.onSurfaceVariant}) {
    return GoogleFonts.plusJakartaSans(
      fontSize: 17,
      fontWeight: FontWeight.w600,
      height: 1.5,
      color: color,
    );
  }

  static TextStyle bodyMd({Color color = AppColors.onSurfaceVariant}) {
    return GoogleFonts.plusJakartaSans(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      height: 1.45,
      color: color,
    );
  }

  static TextStyle labelMd({Color color = AppColors.onSurface}) {
    return GoogleFonts.plusJakartaSans(
      fontSize: 15,
      fontWeight: FontWeight.w700,
      color: color,
    );
  }

  static TextStyle labelSm({Color color = AppColors.onSurfaceVariant}) {
    return GoogleFonts.plusJakartaSans(
      fontSize: 13,
      fontWeight: FontWeight.w700,
      color: color,
    );
  }
}

