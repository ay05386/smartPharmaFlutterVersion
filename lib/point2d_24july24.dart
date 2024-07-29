import 'dart:io';

class Point2D {
  double _x = 0.0;
  double _y = 0.0;

  Point2D([this._x = 0.0, this._y = 0.0]);

  double getX() => _x;
  void setX(double x) => _x = x;

  double getY() => _y;
  void setY(double y) => _y = y;

  List<double> getXY() => [_x, _y];
  void setXY(double x, double y) {
    _x = x;
    _y = y;
  }

  @override
  String toString() => '($_x, $_y)';
}

class Point3D extends Point2D {
  double _z = 0.0;

  Point3D([double x = 0.0, double y = 0.0, this._z = 0.0]) : super(x, y);

  double getZ() => _z;
  void setZ(double z) => _z = z;

  List<double> getXYZ() => [getX(), getY(), _z];
  void setXYZ(double x, double y, double z) {
    setXY(x, y);
    _z = z;
  }

  @override
  String toString() => '(${getX()}, ${getY()}, $_z)';
}

void main() {
  print('Enter x for Point2D:');
  double x2D = double.parse(stdin.readLineSync()!);
  print('Enter y for Point2D:');
  double y2D = double.parse(stdin.readLineSync()!);

  Point2D point2D = Point2D(x2D, y2D);
  print('Point2D: ${point2D.toString()}');

  print('Enter x for Point3D:');
  double x3D = double.parse(stdin.readLineSync()!);
  print('Enter y for Point3D:');
  double y3D = double.parse(stdin.readLineSync()!);
  print('Enter z for Point3D:');
  double z3D = double.parse(stdin.readLineSync()!);

  Point3D point3D = Point3D(x3D, y3D, z3D);
  print('Point3D: ${point3D.toString()}');
}
