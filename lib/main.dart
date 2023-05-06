import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:realm_roller/custom_widgets/entity_pages/entity_page.dart';
import 'package:realm_roller/custom_widgets/expanded_paragraphs/expanded_paragraph.dart';
import 'package:realm_roller/custom_widgets/generator_pages/generator_page.dart';
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
    return SafeArea(
      child: Material(
        child: GeneratorPage(
          title: "Settlement Generator",
          children: [
            Dropdown(
              title: "Race",
              icon: Icons.groups,
              currentValue: "Random",
              options: const ["Random", "Elf", "Dwarf"],
              onChanged: (a) => {},
            ),
            const SizedBox(height: 28),
            Dropdown(
              title: "Race",
              icon: Icons.groups,
              currentValue: "Random",
              options: const ["Random", "Elf", "Dwarf"],
              onChanged: (a) => {},
            ),
          ],
        ),
      ),
    );
  }
}
