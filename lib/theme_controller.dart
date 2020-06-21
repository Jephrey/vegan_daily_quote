
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends RxController {
  static ThemeController get to => Get.find();

  SharedPreferences prefs;
  var theme = ThemeMode.dark.obs;
  ThemeMode get themeMode => theme.value;

  Future<void> setThemeMode(ThemeMode themeMode) async {
    Get.changeThemeMode(themeMode);
    theme.value = themeMode;
    prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', themeMode.toString().split('.')[1]);
  }

  getThemeModeFromPreferences() async {
    ThemeMode themeMode;
    prefs = await SharedPreferences.getInstance();
    String themeText = prefs.getString('theme') ?? 'system';
    try {
      themeMode =
          ThemeMode.values.firstWhere((e) => describeEnum(e) == themeText);
    } catch (e) {
      themeMode = ThemeMode.system;
    }
    setThemeMode(themeMode);
  }
}