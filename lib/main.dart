import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:realm_roller/custom_widgets/cards/entity_card.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                EntityCard(
                  size: 120,
                  title: "Ishle Bolanore",
                  subtitle: "World",
                  imagePath: "assets/worlds/world.webp",
                ),
                SizedBox(
                  width: 20,
                ),
                EntityCard(
                  size: 120,
                  title: "Arathorn Ocean",
                  subtitle: "Ocean",
                  imagePath: "assets/landscapes/ocean.webp",
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                EntityCard(
                  size: 120,
                  title: "Nightriver",
                  subtitle: "Elven village",
                  imagePath: "assets/settlements/village.webp",
                ),
                SizedBox(
                  width: 20,
                ),
                EntityCard(
                  size: 120,
                  title: "Kalcyra Reshoon",
                  subtitle: "Female tiefling priestess",
                  imagePath: "assets/races/tiefling.webp",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
