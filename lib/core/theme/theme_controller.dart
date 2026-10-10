import 'package:flutter/material.dart';

/// Controller quản lý chế độ giao diện Sáng / Tối (Theme Mode)
/// Hỗ trợ chuyển đổi mượt mà giữa Light Mode và Dark Mode theo chuẩn Material 3
class ThemeController extends ChangeNotifier {
  ThemeController._internal();
  static final ThemeController instance = ThemeController._internal();

  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  /// Đảo ngược giữa chế độ Sáng và Tối
  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

  /// Đặt chế độ theme cụ thể (Light, Dark, hoặc System)
  void setThemeMode(ThemeMode mode) {
    if (_themeMode != mode) {
      _themeMode = mode;
      notifyListeners();
    }
  }
}
