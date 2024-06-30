import 'package:flutter/material.dart';
import 'maze_page.dart';

/// The initial page of the application that allows the user to start the maze game.
class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maze Generator'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MazePage()),
            );
          },
          child: Text('Start Game'),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            textStyle: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
