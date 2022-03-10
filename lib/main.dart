import 'package:flutter/material.dart';
import 'package:flutter_stepper/stepper_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Stepper',
      theme: ThemeData(primarySwatch: Colors.green),
      home: StepperExample(),
    );
  }
}
