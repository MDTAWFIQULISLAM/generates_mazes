import 'dart:math';

/// This class handles the generation of the maze and the solution path.
class MazeGenerator {
  final int rows;
  final int cols;
  late List<List<int>> maze;
  late List<List<bool>> visited;
  late List<List<int>> solutionPath;

  MazeGenerator(this.rows, this.cols) {
    maze = List.generate(rows, (_) => List.filled(cols, 1));
    visited = List.generate(rows, (_) => List.filled(cols, false));
    solutionPath = [];
    _createPath(0, 0);
  }

  /// Generates a maze using Depth-First Search (DFS) algorithm.
  void _createPath(int x, int y) {
    List<int> directions = [0, 1, 2, 3];
    directions.shuffle(Random());

    for (int direction in directions) {
      int nx = x;
      int ny = y;

      switch (direction) {
        case 0: // Up
          ny -= 2;
          break;
        case 1: // Right
          nx += 2;
          break;
        case 2: // Down
          ny += 2;
          break;
        case 3: // Left
          nx -= 2;
          break;
      }

      if (nx >= 0 && ny >= 0 && nx < cols && ny < rows && maze[ny][nx] == 1) {
        maze[ny][nx] = 0;
        maze[y + (ny - y) ~/ 2][x + (nx - x) ~/ 2] = 0;
        _createPath(nx, ny);
      }
    }
  }

  /// Finds the solution path from start to end.
  bool _findPath(int x, int y) {
    if (x == cols - 1 && y == rows - 1) {
      solutionPath.add([x, y]);
      return true;
    }
    if (x < 0 || y < 0 || x >= cols || y >= rows || maze[y][x] == 1 || visited[y][x]) {
      return false;
    }

    visited[y][x] = true;

    if (_findPath(x + 1, y) || _findPath(x - 1, y) || _findPath(x, y + 1) || _findPath(x, y - 1)) {
      solutionPath.add([x, y]);
      return true;
    }

    return false;
  }

  /// Returns the solution path for the maze.
  List<List<int>> getSolutionPath() {
    visited = List.generate(rows, (_) => List.filled(cols, false));
    solutionPath = [];
    _findPath(0, 0);
    return solutionPath.reversed.toList();
  }

  /// Returns the generated maze.
  List<List<int>> getMaze() {
    return maze;
  }
}
