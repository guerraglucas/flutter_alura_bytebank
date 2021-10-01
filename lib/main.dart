import 'package:bytebank_final/screens/dashboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BytebankApp());
}

class BytebankApp extends StatelessWidget {
  const BytebankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.green[800])),
        ),
        colorScheme: ColorScheme.light(
          primary: Colors.amber[700]!,
          secondary: Colors.amber[500]!,
        ),
      ),
      title: 'Bytebank',
      home: Dashboard(),
    );
  }
}
