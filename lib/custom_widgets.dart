import 'package:flutter/material.dart';

class Dropdown extends StatelessWidget {
  final String title;
  final List<String> items;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;
  const Dropdown(
      {Key? key,
      required this.title,
      required this.items,
      required this.onChanged,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        icon: const Icon(Icons.keyboard_arrow_down),
        hint: Text(
          title,
          style: const TextStyle(color: Colors.grey),
          textAlign: TextAlign.end,
        ),
        items: items.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        }).toList(),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}
