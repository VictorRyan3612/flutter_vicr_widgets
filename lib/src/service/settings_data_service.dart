import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  ValueNotifier<bool> isDarkMode = ValueNotifier(true);
  ValueNotifier<String> colorName = ValueNotifier('Blue');
  
  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    final isDarkMode = prefs.getBool('vicrIsDarkMode') ?? settingsService.isDarkMode.value;
    settingsService.isDarkMode.value = isDarkMode;

    final colorTheme = prefs.getString('vicrColorTheme') ?? settingsService.colorName.value;
    settingsService.colorName.value = colorTheme;
  }
  
  Future<void> saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    
    prefs.setBool('isDarkMode', isDarkMode.value);
    prefs.setString('colorTheme', colorName.value);
  }
}
SettingsService settingsService = SettingsService();
