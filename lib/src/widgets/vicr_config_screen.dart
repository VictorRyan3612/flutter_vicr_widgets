import 'package:flutter/material.dart';
import 'package:flutter_vicr_widgets/src/service/settings_data_service.dart';


class ConfigWidgets extends StatelessWidget {
  final List<Widget>? leadingWidedgets;
  final List<Widget>? trailingWidgets;
  
  const ConfigWidgets({super.key, this.leadingWidedgets, this.trailingWidgets});

  @override
  Widget build(BuildContext context) {
    return this;
  }
}

class VicrConfigScreen extends StatelessWidget {
  final ValueNotifier<bool> currentIsDarkMode;
  final ValueNotifier<String> currentColor;
  final ConfigWidgets? configWidget;

  const VicrConfigScreen({super.key, required this.currentIsDarkMode, required this.currentColor, this.configWidget});
  @override
  Widget build(BuildContext context) {
    List<Widget> finalList = [];
    if (configWidget != null && configWidget?.leadingWidedgets != null){
      finalList.addAll(configWidget!.leadingWidedgets!);
    }
    finalList.add(
      ListTile(
        title: Text("Modo Escuro"),
        trailing: Switch(
          value: currentIsDarkMode.value, 
          onChanged: (value) {
            currentIsDarkMode.value = value;
            settingsService.isDarkMode.value = value;
            settingsService.saveSettings();
          },
        ),
      )
    );
    if (configWidget != null && configWidget?.trailingWidgets != null){
      finalList.addAll(configWidget!.trailingWidgets!);
    }
    settingsService.loadSettings();
    return Scaffold(
      appBar: AppBar(title: Text("Configurações"),),
      
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: ListView.separated(
                itemCount: finalList.length,
                itemBuilder: (context, index) {
                  return finalList[index];
                },
                separatorBuilder: (context, index) {
                  return Divider();
                }, 
              )
            ),
          ),
        ),
      ),
    );
  }
}
