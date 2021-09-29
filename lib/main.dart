import 'package:bytebank_final/database/app_database.dart';
import 'package:bytebank_final/screens/dashboard.dart';
import 'package:flutter/material.dart';

import 'models/contact.dart';

void main() {
  runApp(const BytebankApp());
  save(Contact(0, 'joao', 10101));
}

class BytebankApp extends StatelessWidget {
  const BytebankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
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
