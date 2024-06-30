import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MazeApp());
}

class MazeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maze Generator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MazeHomePage(),
    );
  }
}

class MazeHomePage extends StatefulWidget {
  @override
  _MazeHomePageState createState() => _MazeHomePageState();
}

class _MazeHomePageState extends State<MazeHomePage> {
  late List<List<int>> maze;
  final int rows = 11; // Ensure odd number of rows for proper maze structure
  final int cols = 11; // Ensure odd number of columns for proper maze structure

  @override
  void initState() {
    super.initState();
    generateMaze();
  }

  void generateMaze() {
    // Initialize maze with walls
    maze = List.generate(rows, (i) => List.generate(cols, (j) => 1));
    _generateMazeDFS(1, 1);

    setState(() {});
  }

  void _generateMazeDFS(int row, int col) {
    // Directions: (right, down, left, up)
    final directions = [
      [0, 2], // right
      [2, 0], // down
      [0, -2], // left
      [-2, 0], // up
    ];
    final rand = Random();

    // Shuffle directions for random maze
    directions.shuffle(rand);

    for (var direction in directions) {
      final newRow = row + direction[0];
      final newCol = col + direction[1];
      final wallRow = row + direction[0] ~/ 2;
      final wallCol = col + direction[1] ~/ 2;

      if (_isInBounds(newRow, newCol) && maze[newRow][newCol] == 1) {
        maze[row][col] = 0; // Mark cell as path
        maze[wallRow][wallCol] = 0; // Remove wall
        maze[newRow][newCol] = 0; // Mark new cell as path
        _generateMazeDFS(newRow, newCol); // Recur
      }
    }
  }

  bool _isInBounds(int row, int col) {
    return row > 0 && row < rows - 1 && col > 0 && col < cols - 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maze Generator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: maze.isNotEmpty
                  ? CustomPaint(
                size: Size(double.infinity, double.infinity),
                painter: MazePainter(maze),
              )
                  : Container(),
            ),
            ElevatedButton(
              onPressed: generateMaze,
              child: Text('Generate New Maze'),
            ),
          ],
        ),
      ),
    );
  }
}

class MazePainter extends CustomPainter {
  final List<List<int>> maze;
  final double cellSize = 20.0;

  MazePainter(this.maze);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;

    for (int row = 0; row < maze.length; row++) {
      for (int col = 0; col < maze[row].length; col++) {
        if (maze[row][col] == 1) {
          // Draw vertical walls
          if (row > 0 && maze[row - 1][col] == 0) {
            final startX = col * cellSize;
            final startY = row * cellSize;
            final endY = startY + cellSize;
            canvas.drawLine(Offset(startX, startY), Offset(startX, endY), paint);
          }
          // Draw horizontal walls
          if (col > 0 && maze[row][col - 1] == 0) {
            final startX = col * cellSize;
            final startY = row * cellSize;
            final endX = startX + cellSize;
            canvas.drawLine(Offset(startX, startY), Offset(endX, startY), paint);
          }
        }
      }
    }

    // Draw the outer boundary
    for (int row = 0; row < maze.length; row++) {
      for (int col = 0; col < maze[row].length; col++) {
        final left = col * cellSize;
        final top = row * cellSize;
        final right = left + cellSize;
        final bottom = top + cellSize;

        if (row == 0) {
          // Top border
          canvas.drawLine(Offset(left, top), Offset(right, top), paint);
        }
        if (row == maze.length - 1) {
          // Bottom border
          canvas.drawLine(Offset(left, bottom), Offset(right, bottom), paint);
        }
        if (col == 0) {
          // Left border
          canvas.drawLine(Offset(left, top), Offset(left, bottom), paint);
        }
        if (col == maze[row].length - 1) {
          // Right border
          canvas.drawLine(Offset(right, top), Offset(right, bottom), paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
