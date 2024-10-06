import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CalculatorHome(),
    );
  }
}

class CalculatorHome extends StatefulWidget {
  @override
  _CalculatorHomeState createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {
  String displayText = '0';
  String operand = '';
  double num1 = 0;
  double num2 = 0;

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _resetCalculator();
      } else if (["+", "-", "*", "/"].contains(buttonText)) {
        _handleOperator(buttonText);
      } else if (buttonText == "=") {
        _calculateResult();
      } else {
        _handleNumberInput(buttonText);
      }
    });
  }

  void _resetCalculator() {
    displayText = '0';
    num1 = 0;
    num2 = 0;
    operand = '';
  }

  void _handleOperator(String op) {
    num1 = double.parse(displayText);
    operand = op;
    displayText = '0';
  }

  void _handleNumberInput(String number) {
    if (displayText == '0') {
      displayText = number;
    } else {
      displayText += number;
    }
  }

  void _calculateResult() {
    num2 = double.parse(displayText);
    switch (operand) {
      case "+":
        displayText = (num1 + num2).toString();
        break;
      case "-":
        displayText = (num1 - num2).toString();
        break;
      case "*":
        displayText = (num1 * num2).toString();
        break;
      case "/":
        displayText = num2 == 0 ? "Error" : (num1 / num2).toString();
        break;
    }
    num1 = 0;
    num2 = 0;
    operand = '';
  }

  Widget buildButton(String text) {
    return Expanded(
      child: InkWell(
        onTap: () => buttonPressed(text),
        child: Container(
          padding: EdgeInsets.all(20.0),
          margin: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: Colors.red[300],
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Aaron's Calculator")),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
              child: Text(
                displayText,
                style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Column(
            children: [
              Row(children: [
                buildButton("7"),
                buildButton("8"),
                buildButton("9"),
                buildButton("/")
              ]),
              Row(children: [
                buildButton("4"),
                buildButton("5"),
                buildButton("6"),
                buildButton("*")
              ]),
              Row(children: [
                buildButton("1"),
                buildButton("2"),
                buildButton("3"),
                buildButton("-")
              ]),
              Row(children: [
                buildButton("0"),
                buildButton("."),
                buildButton("="),
                buildButton("+")
              ]),
              Row(children: [buildButton("C")]),
            ],
          ),
        ],
      ),
    );
  }
}
