import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'counterLogic.dart';
import 'counterState.dart';

abstract class CounterState {}

class Init extends CounterState {}

class Pls extends CounterState {}

class Muns extends CounterState {}

class Reset extends CounterState {}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CounterApp(),
    );
  }
}

class CounterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterLogic(),
      child: BlocConsumer<CounterLogic, CounterState>(
        listener: (context, state) {},
        builder: (context, state) {
          CounterLogic obj = BlocProvider.of(context);
          return Scaffold(
            appBar: AppBar(),
            body: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('${obj.num}'),
                  ElevatedButton(
                    onPressed: () {
                      obj.pls();
                    },
                    child: Text('+'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      obj.muns();
                    },
                    child: Text('-'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      obj.reset();
                    },
                    child: Text('R'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
