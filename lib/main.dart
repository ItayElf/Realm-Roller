import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:realm_roller/custom_widgets/entity_pages/entity_page.dart';
import 'package:realm_roller/custom_widgets/expanded_paragraphs/expanded_paragraph.dart';
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
    return const Material(
      child: SafeArea(
        child: EntityPage(
          title: "Names",
          subtitle: "Mixed dwarfs",
          imagePath: "assets/races/dwarf.webp",
          children: [
            ExpandedParagraph(
              title: "Special Features",
              icon: Icons.stars,
              child: Text(
                "The Glorimumri is one of the smallest tundras in the continent. It is known for an important event that took place in it.\n\nFound in the north of the continent, The Glorimumri is subject to sudden and intense snow squalls, which can reduce visibility to mere meters, and is inconsistently traveled through.",
              ),
            ),
            SizedBox(height: 24),
            ExpandedParagraph(
              title: "Special Features",
              icon: Icons.stars,
              child: Text(
                "The Glorimumri is one of the smallest tundras in the continent. It is known for an important event that took place in it.\n\nFound in the north of the continent, The Glorimumri is subject to sudden and intense snow squalls, which can reduce visibility to mere meters, and is inconsistently traveled through.",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
