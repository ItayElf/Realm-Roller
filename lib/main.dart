import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:randpg/entities/npcs.dart';
import 'package:randpg/entities/races.dart';
import 'package:randpg/generators.dart';
import 'package:realm_roller/pages/npcs/npc_generation/npc_generation_page.dart';
import 'package:realm_roller/theme/theme_data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final npc = NpcGenerator(
      ListItemGenerator(RaceManager.activeRaces).generate(),
    ).generate();

    return MaterialApp(
      title: 'Realm Roller',
      theme: themeData,
      home: const NpcGenerationPage(),
    );
  }
}
