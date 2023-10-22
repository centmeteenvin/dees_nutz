import 'package:diw/firebase_options.dart';
import 'package:diw/pages/home/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';


final logger = Logger(level: Level.info);

void main(List<String> args) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: DIWApplication()));
}

class DIWApplication extends StatelessWidget {
  const DIWApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "DIW",
      home: const HomePage(),
      theme: theme,
      debugShowCheckedModeBanner: false,
    );
  }
}

final ThemeData theme = ThemeData(
  useMaterial3: true,
  colorSchemeSeed: Colors.red,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(iconSize: 40)
);