import 'package:flutter/material.dart';

/// This class handles the painting of the maze and the solution path.
class MazePainter extends CustomPainter {
  final List<List<int>> maze;
  final List<List<int>>? solutionPath;
  final double cellSize;

  MazePainter(this.maze, this.cellSize, {this.solutionPath});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0;

    for (int y = 0; y < maze.length; y++) {
      for (int x = 0; x < maze[y].length; x++) {
        if (maze[y][x] == 1) {
          // Draw top line
          if (y == 0 || maze[y - 1][x] == 0) {
            canvas.drawLine(
              Offset(x * cellSize, y * cellSize),
              Offset((x + 1) * cellSize, y * cellSize),
              paint,
            );
          }
          // Draw left line
          if (x == 0 || maze[y][x - 1] == 0) {
            canvas.drawLine(
              Offset(x * cellSize, y * cellSize),
              Offset(x * cellSize, (y + 1) * cellSize),
              paint,
            );
          }
          // Draw bottom line
          if (y == maze.length - 1 || maze[y + 1][x] == 0) {
            canvas.drawLine(
              Offset(x * cellSize, (y + 1) * cellSize),
              Offset((x + 1) * cellSize, (y + 1) * cellSize),
              paint,
            );
          }
          // Draw right line
          if (x == maze[y].length - 1 || maze[y][x + 1] == 0) {
            canvas.drawLine(
              Offset((x + 1) * cellSize, y * cellSize),
              Offset((x + 1) * cellSize, (y + 1) * cellSize),
              paint,
            );
          }
        }
      }
    }

    // Draw solution path
    if (solutionPath != null) {
      final solutionPaint = Paint()
        ..color = Colors.red
        ..strokeWidth = 2.0;

      for (int i = 0; i < solutionPath!.length - 1; i++) {
        final p1 = solutionPath![i];
        final p2 = solutionPath![i + 1];
        canvas.drawLine(
          Offset(p1[0] * cellSize + cellSize / 2, p1[1] * cellSize + cellSize / 2),
          Offset(p2[0] * cellSize + cellSize / 2, p2[1] * cellSize + cellSize / 2),
          solutionPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
