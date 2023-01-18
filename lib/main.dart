import 'package:flutter/material.dart';
import 'package:stock_market_test/app.dart';
import 'package:stock_market_test/core/injections/injections.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const App(),
    );
  }
}
