import 'package:flutter/material.dart';
import 'package:realm_roller/assets_handlers/generators_data.dart';
import 'package:realm_roller/assets_handlers/local_storage/local_storage.dart';

class FavoriteGeneratorTile extends StatefulWidget {
  const FavoriteGeneratorTile({super.key, required this.generatorName});

  final String generatorName;

  @override
  State<FavoriteGeneratorTile> createState() => _FavoriteGeneratorTileState();
}

class _FavoriteGeneratorTileState extends State<FavoriteGeneratorTile> {
  late bool value;

  @override
  void initState() {
    super.initState();
    value = LocalStorage.getFavoriteGenerators().contains(widget.generatorName);
  }

  void onChanged(bool newValue) {
    if (!newValue) {
      LocalStorage.removeFavoriteGenerators(widget.generatorName);
    } else {
      LocalStorage.addFavoriteGenerator(widget.generatorName);
    }
    setState(() {
      value = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: SwitchListTile(
        value: value,
        onChanged: onChanged,
        secondary: SizedBox(
          child: Icon(
            generatorsData[widget.generatorName]!.icon,
            color: Theme.of(context).primaryColor,
          ),
        ),
        title: Text(
          widget.generatorName,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
