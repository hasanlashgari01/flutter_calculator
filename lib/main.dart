import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:calculator/constants/constants.dart';

void main() {
  runApp(CalculatorApplication());
}

class CalculatorApplication extends StatefulWidget {
  const CalculatorApplication({super.key});

  @override
  State<CalculatorApplication> createState() => _CalculatorApplicationState();
}

class _CalculatorApplicationState extends State<CalculatorApplication> {
  var inputUser = '';
  var result = '';
  void buttonPressed(String text) {
    setState(() {
      inputUser = inputUser + text;
    });
  }

  Widget getRow(String text1, String text2, String text3, String text4) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(width: 0, color: Colors.transparent),
            ),
            backgroundColor: getBackgroundColor(text1),
          ),
          onPressed: () {
            if (text1 == 'AC') {
              setState(() {
                inputUser = '';
                result = '';
              });
            } else {
              buttonPressed(text1);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              text1,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 26, color: getTextColor(text1)),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(width: 0, color: Colors.transparent),
            ),
            backgroundColor: getBackgroundColor(text2),
          ),
          onPressed: () {
            if (text2 == 'C') {
              if (inputUser.length > 0) {
                setState(() {
                  inputUser = inputUser.substring(0, inputUser.length - 1);
                });
              }
            } else {
              buttonPressed(text2);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              text2,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 26, color: getTextColor(text2)),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(width: 0, color: Colors.transparent),
            ),
            backgroundColor: getBackgroundColor(text3),
          ),
          onPressed: () {
            buttonPressed(text3);
          },
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              text3,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 26, color: getTextColor(text3)),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(width: 0, color: Colors.transparent),
            ),
            backgroundColor: getBackgroundColor(text4),
          ),
          onPressed: () {
            if (text4 == '=') {
              setState(() {
                Parser parser = Parser();
                Expression expression = parser.parse(inputUser);
                ContextModel contextModel = ContextModel();
                double eval = expression.evaluate(
                  EvaluationType.REAL,
                  contextModel,
                );

                setState(() {
                  result = eval.floor().toString();
                });
              });
            } else {
              buttonPressed(text4);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              text4,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 26, color: getTextColor(text4)),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: backgroundGreyDark,
        ),
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                height: 100,
                color: backgroundGreyDark,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        inputUser,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: textGreen,
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        result,
                        style: TextStyle(
                          color: textGrey,
                          fontSize: 62,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                height: 100,
                color: backgroundGrey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    getRow('AC', 'C', '%', '/'),
                    getRow('7', '8', '9', '*'),
                    getRow('4', '5', '6', '-'),
                    getRow('1', '2', '3', '+'),
                    getRow('00', '0', '.', '='),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool isOperator(String text) {
    var list = ['AC', 'C', '%', '/', '*', '-', '+', '='];

    for (var item in list) {
      if (text == item) {
        return true;
      }
    }

    return false;
  }

  Color getBackgroundColor(String text) {
    if (isOperator(text)) {
      return backgroundGreyDark;
    } else {
      return backgroundGrey;
    }
  }

  Color getTextColor(String text) {
    if (isOperator(text)) {
      return textGreen;
    } else {
      return textGrey;
    }
  }
}
