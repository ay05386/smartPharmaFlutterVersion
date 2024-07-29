import 'dart:io';

class Car {
  String carCode;
  String color;
  double price;
  String model;

  Car(this.carCode, this.color, this.price, this.model);

  String get getCarCode => carCode;
  set setCarCode(String carCode) => this.carCode = carCode;

  String get getColor => color;
  set setColor(String color) => this.color = color;

  double get getPrice => price;
  set setPrice(double price) => this.price = price;

  String get getModel => model;
  set setModel(String model) => this.model = model;

  void printInfo() {
    print('Car Code: $carCode, Color: $color, Price: \$$price, Model: $model');
  }
}

void main() {
  List<Car> cars = [];

  print('Enter the number of cars:');
  int numberOfCars = int.parse(stdin.readLineSync()!);

  for (int i = 0; i < numberOfCars; i++) {
    print('Enter details for car ${i + 1}:');

    print('Car Code:');
    String carCode = stdin.readLineSync()!;

    print('Color:');
    String color = stdin.readLineSync()!;

    print('Price:');
    double price = double.parse(stdin.readLineSync()!);

    print('Model:');
    String model = stdin.readLineSync()!;

    cars.add(Car(carCode, color, price, model));
  }

  double totalPrice = cars.fold(0, (sum, car) => sum + car.price);
  Car mostExpensiveCar = cars.reduce((curr, next) => curr.price > next.price ? curr : next);
  Car leastExpensiveCar = cars.reduce((curr, next) => curr.price < next.price ? curr : next);

  print('Total price of all cars: \$${totalPrice}');
  print('Most expensive car: ${mostExpensiveCar.carCode}, Price: \$${mostExpensiveCar.price}');
  print('Least expensive car: ${leastExpensiveCar.carCode}, Price: \$${leastExpensiveCar.price}');

  print('All cars information:');
  for (Car car in cars) {
    car.printInfo();
  }
}
