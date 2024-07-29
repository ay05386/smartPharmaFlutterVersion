import 'dart:io';

void main() {
  print('Enter the number of elements to put in the map:');
  int size = int.parse(stdin.readLineSync()!);
  Map<String, int> m = {};
  int sum = 0;
  int min = 0;
  int max = 0;
  double avg = 0.0;
  for (int i = 0; i < size; i++) {
    print('Enter key:');
    String key = stdin.readLineSync()!;
    print('Enter value:');
    int value = int.parse(stdin.readLineSync()!);
    m[key] = value;
  }

  print('Map values:');
  for (int value in m.values) {
    print(value);
  }

  if (m.isNotEmpty) {
    min = m.values.first;
    max = m.values.first;
    for (int value in m.values) {
      sum += value;
      if (value < min) {
        min = value;
      }
      if (value > max) {
        max = value;
      }
    }

    avg = sum / m.length;
  }
  print('Size of the map: ${m.length}');
  print('Sum: $sum');
  print('Min: $min');
  print('Max: $max');
  print('Avg: $avg');
}
