import 'package:calculator/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userInput = '';
  var userAnswer = '';

  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '.',
    '+/-',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      userInput,
                      style: TextStyle(fontSize: 25, color: Colors.white),
                      
                    ),
                  ),
                  Divider(thickness: 2,color: Colors.white),
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userAnswer,
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  reverse: true,
                  itemCount: buttons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return MyButton(
                        buttonTap: () {
                          setState(() {
                            userInput = '';
                            userAnswer = '';
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.redAccent,
                        textColor: Colors.white,
                      );
                    } else if (index == 1) {
                      return MyButton(
                        buttonTap: () {
                          setState(() {
                            if (userInput.length > 0) {
                              userInput =
                                  userInput.substring(0, userInput.length - 1);
                            }
                          });

                          setState(() {
                            output();
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.grey,
                        textColor: Colors.white,
                      );
                    } else if (index == 18) {
                      return MyButton(
                        buttonTap: () {
                          setState(() {
                            double result = double.parse(userAnswer);
                            if (result < 0) {
                              result = result.abs();
                              userAnswer = result.toString();
                            } else {
                              result = result * -1;
                              userAnswer = result.toString();
                            }
                            clear();
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.grey,
                        textColor: Colors.white,
                      );
                    } else if (index == 19) {
                      return MyButton(
                        buttonTap: () {
                          setState(() {
                            clear();
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.green,
                        textColor: Colors.white,
                      );
                    } else {
                      return MyButton(
                        buttonTap: () {
                          setState(() {
                            if (userInput.length < 20) {
                              userInput += buttons[index];
                            }
                          });

                          setState(() {
                            output();
                          });
                        },
                        buttonText: buttons[index],
                        color: isOperator(buttons[index])
                            ? Colors.grey
                            : Colors.white,
                        textColor: isOperator(buttons[index])
                            ? Colors.white
                            : Colors.black,
                      );
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String input) {
    if (input == '%' ||
        input == '/' ||
        input == 'x' ||
        input == '-' ||
        input == '+' ||
        input == '=') {
      return true;
    }
    return false;
  }

  void output() {
    userInput = userInput.replaceAll('x', '*'); //math expressions
    Parser par = Parser();
    Expression exp = par.parse(userInput);
    ContextModel cm = ContextModel();
    double evaluate = exp.evaluate(EvaluationType.REAL, cm);
    userAnswer = evaluate.toString();
  }

  void clear() {
    if (userAnswer != '') {
      userInput = userAnswer;
      userAnswer = '';
    }
  }
}
