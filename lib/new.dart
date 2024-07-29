import 'dart:io';

void main() {
  Map<String, int> m = {
    'a': 1,
    'b': 2,
    'c': 3,
    'd': 4,
  };

  print('Enter a value to search for the key:');
  String? input = stdin.readLineSync();
  int searchedValue = int.parse(input!);

  String? result;
  for (int i = 0; i < m.length; i++) {
    if (m.values.elementAt(i) == searchedValue) {
      result = m.keys.elementAt(i);
      break;
    }
  }

  print('Key for value $searchedValue is $result');
}
