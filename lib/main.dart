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
    '+/-',
    '.',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
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
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userAnswer,
                      style: TextStyle(fontSize: 50),
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
                        color: Colors.green,
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
                        color: Colors.redAccent,
                        textColor: Colors.white,
                      );
                    } else if (index == 17) {
                      return MyButton(
                        buttonTap: () {
                          setState(() {});
                        },
                        buttonText: buttons[index],
                        color: Colors.redAccent,
                        textColor: Colors.white,
                      );
                    } else if (index == 19) {
                      return MyButton(
                        buttonTap: () {
                          setState(() {
                            userInput = userAnswer;
                            userAnswer = '';
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.redAccent,
                        textColor: Colors.white,
                      );
                    } else {
                      return MyButton(
                        buttonTap: () {
                          setState(() {
                            userInput += buttons[index];
                          });

                          setState(() {
                            output();
                          });
                        },
                        buttonText: buttons[index],
                        color: isOperator(buttons[index])
                            ? Colors.grey
                            : Colors.deepPurple[50],
                        textColor: isOperator(buttons[index])
                            ? Colors.black
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

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void output() {
    String finalQuestion = userInput;
    finalQuestion = finalQuestion.replaceAll('x', '*'); //math expressions
    Parser par = Parser();
    Expression exp = par.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double evaluate = exp.evaluate(EvaluationType.REAL, cm);
    userAnswer = evaluate.toString();
  }
}
