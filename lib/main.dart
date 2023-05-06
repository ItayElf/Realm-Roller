import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:realm_roller/custom_widgets/entity_pages/entity_page.dart';
import 'package:realm_roller/theme/theme_data.dart';

import 'custom_widgets/dropdowns/dropdown.dart';

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
    return MaterialApp(
      title: 'Realm Roller',
      theme: themeData,
      home: const MyHomePage(title: 'Realm Roller'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: EntityPage(
          title: "Names",
          subtitle: "Mixed dwarfs",
          imagePath: "assets/races/dwarf.webp",
          children: [
            Dropdown(
              title: "Settlement:",
              icon: Icons.location_city,
              currentValue: "Random",
              onChanged: (value) => print(value),
              options: const [
                "Random",
                "Hamlet",
                "Village",
                "Town",
                "City",
                "Metropolis"
              ],
            ),
            const SizedBox(height: 24),
            Dropdown(
              title: "Dominant Race:",
              icon: Icons.groups,
              currentValue: "Random",
              onChanged: (value) => print(value),
              options: const [
                "Random",
                "Dragonborn",
                "Dwarf",
                "Elf",
                "Orc",
                "Tiefling",
              ],
            ),
          ],
        ),
      ),
    );
  }
}
