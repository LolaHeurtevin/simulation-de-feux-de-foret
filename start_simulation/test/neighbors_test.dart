import 'package:flutter_test/flutter_test.dart';

void main() {
  List<int> getNeighbors(int index, int length) {
    List<int> neighbors = [];
    if (index % 6 != 0) {
      neighbors.add(index - 1); // Left neighbor
    }
    if (index % 6 != 5) {
      neighbors.add(index + 1); // Right neighbor
    }
    if (index >= 6) {
      neighbors.add(index - 6); // Top neighbor
    }
    if (index < length - 6) {
      neighbors.add(index + 6); // Bottom neighbor
    }
    return neighbors;
  }

  test('Get neighbors for a cell in the middle', () {
    int index = 7;
    int length = 24;
    List<int> neighbors = getNeighbors(index, length);
    expect(neighbors, [6, 8, 1, 13]);
  });

  test('Get neighbors for a cell on the left edge', () {
    int index = 6;
    int length = 24;
    List<int> neighbors = getNeighbors(index, length);
    expect(neighbors, [7, 0, 12]);
  });

  test('Get neighbors for a cell on the right edge', () {
    int index = 5;
    int length = 24;
    List<int> neighbors = getNeighbors(index, length);
    expect(neighbors, [4, 11]);
  });

  test('Get neighbors for a cell on the top edge', () {
    int index = 3;
    int length = 24;
    List<int> neighbors = getNeighbors(index, length);
    expect(neighbors, [2, 4, 9]);
  });

  test('Get neighbors for a cell on the bottom edge', () {
    int index = 21;
    int length = 24;
    List<int> neighbors = getNeighbors(index, length);
    expect(neighbors, [20, 22, 15]);
  });

  test('Get neighbors for a cell in the top-left corner', () {
    int index = 0;
    int length = 24;
    List<int> neighbors = getNeighbors(index, length);
    expect(neighbors, [1, 6]);
  });

  test('Get neighbors for a cell in the top-right corner', () {
    int index = 5;
    int length = 24;
    List<int> neighbors = getNeighbors(index, length);
    expect(neighbors, [4, 11]);
  });

  test('Get neighbors for a cell in the bottom-left corner', () {
    int index = 18;
    int length = 24;
    List<int> neighbors = getNeighbors(index, length);
    expect(neighbors, [17, 19, 12]);
  });

  test('Get neighbors for a cell in the bottom-right corner', () {
    int index = 23;
    int length = 24;
    List<int> neighbors = getNeighbors(index, length);
    expect(neighbors, [22, 17]);
  });
}
