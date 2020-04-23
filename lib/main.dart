import 'package:flutter/material.dart';
import 'package:solid_test/my_colors.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Solid Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Solid Test'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 1;
  int _lastIndex = 1;
  String _text = 'Hey there';
  Random _random = Random();

  bool isTextLabel = true;

  Map colors = {
    1: MyColors(
      background: Colors.blue,
      title: Colors.black,
    ),
    2: MyColors(
      background: Colors.red,
      title: Colors.white,
    ),
    3: MyColors(
      background: Colors.yellow,
      title: Colors.black,
    ),
    4: MyColors(
      background: Colors.black,
      title: Colors.white,
    ),
    5: MyColors(
      background: Colors.white,
      title: Colors.black,
    ),
    6: MyColors(
      background: Colors.green,
      title: Colors.white,
    ),
    7: MyColors(
      background: Colors.brown,
      title: Colors.white,
    ),
    8: MyColors(
      background: Colors.grey,
      title: Colors.black,
    ),
  };

  void _incrementCounter() {
    final min = 1;
    _currentIndex = min + _random.nextInt(6);
    _notRepeateTwoTimesInRow();

    setState(() => _currentIndex);

    _lastIndex = _currentIndex;
  }

  void _notRepeateTwoTimesInRow() {
    if (_currentIndex == _lastIndex && _currentIndex != 6) {
      _currentIndex++;
    } else if (_currentIndex == _lastIndex && _currentIndex == 6)
      _currentIndex--;
  }

  void _showTextLabel() {
    setState(() => isTextLabel = false);
  }

  void _showInputText(String val) {
    setState(() {
      isTextLabel = true;
      _text = val.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    final textLabel = GestureDetector(
      onTap: _showTextLabel,
      child: Text(
        _text,
        style: TextStyle(
          fontSize: 30,
          color: colors[_currentIndex].title,
        ),
      ),
    );

    final editText = Container(
      padding: EdgeInsets.all(60),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Input new text",
        ),
        style: TextStyle(
          color: colors[_currentIndex].title,
        ),
        onSubmitted: (val) => _showInputText(val),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: _incrementCounter,
          child: Container(
            width: screenWidth,
            height: screenHeight,
            color: colors[_currentIndex].background,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  isTextLabel ? textLabel : editText,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
