import 'package:flutter/material.dart';

/// A dropdown used in the generation pages
class Dropdown extends StatelessWidget {
  const Dropdown({
    super.key,
    required this.title,
    required this.icon,
    required this.currentValue,
    required this.options,
    required this.onChanged,
  });

  final String title;
  final IconData icon;
  final String currentValue;
  final List<String> options;
  final void Function(String?) onChanged;

  static const _dropdownPadding = 24.0;
  static const _iconSizeMultiplier = 0.075;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getDropdownSize(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          getTitle(context),
          const SizedBox(height: 4),
          getDropdown(context),
        ],
      ),
    );
  }

  SizedBox getDropdown(BuildContext context) {
    return SizedBox(
      width: getDropdownSize(context),
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 2, 16, 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black),
        ),
        child: DropdownButton(
          value: currentValue,
          onChanged: onChanged,
          isExpanded: true,
          iconSize: 40,
          icon: const Icon(
            Icons.expand_more,
            color: Colors.black,
          ),
          underline: Container(),
          style: Theme.of(context).textTheme.bodyLarge,
          items: options.map(getMenuItem).toList(),
        ),
      ),
    );
  }

  Row getTitle(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Icon(
          icon,
          size: getDropdownSize(context) * _iconSizeMultiplier,
          color: Theme.of(context).primaryColor,
        ),
        const SizedBox(width: 5),
        SelectableText(
          title,
          style: Theme.of(context).textTheme.headlineSmall,
        )
      ],
    );
  }

  DropdownMenuItem<String> getMenuItem(String option) => DropdownMenuItem(
        value: option,
        child: Text(
          option,
        ),
      );

  double getDropdownSize(BuildContext context) =>
      MediaQuery.of(context).size.width - _dropdownPadding * 2;
}
