import 'package:flutter/material.dart';

/// Widget for displaying the game controls.
class MazeGameControls extends StatelessWidget {
  final VoidCallback onGenerateMaze;
  final VoidCallback onToggleSolution;
  final bool showSolution;
  final Function(int, int) onMovePlayer;

  MazeGameControls({
    required this.onGenerateMaze,
    required this.onToggleSolution,
    required this.showSolution,
    required this.onMovePlayer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: onGenerateMaze,
                icon: Icon(Icons.refresh),
                label: Text('Generate Maze'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                ),
              ),
              SizedBox(width: 16),
              ElevatedButton.icon(
                onPressed: onToggleSolution,
                icon: Icon(Icons.check),
                label: Text(showSolution ? 'Hide Solution' : 'Show Solution'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => onMovePlayer(0, -1),
                child: Text('Up'),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: () => onMovePlayer(-1, 0),
                child: Text('Left'),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: () => onMovePlayer(1, 0),
                child: Text('Right'),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: () => onMovePlayer(0, 1),
                child: Text('Down'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
