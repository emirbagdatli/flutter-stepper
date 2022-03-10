// ignore_for_file: prefer_const_constructors, avoid_types_as_parameter_names, non_constant_identifier_names, prefer_const_literals_to_create_immutables, unnecessary_new, sized_box_for_whitespace, prefer_const_constructors_in_immutables, deprecated_member_use

import 'package:flutter/material.dart';

class StepperExample extends StatefulWidget {
  StepperExample({Key? key}) : super(key: key);

  @override
  State<StepperExample> createState() => _StepperExampleState();
}

class _StepperExampleState extends State<StepperExample> {
  int activeStep = 0;
  late String name, mail, passw;
  late List<Step> allSteps;
  bool error = false;
  var key0 = GlobalKey<FormFieldState>();
  var key1 = GlobalKey<FormFieldState>();
  var key2 = GlobalKey<FormFieldState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    allSteps = _allSteps();
    return Scaffold(
      appBar: AppBar(
        title: Text('Stepper'),
      ),
      body: SingleChildScrollView(
        child: Stepper(
          type: StepperType.vertical,
          steps: allSteps,
          currentStep: activeStep,
          /*onStepTapped: (clickedStep) {
            setState(() {
              activeStep = clickedStep;
            });
          },*/
          onStepContinue: () {
            setState(() {
              _continueControl();
            });
          },
          onStepCancel: () {
            setState(() {
              if (activeStep > 0) {
                activeStep--;
              } else {
                activeStep = 0;
              }
            });
          },
        ),
      ),
    );
  }

  _allSteps() {
    List<Step> steps = [
      Step(
        title: Text('Username'),
        subtitle: Text('Username Subtitle'),
        state: _stateManager(0),
        isActive: true,
        content: TextFormField(
          key: key0,
          decoration: InputDecoration(
              //    labelText: 'Username Label',
              hintText: 'Username Hint',
              border: OutlineInputBorder()),
          validator: (data) {
            if (data!.length < 4) {
              return 'You must enter at least 4 characters ';
            }
          },
          onSaved: (data) {
            name = data!;
          },
        ),
      ),
      Step(
        title: Text('Email'),
        subtitle: Text('Email Subtitle'),
        state: _stateManager(1),
        isActive: true,
        content: TextFormField(
          key: key1,
          decoration: InputDecoration(
              //        labelText: 'Email Label',
              hintText: 'Email Hint',
              border: OutlineInputBorder()),
          validator: (data) {
            if (data!.length < 6 || !data.contains('@')) {
              return 'Invalid email address';
            }
          },
          onSaved: (data) {
            mail = data!;
          },
        ),
      ),
      Step(
        title: Text('Password'),
        subtitle: Text('Password Subtitle'),
        state: _stateManager(2),
        isActive: true,
        content: TextFormField(
          obscureText: true,
          key: key2,
          decoration: InputDecoration(
              //      labelText: 'Password Label',
              hintText: 'Password Hint',
              border: OutlineInputBorder()),
          validator: (data) {
            if (data!.length < 6) {
              return 'You must enter at least 6 characters ';
            }
          },
          onSaved: (data) {
            passw = data!;
          },
        ),
      ),
    ];
    return steps;
  }

  _stateManager(int activatedStep) {
    if (activeStep == activatedStep) {
      if (error) {
        return StepState.error;
      } else {
        return StepState.editing;
      }
    } else {
      return StepState.complete;
    }
  }

  void _continueControl() {
    switch (activeStep) {
      case 0:
        if (key0.currentState!.validate()) {
          key0.currentState!.save();
          error = false;
          activeStep = 1;
        } else {
          error = true;
        }
        break;

      case 1:
        if (key1.currentState!.validate()) {
          key1.currentState!.save();
          error = false;
          activeStep = 2;
        } else {
          error = true;
        }
        break;

      case 2:
        if (key2.currentState!.validate()) {
          key2.currentState!.save();
          error = false;
          activeStep = 2;
          formCompleted();
        } else {
          error = true;
        }
        break;
    }
  }

  void formCompleted() {
    debugPrint(
        'User Information :\nUsername: $name \nE-mail: $mail \nPassword: $passw');
  }
}
