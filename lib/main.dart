import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:realm_roller/pages/general/generators.dart';
import 'package:realm_roller/pages/general/main_page/main_page.dart';
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
      home: const MainPage(),
    );
  }
}
