import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: NumberGrid(),
      ),
    );
  }
}

class NumberGrid extends StatefulWidget {
  @override
  _NumberGridState createState() => _NumberGridState();
}

class _NumberGridState extends State<NumberGrid> {
  List<int> numbers = generateRandomNumbers();

  void updateData() {
    setState(() {
      numbers = generateRandomNumbers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height - 100,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: (numbers.length / 4).ceil(),
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: numbers
                      .sublist(index * 4, min(index * 4 + 4, numbers.length))
                      .map((number) => NumberCell(number: number))
                      .toList(),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: updateData,
            child: Text('Обновить данные'),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class NumberCell extends StatelessWidget {
  final int number;

  const NumberCell({required this.number});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = generateRandomColor();

    return GestureDetector(
      onTap: () {
        showMessage(context, number);
      },
      child: Container(
        margin: EdgeInsets.all(8),
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor,
        ),
        child: Center(
          child: Text(
            number.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 40,
            ),
          ),
        ),
      ),
    );
  }
}

void showMessage(BuildContext context, int number) {
  final snackBar = SnackBar(
    content: Text('Clicked on number $number'),
    duration: const Duration(seconds: 1),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

List<int> generateRandomNumbers() {
  return List<int>.generate(32, (index) => Random().nextInt(100));
}

Color generateRandomColor() {
  return Color.fromRGBO(
    Random().nextInt(256),
    Random().nextInt(256),
    Random().nextInt(256),
    1,
  );
}
