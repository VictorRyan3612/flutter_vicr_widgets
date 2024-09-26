import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_vicr_widgets/src/service/settings_data_service.dart';
import 'package:flutter_vicr_widgets/src/service/theme.dart';
import 'package:flutter_vicr_widgets/src/widgets/vicr_config_screen.dart';


class VicrMaterialApp extends HookWidget {
  final Map<String, Widget Function(BuildContext)>? routes;
  final ConfigWidgets? configWidget;
  const VicrMaterialApp({super.key, this.routes, this.configWidget});

  loadSettings(){
    settingsService.loadSettings();
  }
  @override
  Widget build(BuildContext context) {

    // base states 
    final currentIsDarkMode = useState(settingsService.isDarkMode.value); //Theme
    final currentColor = useState(settingsService.colorName.value); // Accent color

    final finalTheme = setTheme(currentIsDarkMode.value, currentColor.value);

    routes?['/configs'] = (context) => VicrConfigScreen(
      currentColor: currentColor, 
      currentIsDarkMode: currentIsDarkMode,
      configWidget: configWidget,
    );

    return MaterialApp(
      theme: finalTheme,
      debugShowCheckedModeBanner: false,

      initialRoute: '/',
      routes: routes ?? {}
    );
  }
}
