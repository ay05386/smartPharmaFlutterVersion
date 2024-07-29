import 'dart:io';

void main() {
  List<String> studentNames = [];
  List<String> studentIds = [];
  List<List<int>> studentGrades = [];

  print('Enter the number of students:');
  int numberOfStudents = int.parse(stdin.readLineSync()!);

  for (int i = 0; i < numberOfStudents; i++) {
    print('Enter name for student ${i + 1}:');
    String name = stdin.readLineSync()!;
    studentNames.add(name);

    print('Enter ID for student ${i + 1}:');
    String id = stdin.readLineSync()!;
    studentIds.add(id);

    print('Enter the number of courses for student ${i + 1}:');
    int numberOfCourses = int.parse(stdin.readLineSync()!);

    List<int> grades = [];
    for (int j = 0; j < numberOfCourses; j++) {
      print('Enter grade for course ${j + 1}:');
      int grade = int.parse(stdin.readLineSync()!);
      grades.add(grade);
    }
    studentGrades.add(grades);
  }

  double calculateAverage(List<int> grades) {
    int total = 0;
    for (int grade in grades) {
      total += grade;
    }
    return total / grades.length;
  }

  String classifyGrade(double average) {
    if (average >= 90) {
      return 'Excellent';
    } else if (average >= 80) {
      return 'Very Good';
    } else if (average >= 70) {
      return 'Good';
    } else {
      return 'Pass';
    }
  }

  int studentWithHighestGradesIndex = 0;
  int studentWithLowestGradesIndex = 0;

  for (int i = 1; i < numberOfStudents; i++) {
    if (calculateAverage(studentGrades[i]) > calculateAverage(studentGrades[studentWithHighestGradesIndex])) {
      studentWithHighestGradesIndex = i;
    }
    if (calculateAverage(studentGrades[i]) < calculateAverage(studentGrades[studentWithLowestGradesIndex])) {
      studentWithLowestGradesIndex = i;
    }
  }

  print('Student with the highest grades: ${studentNames[studentWithHighestGradesIndex]}, Average: ${calculateAverage(studentGrades[studentWithHighestGradesIndex])}');
  print('Student with the lowest grades: ${studentNames[studentWithLowestGradesIndex]}, Average: ${calculateAverage(studentGrades[studentWithLowestGradesIndex])}');

  print('List of students with their grades:');
  for (int i = 0; i < numberOfStudents; i++) {
    double avgGrade = calculateAverage(studentGrades[i]);
    String classification = classifyGrade(avgGrade);
    print('Name: ${studentNames[i]}, ID: ${studentIds[i]}, Average Grade: $avgGrade, Classification: $classification');
  }
}
