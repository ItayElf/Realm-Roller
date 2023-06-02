import 'package:flutter/material.dart';

class MainMenuItem extends StatelessWidget {
  const MainMenuItem({
    super.key,
    required this.title,
    required this.icon,
    this.onClick,
  });

  final IconData icon;
  final String title;
  final void Function(BuildContext)? onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick != null ? () => onClick!(context) : null,
      child: Row(
        children: [
          Icon(
            icon,
            size: Theme.of(context).textTheme.headlineSmall!.fontSize,
            color: Colors.white,
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: Colors.white),
          )
        ],
      ),
    );
  }
}
