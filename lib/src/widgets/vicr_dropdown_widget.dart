import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Adapted from:
// https://github.com/VictorRyan3612/Flutter_Music_Player_App/blob/7921e1a34241251fcde01de5c3c3e661ec503f69/music_player_app/lib/widgets/dropdown.dart

class VicrDropdownWidget extends HookWidget {
  final List<String> menuItems;
  final Function(String? newValue) onChanged;

  const VicrDropdownWidget({super.key, required this.onChanged, required this.menuItems});

  @override
  Widget build(BuildContext context) {

    List<DropdownMenuItem<String>> dropdownMenuItems = menuItems.map(
      (String value) => DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      ),
    ).toList();

    var textValue = useState<String?>(null);

    return DropdownButton(
      value: textValue.value,
      hint: const Text('Choose'),
      onChanged: (String? newValue) {
        if (newValue != null) {
          textValue.value = newValue;
        }
        onChanged(newValue);
      },
      items: dropdownMenuItems,
    );
  }
}
