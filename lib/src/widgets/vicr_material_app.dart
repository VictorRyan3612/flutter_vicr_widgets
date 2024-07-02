import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_vicr_widgets/src/service/settings_data_service.dart';
import 'package:flutter_vicr_widgets/src/service/theme.dart';
import 'package:flutter_vicr_widgets/src/widgets/config_screen.dart';
import 'package:flutter_vicr_widgets/src/widgets/layout_decider.dart';

class VictMaterialApp extends HookWidget {
  final Map<String, Widget Function(BuildContext)> routes;
  
  const VictMaterialApp({super.key, required this.routes});


  @override
  Widget build(BuildContext context) {
    // base states 
    final currentIsDarkMode = useState(settingsService.isDarkMode.value); //Theme
    final currentColor = useState(settingsService.colorName.value); // Accent color

    final finalTheme = setTheme(currentIsDarkMode.value, currentColor.value);
    
    routes['/configs'] = (context) => ConfigScreen(
      currentColor: currentColor, 
      currentIsDarkMode: currentIsDarkMode
    );
    return MaterialApp(
      theme: finalTheme,
      debugShowCheckedModeBanner: false,

      initialRoute: '/',
      routes: routes
    );
  }
}
