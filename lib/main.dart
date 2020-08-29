import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(calculator());
}

Color mainColor = const Color.fromRGBO(56, 56, 56, 0.0);
Color wtColor = Colors.white;

class calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Calculator',
      theme: new ThemeData(scaffoldBackgroundColor: mainColor),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = "0";
  String result = "0";
  String expression = " ";
  double equationFontSize = 38.0;
  double resutlFontSize = 48.0;

  buttonPressed(String btnText) {
    setState(() {
      if(btnText == "C") {
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resutlFontSize = 48.0;
      }else if(btnText == "⌫"){
        equation = equation.substring(0, equation.length-1);
        if(equation == "0") {
          equation = "0";
        }
      } else if (btnText == "=") {
        equationFontSize = 38.0;
        resutlFontSize = 48.0;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try{
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';

        } catch(e){
          result = "Error";
        }

      } else {
        equationFontSize = 48.0;
        resutlFontSize = 38.0;
        if(equation == "0") {
          equation = btnText;
        } else {
          equation = equation + btnText;
        }
      }
    }
      );
  }

  Widget buildButton(String btnText, Color btntextColor, double btnHeight, Color btnColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * btnHeight,
      color: btnColor,
      child: FlatButton(
          shape:RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
//            side: BorderSide(color: Colors.white, width: 1, style: BorderStyle.solid),
          ),
          padding: EdgeInsets.all(16.0),
          onPressed: () => buttonPressed(btnText), child: Text(btnText, style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.normal, color:btntextColor),)),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:_getCumstomAppBar(),
      body:
      Column(

      children: <Widget>[
        Container(

          alignment:Alignment.centerRight,
          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: Text(equation, style: TextStyle(fontSize: equationFontSize, color: Colors.white),),
        ),
        Container(
          alignment:Alignment.centerRight,
          padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
          child: Text(result, style: TextStyle(fontSize: resutlFontSize, color: Colors.white),),
        ),

        Expanded(
          child: Divider(color: Colors.white70),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * .75,
              child: Table(
                children: [
                  TableRow(
                    children: [
                      buildButton("C" , Colors.pinkAccent, 1 , mainColor),
                      buildButton("⌫", wtColor, 1 , mainColor),
                      buildButton("÷", wtColor, 1 , mainColor)
                    ],
                  ),

                  TableRow(
                    children: [
                      buildButton("7", wtColor, 1 , mainColor),
                      buildButton("8", wtColor, 1 , mainColor),
                      buildButton("9", wtColor, 1 , mainColor)
                    ],
                  ),

                  TableRow(
                    children: [
                      buildButton("4", wtColor, 1 , mainColor),
                      buildButton("5", wtColor, 1 , mainColor),
                      buildButton("6", wtColor, 1 , mainColor)
                    ],
                  ),

                  TableRow(
                    children: [
                      buildButton("1", wtColor, 1 , mainColor),
                      buildButton("2", wtColor, 1 , mainColor),
                      buildButton("3", wtColor, 1 , mainColor)
                    ],
                  ),

                  TableRow(
                    children: [
                      buildButton(".", wtColor, 1 , mainColor),
                      buildButton("0", wtColor, 1 , mainColor),
                      buildButton("00", wtColor, 1 , mainColor)
                    ],
                  ),

                ],
              ),
            ),

            Container(
              width: MediaQuery.of(context). size. width * 0.25,
              child: Table(
                children: [
                  TableRow(
                    children: [
                      buildButton("×", wtColor, 1, mainColor)
                    ],
                  ),

                  TableRow(
                    children: [
                      buildButton("+", wtColor, 1, mainColor)
                    ],
                  ),

                  TableRow(
                    children: [
                      buildButton("-", wtColor, 1, mainColor)
                    ],
                  ),

                  TableRow(
                    children: [
                      buildButton("=", wtColor, 2, Colors.pinkAccent)
                    ],
                  )



                ],
              ),
            ),
          ],
        ),
      ],
      ),
    );

  }

  _getCumstomAppBar() {
      return PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.pinkAccent,
                Colors.orangeAccent,
              ]
            )
          )
        ),
      );
  }
}
