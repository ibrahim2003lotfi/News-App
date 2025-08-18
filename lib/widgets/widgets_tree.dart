import 'package:flutter/material.dart';

import 'package:news_app/pages/home.dart';
import 'package:news_app/valueNotifiers.dart';

class WidgetsTree extends StatefulWidget {
  const WidgetsTree({super.key});

  @override
  State<WidgetsTree> createState() => _WidgetsTreeState();
}

class _WidgetsTreeState extends State<WidgetsTree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'LD',
              style: TextStyle(
                fontFamily: 'Libertinus Serif',
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              ' News',
              style: TextStyle(
                fontFamily: 'Libertinus Serif',
                fontWeight: FontWeight.w900,
                color: Colors.blue,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              isDarkNotifier.value = !isDarkNotifier.value;
            },
            icon: ValueListenableBuilder(
              valueListenable: isDarkNotifier,
              builder: (context, isDarkMode, child) {
                return isDarkMode
                    ? Icon(Icons.light_mode)
                    : Icon(Icons.dark_mode);
              },
            ),
          ),
        ],
      ),
      body: Home(),
    );
  }
}
