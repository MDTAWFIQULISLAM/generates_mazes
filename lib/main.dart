import 'package:flutter/material.dart';
import 'pages/start_page.dart';

void main() => runApp(MazeApp());

/// The root of the Maze application.
class MazeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maze Generator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StartPage(),
    );
  }
}
