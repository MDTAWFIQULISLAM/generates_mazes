import 'package:flutter/material.dart';
import '../models/maze_generator.dart';
import '../widgets/maze_painter.dart';

class MazePage extends StatefulWidget {
  @override
  _MazePageState createState() => _MazePageState();
}

class _MazePageState extends State<MazePage> {
  late MazeGenerator _mazeGenerator;
  final int _rows = 15;
  final int _cols = 15;
  bool _showSolution = false;

  @override
  void initState() {
    super.initState();
    _generateMaze();
  }

  // Generates a new maze
  void _generateMaze() {
    _mazeGenerator = MazeGenerator(_rows, _cols);
    _showSolution = false;
    setState(() {});
  }

  // Toggles the display of the solution
  void _toggleSolution() {
    setState(() {
      _showSolution = !_showSolution;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<List<int>> maze = _mazeGenerator.getMaze();
    List<List<int>>? solutionPath = _showSolution ? _mazeGenerator.getSolutionPath() : null;
    double cellSize = (MediaQuery.of(context).size.width - 64) / _cols; // Adjusted size with more padding

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
                  child: CustomPaint(
                    size: Size(cellSize * _cols, cellSize * _rows),
                    painter: MazePainter(maze, cellSize, solutionPath: solutionPath),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0), // Ensure padding around buttons
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _generateMaze,
                  icon: Icon(Icons.refresh),
                  label: Text('Generate Maze'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  ),
                ),
                SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: _toggleSolution,
                  icon: Icon(Icons.check),
                  label: Text(_showSolution ? 'Hide Solution' : 'Show Solution'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
