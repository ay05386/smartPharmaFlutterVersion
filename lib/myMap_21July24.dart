import 'dart:io';

void main() {
  Map<int, int> myMap = {};
  bool continueProgram = true;

  while (continueProgram) {
    print('Menu:');
    print('1 - Add value');
    print('2 - Remove value');
    print('3 - Update value');
    print('4 - Show values');
    print('5 - Search value');
    print('Enter your choice:');
    int choice = int.parse(stdin.readLineSync()!);

    if (choice == 1) {
      print('Enter the key to add:');
      int key = int.parse(stdin.readLineSync()!);
      print('Enter the value to add:');
      int value = int.parse(stdin.readLineSync()!);
      myMap[key] = value;
    } else if (choice == 2) {
      print('Remove by (1) Key or (2) Value?');
      int removeChoice = int.parse(stdin.readLineSync()!);
      if (removeChoice == 1) {
        print('Enter the key to remove:');
        int key = int.parse(stdin.readLineSync()!);
        myMap.remove(key);
      } else if (removeChoice == 2) {
        print('Enter the value to remove:');
        int value = int.parse(stdin.readLineSync()!);
        myMap.removeWhere((k, v) => v == value);
      }
    } else if (choice == 3) {
      print('Enter the key of the value to update:');
      int key = int.parse(stdin.readLineSync()!);
      if (myMap.containsKey(key)) {
        print('Enter the new value:');
        int newValue = int.parse(stdin.readLineSync()!);
        myMap[key] = newValue;
      } else {
        print('Key not found');
      }
    } else if (choice == 4) {
      print('Map values:');
      myMap.forEach((key, value) {
        print('Key: $key, Value: $value');
      });
    } else if (choice == 5) {
      print('Search by (1) if the value exists or (2) Key?');
      int searchChoice = int.parse(stdin.readLineSync()!);
      if (searchChoice == 1) {
        print('Enter the value to search:');
        int value = int.parse(stdin.readLineSync()!);
        if (myMap.containsValue(value)) {
          print('Value exists in the map');
        } else {
          print('Value not found');
        }
      } else if (searchChoice == 2) {
        print('Enter the key to search:');
        int key = int.parse(stdin.readLineSync()!);
        if (myMap.containsKey(key)) {
          print('Key found with value: ${myMap[key]}');
        } else {
          print('Key not found');
        }
      }
    }

    print('Do you want to continue? (yes/no)');
    String? answer = stdin.readLineSync();
    if (answer?.toLowerCase() != 'yes') {
      continueProgram = false;
    }
  }
}
