import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController _controllerFullResult = TextEditingController();
  TextEditingController _controllerOutput = TextEditingController(text: "0.0");
  String operation = "";
  double num1 = 0.0;
  double num2 = 0.0;


  Widget buildButton(String buttonText, {Color buttonColor = Colors.blue, String type = "default"}){
    return ElevatedButton(
      onPressed: (){
        switch (type){
          case "dot":
            if(!_controllerOutput.text.contains("."))
              _controllerOutput.text += ".";
            break;
          case "operation":
            return onOperation(buttonText);
          case "calculate":
            return onCalculate();
          default:
            return onDefaultPress(buttonText);
        }
      },
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
            CircleBorder()),
        fixedSize: MaterialStateProperty.all(const Size(65, 65)),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (states){
              if(states.contains(MaterialState.pressed)){
                return Colors.green;
              }
              return buttonColor;
            },
        ),
      ),
      child: Text(
        buttonText,
        style: TextStyle(fontSize: 24),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Калькулятор"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 3.0
                  ),
                  borderRadius: const BorderRadius.all(
                      Radius.circular(30.0)
                  ),
                ),
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _controllerFullResult,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      readOnly: true,
                      style: const TextStyle(
                        fontSize: 20.0,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    TextField(
                      controller: _controllerOutput,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      readOnly: true,
                      style: const TextStyle(
                        fontSize: 45.0,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 3.0
                  ),
                  borderRadius: const BorderRadius.all(
                      Radius.circular(30.0) //                 <--- border radius here
                  ),
                ),
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                          onPressed: () {
                            _controllerOutput.text = "0.0";
                            _controllerFullResult.text = "";
                            operation = "";
                          },
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18.0),
                                        side: BorderSide(color: Colors.red)
                                    )
                                ),
                                fixedSize: MaterialStateProperty.all(const Size(147, 65)),
                              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                    (states){
                                  if(states.contains(MaterialState.pressed)){
                                    return Colors.green;
                                  }
                                  return Colors.blue;
                                },
                              ),
                            ),
                            child: Text(
                              "C",
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                          buildButton("^", buttonColor: Colors.orange, type: "operation"),
                          buildButton("/", buttonColor: Colors.orange, type: "operation"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          buildButton("7"),
                          buildButton("8"),
                          buildButton("9"),
                          buildButton("*", buttonColor: Colors.orange, type: "operation"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          buildButton("4"),
                          buildButton("5"),
                          buildButton("6"),
                          buildButton("-", buttonColor: Colors.orange, type: "operation"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          buildButton("1"),
                          buildButton("2"),
                          buildButton("3"),
                          buildButton("+", buttonColor: Colors.orange, type: "operation"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () => onDefaultPress("0"),
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18.0),
                                        side: BorderSide(color: Colors.red)
                                    )
                                ),
                                fixedSize: MaterialStateProperty.all(const Size(147, 65)),
                              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                    (states){
                                  if(states.contains(MaterialState.pressed)){
                                    return Colors.green;
                                  }
                                  return Colors.blue;
                                },
                              ),
                            ),
                            child: Text(
                              "0",
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                          buildButton(".", type: "dot"),
                          buildButton("=", buttonColor: Colors.orange, type: "calculate"),
                        ],
                      ),
                    ),
                  ],
                )
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void onDefaultPress(String value){

    if(value == "0"){
      _controllerOutput.text += "0";
      return;
    }

    if(_controllerOutput.text == "0.0"){
      _controllerOutput.text = value;
    }
    else{
      _controllerOutput.text += value;
    }
  }

  void onOperation(String type){
    if(operation.isEmpty && _controllerOutput.text != "0.0"){
      operation = type;
      num1 = double.parse(_controllerOutput.text);
      _controllerOutput.text = "0.0";
    }
  }

  void onCalculate(){
    if(operation.isNotEmpty){
      num2 = double.parse(_controllerOutput.text);
      String result = num1.toString() + operation + num2.toString() + "=";

      switch (operation){
        case "^":
          _controllerFullResult.text =  result + pow(num1, num2).toString();
          break;
        case "+":
          _controllerFullResult.text =  result + (num1 + num2).toString();
          break;
        case "-":
          _controllerFullResult.text =  result + (num1 - num2).toString();
          break;
        case "*":
          _controllerFullResult.text =  result + (num1 * num2).toString();
          break;
        case "/":
          _controllerFullResult.text =  result + (num1 / num2).toString();
          break;
      }
      _controllerOutput.text = "0.0";
      operation = "";
      num1 = 0.0;
      num2 = 0.0;
    }
  }
}
