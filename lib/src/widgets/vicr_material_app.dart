import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_vicr_widgets/src/service/settings_data_service.dart';
import 'package:flutter_vicr_widgets/src/service/theme.dart';
import 'package:flutter_vicr_widgets/src/widgets/vicr_config_screen.dart';

class VicrMaterialApp extends HookWidget {
  final MaterialApp? materialApp;
  final ConfigWidgets? configWidget;
  final Map<String, Widget Function(BuildContext)>? routes;
  
  // Construtor que recebe o MaterialApp original
  VicrMaterialApp({this.materialApp, this.configWidget, this.routes});

  static staticLoadSettings(){
    settingsService.loadSettings();
  }
  void loadSettings(){
    settingsService.loadSettings();
  }
  @override
  Widget build(BuildContext context) {

    // Se materialApp for null, usamos um MaterialApp vazio com valores padrão
    
    // Estado para o tema e cor de destaque
    final currentIsDarkMode = useState(settingsService.isDarkMode.value);
    final currentColor = useState(settingsService.colorName.value);
    // Defina o tema com base nas configurações atuais
    final finalTheme = materialApp?.theme ?? setTheme(currentIsDarkMode.value, currentColor.value);

    var finalNavigatorObservers = materialApp?.navigatorObservers ?? <NavigatorObserver>[];

    var finalRoutes = routes ?? materialApp?.routes ?? <String, Widget Function(BuildContext)>{};

    // Se configWidget não for nulo, adicione a rota para a tela de configurações
    if (configWidget != null) {
      finalRoutes['/configs'] = (context) => VicrConfigScreen(
        currentColor: currentColor,
        currentIsDarkMode: currentIsDarkMode,
        configWidget: configWidget,
      );
    }

    return MaterialApp(
      theme: finalTheme,
      routes: finalRoutes,
      key: materialApp?.key,
      navigatorKey: materialApp?.navigatorKey,
      scaffoldMessengerKey: materialApp?.scaffoldMessengerKey,
      home: materialApp?.home,
      initialRoute: materialApp?.initialRoute,
      onGenerateRoute: materialApp?.onGenerateRoute,
      onGenerateInitialRoutes: materialApp?.onGenerateInitialRoutes,
      onUnknownRoute: materialApp?.onUnknownRoute,
      onNavigationNotification: materialApp?.onNavigationNotification,
      navigatorObservers: finalNavigatorObservers,
      builder: materialApp?.builder,
      title: materialApp?.title ?? '',
      onGenerateTitle: materialApp?.onGenerateTitle,
      color: materialApp?.color,
      darkTheme: materialApp?.darkTheme,
      highContrastTheme: materialApp?.highContrastTheme,
      highContrastDarkTheme: materialApp?.highContrastDarkTheme,
      themeMode: materialApp?.themeMode ?? ThemeMode.system,
      themeAnimationDuration: materialApp?.themeAnimationDuration ?? kThemeAnimationDuration,
      themeAnimationCurve: materialApp?.themeAnimationCurve ?? Curves.linear,
      locale: materialApp?.locale,
      localizationsDelegates: materialApp?.localizationsDelegates,
      localeListResolutionCallback: materialApp?.localeListResolutionCallback,
      localeResolutionCallback: materialApp?.localeResolutionCallback,
      supportedLocales: materialApp?.supportedLocales ?? [Locale('en', 'US')],
      debugShowMaterialGrid: materialApp?.debugShowMaterialGrid ?? false,
      showPerformanceOverlay: materialApp?.showPerformanceOverlay ?? false,
      checkerboardRasterCacheImages: materialApp?.checkerboardRasterCacheImages ?? false,
      checkerboardOffscreenLayers: materialApp?.checkerboardOffscreenLayers ?? false,
      showSemanticsDebugger: materialApp?.showSemanticsDebugger ?? false,
      debugShowCheckedModeBanner: materialApp?.debugShowCheckedModeBanner ?? true,
      shortcuts: materialApp?.shortcuts,
      actions: materialApp?.actions,
      restorationScopeId: materialApp?.restorationScopeId,
      scrollBehavior: materialApp?.scrollBehavior,
      themeAnimationStyle: materialApp?.themeAnimationStyle,
    );
  }
}
