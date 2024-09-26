import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Adapted from 
// https://github.com/VictorRyan3612/Flutter_Music_Player_App/commit/545a007638702a0819cf190a80b707c103d96f16


class ExtensibleLateralBarItem {
  final Icon icon;
  final Text title;
  final VoidCallback onTap;

  const ExtensibleLateralBarItem({required this.icon, required this.title, required this.onTap});
}


class VicrExtensibleLateralBar extends HookWidget {
  final List<ExtensibleLateralBarItem> items;
  final List<ExtensibleLateralBarItem>? trailingItems;
  const VicrExtensibleLateralBar({super.key, required this.items, this.trailingItems});

  @override
  Widget build(BuildContext context) {
    Color colorContainer = Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white;
    var isOpen = useState(true);

    format(ExtensibleLateralBarItem item){
      if(isOpen.value == true){
        return ListTile(
          leading: item.icon,
          title: item.title,
          onTap: item.onTap
        );
      }
      else{
        return IconButton(
          onPressed: item.onTap,
          icon: item.icon,
          tooltip: item.title.data,
        );
      }
    }

    return SizedBox(
      width: isOpen.value == true ? 200 : 80,
      child: Material(
        color: colorContainer,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  isOpen.value = !isOpen.value;
                }, 
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return format(items[index]);
                  },
                ),
              ),
              if(trailingItems != null)
              Expanded(
                child: Column(
                  children: [
                    Divider(),
                    Expanded(
                      child: ListView.builder(
                        itemCount: trailingItems?.length,
                        itemBuilder: (context, index) {
                          return format(trailingItems![index]);
                        },
                      ),
                    ),
                  ],
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}