import 'package:flutter/material.dart';


class VicrLayoutDecider extends StatelessWidget {
  final ValueNotifier<bool> isMobile;
  final Widget optionMobile;
  final Widget optionDesktop;

  const VicrLayoutDecider({Key? key, required this.isMobile, required this.optionMobile, required this.optionDesktop}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints){
        isMobile.value = constraints.maxWidth < 600;
        return isMobile.value ? optionMobile : optionDesktop;        
      },
    );
  }
}
