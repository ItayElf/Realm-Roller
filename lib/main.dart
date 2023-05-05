import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:realm_roller/theme/theme_data.dart';

import 'custom_widgets/tiles/tile.dart';

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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

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
            Tile(
              title: "The Fuzzy Crab",
              subtitle: "Tavern",
              imagePath: "assets/locations/tavern.webp",
              onClick: () => print("test"),
            ),
            const SizedBox(
              height: 20,
            ),
            const Tile(
              title: "Thungroick's General Shop",
              subtitle: "General Shop",
              imagePath: "assets/locations/general_shop.webp",
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
