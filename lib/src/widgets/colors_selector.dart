import 'package:flutter/material.dart';


/*

Better use of this class:
var color = await showDialog(context: context, builder: (context) {
  return AlertDialog(
    content: ColorSelector(),
  );
}); 

*/
class ColorSelector extends StatelessWidget {
  final List<MaterialColor>? colors;
  const ColorSelector({super.key, this.colors });
  

  @override
  Widget build(BuildContext context) {
    var colorsFinal = colors ?? [Colors.red, Colors.green, Colors.blue, Colors.yellow, Colors.orange, Colors.purple, Colors.teal];
    return Container(
      width: 400,
      height: 400,
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            children: colorsFinal.map((itemColor) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context, itemColor);
                  },
                  child: Container(
                    color: itemColor,
                    height: 100,
                    width: 100,
                  ),
                ),
              );
            }).toList()
          ),
        ),
      ),
    );
  }
}