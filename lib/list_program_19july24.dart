import 'dart:io';

void main() {
  List<int> myList = [];
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
      print('Enter the value to add:');
      int value = int.parse(stdin.readLineSync()!);
      myList.add(value);
    } else if (choice == 2) {
      print('Remove by (1) Index or (2) Value?');
      int removeChoice = int.parse(stdin.readLineSync()!);
      if (removeChoice == 1) {
        print('Enter the index to remove:');
        int index = int.parse(stdin.readLineSync()!);
        if (index >= 0 && index < myList.length) {
          myList.removeAt(index);
        } else {
          print('Invalid index');
        }
      } else if (removeChoice == 2) {
        print('Enter the value to remove:');
        int value = int.parse(stdin.readLineSync()!);
        myList.remove(value);
      }
    } else if (choice == 3) {
      print('Enter the old value to update:');
      int oldValue = int.parse(stdin.readLineSync()!);
      if (myList.contains(oldValue)) {
        print('Enter the new value:');
        int newValue = int.parse(stdin.readLineSync()!);
        myList[myList.indexOf(oldValue)] = newValue;
      } else {
        print('Value not found');
      }
    } else if (choice == 4) {
      print('List values:');
      for (int i = 0; i < myList.length; i++) {
        print(myList[i]);
      }
    } else if (choice == 5) {
      print('Search by (1) if the value exists or (2) Index?');
      int searchChoice = int.parse(stdin.readLineSync()!);
      print('Enter the value to search:');
      int value = int.parse(stdin.readLineSync()!);
      if (searchChoice == 1) {
        if (myList.contains(value)) {
          print('Value exists in the list');
        } else {
          print('Value not found');
        }
      } else if (searchChoice == 2) {
        int index = myList.indexOf(value);
        if (index != -1) {
          print('Value found at index $index');
        } else {
          print('Value not found');
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
