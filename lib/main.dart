import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:realm_roller/custom_widgets/entity_pages/entity_page.dart';
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
    return Material(
      child: SafeArea(
        child: EntityPage(
          title: "Names",
          subtitle: "Mixed dwarfs",
          imagePath: "assets/races/dwarf.webp",
          children: List.generate(
            30,
            (index) => Column(
              children: const [
                SizedBox(
                  height: 10,
                ),
                Text("test"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
