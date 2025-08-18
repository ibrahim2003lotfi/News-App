import 'package:flutter/material.dart';
import 'package:news_app/pages/landing.dart';
import 'package:news_app/valueNotifiers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isDarkNotifier,
      builder: (context, isDarkMode, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white,
            brightness: isDarkMode ? Brightness.dark : Brightness.light),
          ),
          home: Landing(),
        );
      }
    );
  }
}


  