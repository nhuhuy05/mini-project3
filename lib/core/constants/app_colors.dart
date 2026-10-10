import 'package:flutter/material.dart';

/// Bảng màu chuẩn của ứng dụng SpendWise
/// Sử dụng tông màu Tím Hoàng Gia (Royal Violet) kết hợp Hồng Neon (Fuchsia/Rose)
/// mang lại diện mạo tài chính thông minh, đẳng cấp và hoàn toàn khác biệt bản cũ.
class AppColors {
  AppColors._();

  // Primary palette (Tím Hoàng Gia - Royal Violet)
  static const Color primary = Color(0xFF7C3AED); // Violet 600
  static const Color primaryLight = Color(0xFFA78BFA); // Violet 400
  static const Color primaryDark = Color(0xFF5B21B6); // Violet 800
  static const Color primaryContainer = Color(0xFFEDE9FE); // Violet 100
  static const Color primaryContainerDark = Color(0xFF2E1065); // Violet 950

  // Secondary & Accent (Hồng Neon & Cam Hổ Phách)
  static const Color secondary = Color(0xFFF43F5E); // Rose 500
  static const Color secondaryLight = Color(0xFFFB7185); // Rose 400
  static const Color accent = Color(0xFFF59E0B); // Amber 500

  // Gradient màu chuẩn cho Scan Banner & Action Cards
  static const List<Color> bannerGradient = [
    Color(0xFF6D28D9), // Deep Royal Violet
    Color(0xFF8B5CF6), // Bright Violet
    Color(0xFFC026D3), // Vivid Fuchsia
  ];

  // Neutral colors (Chế độ Sáng - Light Mode)
  static const Color background = Color(0xFFF8FAFC); // Slate 50
  static const Color surface = Colors.white;
  static const Color surfaceVariant = Color(0xFFF1F5F9); // Slate 100
  static const Color cardBg = Colors.white;
  static const Color border = Color(0xFFE2E8F0); // Slate 200

  // Neutral colors (Chế độ Tối - Dark Mode)
  static const Color darkBackground = Color(0xFF0F172A); // Slate 900
  static const Color darkSurface = Color(0xFF1E293B); // Slate 800
  static const Color darkSurfaceVariant = Color(0xFF334155); // Slate 700
  static const Color darkCardBg = Color(0xFF1E293B); // Slate 800
  static const Color darkBorder = Color(0xFF334155); // Slate 700

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
