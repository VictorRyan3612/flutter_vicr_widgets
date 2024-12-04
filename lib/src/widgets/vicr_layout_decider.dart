import 'package:flutter/material.dart';


class VicrLayoutDecider extends StatelessWidget {
  final ValueNotifier<bool>? isMobile;
  final Widget optionMobile;
  final Widget optionDesktop;
  final int? maxSize;

  const VicrLayoutDecider({
    Key? key, 
    this.isMobile, 
    this.maxSize,
    required this.optionMobile, 
    required this.optionDesktop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var finalIsMobile = isMobile ?? ValueNotifier(false);
    var finalMaxSize = maxSize ?? 600;
    return LayoutBuilder(
      builder: (context, constraints){
        finalIsMobile.value = constraints.maxWidth < finalMaxSize;
        return finalIsMobile.value ? optionMobile : optionDesktop;        
      },
    );
  }
}
