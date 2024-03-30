import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:randpg/entities/emblems.dart';
import 'package:randpg/string_manipulations.dart';
import 'package:realm_roller/assets_handlers/local_storage/local_storage.dart';
import 'package:realm_roller/assets_handlers/local_storage/saver_data.dart';

class TypeTile extends StatefulWidget {
  const TypeTile({super.key, required this.type});

  final dynamic type;

  @override
  State<TypeTile> createState() => _TypeTileState();
}

class _TypeTileState extends State<TypeTile> {
  late bool value;

  @override
  void initState() {
    super.initState();
    value = LocalStorage.isRegistered(widget.type);
  }

  void onChanged(bool newValue) {
    if (!newValue) {
      if (!LocalStorage.unregisterType(widget.type)) {
        return;
      }
    } else {
      LocalStorage.registerType(widget.type);
    }
    setState(() {
      value = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: value,
      onChanged: onChanged,
      activeColor: Theme.of(context).primaryColor,
      secondary: widget.type is SvgWrapper
          ? SvgPicture.string(
              (widget.type as SvgWrapper).content,
              width: MediaQuery.of(context).size.width * 0.25,
              height: MediaQuery.of(context).size.width * 0.25,
            )
          : null,
      title: Text(
        titled(getTypeKey(widget.type)),
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
