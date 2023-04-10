import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Shapes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NumberShapesPage(title: 'Number Shapes'),
    );
  }
}

class NumberShapesPage extends StatefulWidget {
  const NumberShapesPage({super.key, required this.title});

  final String title;

  @override
  State<NumberShapesPage> createState() => _NumberShapesPageState();
}

class _NumberShapesPageState extends State<NumberShapesPage> {
  final TextEditingController inputNumber = TextEditingController();
  static String outputMessage = '';
  static String outputTitle = '';

  void _outputResult() {
    setState(() {
      final int number = int.parse(inputNumber.text);
      if (checkSquareRoot(number) && checkCubeRoot(number)) {
        outputMessage = 'Number $number is both\nTRIANGULAR and SQUARE.';
      } else if (checkCubeRoot(number)) {
        outputMessage = 'Number $number is TRIANGULAR.';
      } else if (checkSquareRoot(number)) {
        outputMessage = 'Number $number is SQUARE.';
      } else {
        outputMessage = 'Number $number is neither\nTRIANGULAR or SQUARE.';
      }
      outputTitle = '$number';
      Navigator.of(context).push(DismissibleDialog<String>());
    });
  }

  bool checkSquareRoot(int number) {
    for (int i = 1; i * i <= number; i++) {
      if (i * i == number) {
        return true;
      }
    }
    return false;
  }

  bool checkCubeRoot(int number) {
    (number < 0) ? number = -number : number;
    for (int i = 1; i * i * i <= number; i++) {
      if (i * i * i == number) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const Text(
              'Please input a number to see if it is square or cube perfect root.',
              style: TextStyle(fontSize: 25),
              textAlign: TextAlign.center,
            ),
            Container(height: 30),
            Container(
              padding: const EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 10.0),
              child: TextField(
                controller: inputNumber,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _outputResult,
        child: const Icon(Icons.school_rounded),
      ),
    );
  }
}

class DismissibleDialog<T> extends PopupRoute<T> {
  String dialogTextTitle = _NumberShapesPageState.outputTitle;
  String dialogTextOutput = _NumberShapesPageState.outputMessage;

  @override
  Color? get barrierColor => Colors.black.withAlpha(0x50);

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => _NumberShapesPageState.outputTitle;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return Center(
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.bodyMedium!,
        child: UnconstrainedBox(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Column(
              children: <Widget>[
                Text(dialogTextTitle, style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 25),
                Text(dialogTextOutput, style: const TextStyle(fontSize: 20)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
