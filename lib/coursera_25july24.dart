import 'dart:io';

class Course {
  String name;
  String description;
  List<Lecture> lectures = [];
  List<Sheet> sheets = [];

  Course(this.name, this.description);

  void addLecture(Lecture lecture) {
    lectures.add(lecture);
  }

  void deleteLecture(String lectureName) {
    lectures.removeWhere((lecture) => lecture.name == lectureName);
  }

  void addSheet(Sheet sheet) {
    sheets.add(sheet);
  }

  void deleteSheet(String sheetName) {
    sheets.removeWhere((sheet) => sheet.name == sheetName);
  }
}

class Lecture {
  String name;
  String description;
  String filename;

  Lecture(this.name, this.description, this.filename);
}

class Sheet {
  String name;
  int number;
  String description;
  String filename;

  Sheet(this.name, this.number, this.description, this.filename);
}

class Teacher {
  String name;
  String email;
  String password;
  List<Course> courses = [];

  Teacher(this.name, this.email, this.password);

  void addCourse(Course course) {
    courses.add(course);
  }

  void deleteCourse(String courseName) {
    courses.removeWhere((course) => course.name == courseName);
  }
}

class ClassJump {
  List<Teacher> teachers = [];
  Teacher? currentTeacher;

  void registerTeacher(String name, String email, String password) {
    teachers.add(Teacher(name, email, password));
  }

  bool loginTeacher(String name, String password) {
    for (var teacher in teachers) {
      if (teacher.name == name && teacher.password == password) {
        currentTeacher = teacher;
        return true;
      }
    }
    return false;
  }
}

void main() {
  var classJump = ClassJump();
  var continueOperation = true;

  while (continueOperation) {
    print('\nChoose an operation:');
    print('1. Register teacher');
    print('2. Login teacher');
    print('3. Add new course');
    print('4. Delete course');
    print('5. Add new lecture');
    print('6. Delete lecture');
    print('7. Add new sheet');
    print('8. Delete sheet');
    print('9. Show all teachers');
    print('10. Show all courses');
    print('11. Show all sheets');
    print('12. Exit');

    var choice = int.parse(stdin.readLineSync()!);

    switch (choice) {
      case 1:
        print('Enter teacher name, email, and password:');
        var name = stdin.readLineSync()!;
        var email = stdin.readLineSync()!;
        var password = stdin.readLineSync()!;
        classJump.registerTeacher(name, email, password);
        break;
      case 2:
        print('Enter teacher name and password:');
        var name = stdin.readLineSync()!;
        var password = stdin.readLineSync()!;
        if (classJump.loginTeacher(name, password)) {
          print('Login successful');
        } else {
          print('Login failed');
        }
        break;
      case 3:
        if (classJump.currentTeacher != null) {
          print('Enter course name and description:');
          var name = stdin.readLineSync()!;
          var description = stdin.readLineSync()!;
          classJump.currentTeacher!.addCourse(Course(name, description));
        } else {
          print('Please login first');
        }
        break;
      case 4:
        if (classJump.currentTeacher != null) {
          print('Enter course name to delete:');
          var name = stdin.readLineSync()!;
          classJump.currentTeacher!.deleteCourse(name);
        } else {
          print('Please login first');
        }
        break;
      case 5:
        if (classJump.currentTeacher != null) {
          print('Enter course name, lecture name, description, and filename:');
          var courseName = stdin.readLineSync()!;
          var lectureName = stdin.readLineSync()!;
          var description = stdin.readLineSync()!;
          var filename = stdin.readLineSync()!;
          var course = classJump.currentTeacher!.courses.firstWhere((c) => c.name == courseName);
          course.addLecture(Lecture(lectureName, description, filename));
        } else {
          print('Please login first');
        }
        break;
      case 6:
        if (classJump.currentTeacher != null) {
          print('Enter course name and lecture name to delete:');
          var courseName = stdin.readLineSync()!;
          var lectureName = stdin.readLineSync()!;
          var course = classJump.currentTeacher!.courses.firstWhere((c) => c.name == courseName);
          course.deleteLecture(lectureName);
        } else {
          print('Please login first');
        }
        break;
      case 7:
        if (classJump.currentTeacher != null) {
          print('Enter course name, sheet name, number, description, and filename:');
          var courseName = stdin.readLineSync()!;
          var sheetName = stdin.readLineSync()!;
          var number = int.parse(stdin.readLineSync()!);
          var description = stdin.readLineSync()!;
          var filename = stdin.readLineSync()!;
          var course = classJump.currentTeacher!.courses.firstWhere((c) => c.name == courseName);
          course.addSheet(Sheet(sheetName, number, description, filename));
        } else {
          print('Please login first');
        }
        break;
      case 8:
        if (classJump.currentTeacher != null) {
          print('Enter course name and sheet name to delete:');
          var courseName = stdin.readLineSync()!;
          var sheetName = stdin.readLineSync()!;
          var course = classJump.currentTeacher!.courses.firstWhere((c) => c.name == courseName);
          course.deleteSheet(sheetName);
        } else {
          print('Please login first');
        }
        break;
      case 9:
        for (var teacher in classJump.teachers) {
          print('${teacher.name} (${teacher.email})');
        }
        break;
      case 10:
        if (classJump.currentTeacher != null) {
          for (var course in classJump.currentTeacher!.courses) {
            print('${course.name}: ${course.description}');
          }
        } else {
          print('Please login first');
        }
        break;
      case 11:
        if (classJump.currentTeacher != null) {
          for (var course in classJump.currentTeacher!.courses) {
            for (var sheet in course.sheets) {
              print('${sheet.name} (${sheet.number}): ${sheet.description}');
            }
          }
        } else {
          print('Please login first');
        }
        break;
      case 12:
        continueOperation = false;
        break;
      default:
        print('Invalid choice');
    }

    if (continueOperation) {
      print('Do you want to continue? (y/n)');
      var answer = stdin.readLineSync()!.toLowerCase();
      continueOperation = answer == 'y';
    }
  }
}