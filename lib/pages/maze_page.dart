import 'dart:async';
import 'package:flutter/material.dart';
import '../models/maze_generator.dart';
import '../widgets/maze_painter.dart';
import '../widgets/maze_game_controls.dart';
import 'winner_page.dart';

/// The main page that displays the maze and game controls.
class MazePage extends StatefulWidget {
  @override
  _MazePageState createState() => _MazePageState();
}

class _MazePageState extends State<MazePage> {
  late MazeGenerator _mazeGenerator;
  final int _rows = 15;
  final int _cols = 15;
  bool _showSolution = false;
  List<int> _playerPosition = [0, 0]; // Player starting position
  Timer? _timer;
  int _seconds = 0;

  @override
  void initState() {
    super.initState();
    _generateMaze();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  /// Generates a new maze and resets the player position and timer.
  void _generateMaze() {
    _mazeGenerator = MazeGenerator(_rows, _cols);
    _showSolution = false;
    _playerPosition = [0, 0];
    _seconds = 0;
    setState(() {});
  }

  /// Toggles the display of the maze solution.
  void _toggleSolution() {
    setState(() {
      _showSolution = !_showSolution;
    });
  }

  /// Starts the game timer.
  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  /// Moves the player within the maze.
  /// [dx] and [dy] are the directions of movement.
  void _movePlayer(int dx, int dy) {
    int newX = _playerPosition[0] + dx;
    int newY = _playerPosition[1] + dy;

    if (newX >= 0 && newY >= 0 && newX < _cols && newY < _rows && _mazeGenerator.maze[newY][newX] == 0) {
      setState(() {
        _playerPosition = [newX, newY];
      });

      if (newX == _cols - 1 && newY == _rows - 1) {
        _timer?.cancel();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WinnerPage(time: _seconds)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<List<int>> maze = _mazeGenerator.getMaze();
    List<List<int>>? solutionPath = _showSolution ? _mazeGenerator.getSolutionPath() : null;
    double cellSize = (MediaQuery.of(context).size.width - 64) / (_cols * 1.5); // Smaller display

    return Scaffold(
      appBar: AppBar(
        title: Text('Maze Generator'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10.0,
                        offset: Offset(0, 5),
                      ),
                    ],
                    border: Border.all(color: Colors.black12),
                  ),
                  child: Stack(
                    children: [
                      CustomPaint(
                        size: Size(cellSize * _cols, cellSize * _rows),
                        painter: MazePainter(maze, cellSize, solutionPath: solutionPath),
                      ),
                      Positioned(
                        left: _playerPosition[0] * cellSize,
                        top: _playerPosition[1] * cellSize,
                        child: Container(
                          width: cellSize,
                          height: cellSize,
                          color: Colors.blue,
                        ),
                      ),
                      // Draw start point
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: cellSize,
                          height: cellSize,
                          color: Colors.green,
                        ),
                      ),
                      // Draw end point
                      Positioned(
                        left: (_cols - 1) * cellSize,
                        top: (_rows - 1) * cellSize,
                        child: Container(
                          width: cellSize,
                          height: cellSize,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Text('Time: $_seconds s', style: TextStyle(fontSize: 24)),
          MazeGameControls(
            onGenerateMaze: _generateMaze,
            onToggleSolution: _toggleSolution,
            showSolution: _showSolution,
            onMovePlayer: _movePlayer,
          ),
        ],
      ),
    );
  }
}
