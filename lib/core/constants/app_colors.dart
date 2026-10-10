import 'package:flutter/material.dart';

/// Bảng màu chuẩn của ứng dụng BillLens
/// Đã được đổi sang tông màu Tím sẫm (Indigo / Deep Purple)
/// mang lại cảm giác sang trọng, cao cấp và huyền bí.
class AppColors {
  AppColors._();

  // Primary palette (Tím / Indigo)
  static const Color primary = Color(0xFF4F46E5); // Indigo 600
  static const Color primaryLight = Color(0xFF818CF8); // Indigo 400
  static const Color primaryDark = Color(0xFF3730A3); // Indigo 800
  static const Color primaryContainer = Color(0xFFE0E7FF); // Indigo 100
  static const Color primaryContainerDark = Color(0xFF312E81); // Indigo 900

  // Secondary & Accent (Màu bổ trợ)
  static const Color secondary = Color(0xFFE11D48); // Rose 600
  static const Color accent = Color(0xFFF59E0B); // Amber 500

  // Neutral colors (Chế độ Sáng - Light Mode)
  static const Color background = Color(0xFFF1F5F9); // Slate 100
  static const Color surface = Colors.white;
  static const Color surfaceVariant = Color(0xFFF8FAFC); // Slate 50
  static const Color cardBg = Colors.white;
  static const Color border = Color(0xFFCBD5E1); // Slate 300

  // Neutral colors (Chế độ Tối - Dark Mode)
  static const Color darkBackground = Color(0xFF0F172A); // Slate 900 (Nền chính tối)
  static const Color darkSurface = Color(0xFF1E293B); // Slate 800 (Bề mặt component tối)
  static const Color darkSurfaceVariant = Color(0xFF334155); // Slate 700 (Thanh track, chip tối)
  static const Color darkCardBg = Color(0xFF1E293B); // Slate 800 (Nền thẻ tối)
  static const Color darkBorder = Color(0xFF334155); // Slate 700 (Đường viền tối)

  // Text colors (Chế độ Sáng)
  static const Color textPrimary = Color(0xFF0F172A); // Slate 900
  static const Color textSecondary = Color(0xFF475569); // Slate 600
  static const Color textMuted = Color(0xFF94A3B8); // Slate 400

  // Text colors (Chế độ Tối)
  static const Color darkTextPrimary = Color(0xFFF8FAFC); // Slate 50
  static const Color darkTextSecondary = Color(0xFF94A3B8); // Slate 400
  static const Color darkTextMuted = Color(0xFF64748B); // Slate 500

  // Semantic Status colors (Trạng thái)
  static const Color success = Color(0xFF10B981); // Emerald 500
  static const Color warning = Color(0xFFF59E0B); // Amber 500
  static const Color error = Color(0xFFEF4444); // Red 500
}

/// Extension tiện ích mở rộng trên BuildContext giúp lấy màu sắc thích ứng tự động theo Theme
extension ThemeContextExtension on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  Color get scaffoldBg => isDark ? AppColors.darkBackground : AppColors.background;
  Color get cardBg => isDark ? AppColors.darkCardBg : AppColors.cardBg;
  Color get surfaceBg => isDark ? AppColors.darkSurface : AppColors.surface;
  Color get surfaceVariantBg => isDark ? AppColors.darkSurfaceVariant : AppColors.surfaceVariant;
  Color get textPrimary => isDark ? AppColors.darkTextPrimary : AppColors.textPrimary;
  Color get textSecondary => isDark ? AppColors.darkTextSecondary : AppColors.textSecondary;
  Color get textMuted => isDark ? AppColors.darkTextMuted : AppColors.textMuted;
  Color get borderColor => isDark ? AppColors.darkBorder : AppColors.border;
}
