import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String display = '0';

  double firstNumber = 0;
  String operation = '';
  bool shouldResetDisplay = false;




  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        display = '0';
        firstNumber = 0;
        operation = '';
        shouldResetDisplay = false;
      } else if (buttonText == '+' || buttonText == '-' || buttonText == '*' || buttonText == '/') {
        firstNumber = double.parse(display);
        operation = buttonText;
        shouldResetDisplay = true;
      } else if (buttonText == '=') {
        double secondNumber = double.parse(display);
        double result = 0;
        if (operation == '+') {
          result = firstNumber + secondNumber;
        } else if (operation == '-') {
          result = firstNumber - secondNumber;
        } else if (operation == '*') {
          result = firstNumber * secondNumber;
        } else if (operation == '/') {
          result = firstNumber / secondNumber;
        }
        display = result.toString();
        operation = '';
        shouldResetDisplay = true;
      } else {
        if (display == '0' || shouldResetDisplay) {
          display = buttonText;
          shouldResetDisplay = false;

        } else {
          display += buttonText;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        children: [

          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.bottomRight,

              child: Text(
                display,
                style: TextStyle(fontSize: 48),
              ),
            ),
          ),
          Column(
            children: [
              buildButtonRow(['1', '2', '3']),
              buildButtonRow(['4', '5', '6']),
              buildButtonRow(['7', '8', '9']),
              buildButtonRow(['+', '-', '0']),
              buildButtonRow(['*', '/', 'C', '=']),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildButtonRow(List<String> buttons) {
    return Row(

      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons.map((button) =>
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(4),
              child: AspectRatio(
                aspectRatio: 1.5,
                child: ElevatedButton(
                  onPressed: () => buttonPressed(button),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(15),
                  ),
                  child: Text(button, style: TextStyle(fontSize: 24)),
                ),
              ),
            ),
          ),
      ).toList(),
    );
  }
}
