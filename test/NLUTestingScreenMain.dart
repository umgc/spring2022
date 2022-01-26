import 'package:flutter/material.dart';
import 'NLUTestingScreen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyNLUTestingApp());
}

class MyNLUTestingApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NLU Testing tool',
      theme: ThemeData(
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme,
        ),
        primarySwatch: Colors.orange,
      ),
      home: MyNLUTestHomePage(title: 'NLU Testing tool'),
    );
  }
}


class MyNLUTestHomePage extends StatefulWidget {
  MyNLUTestHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyNLUTestPageState createState() => _MyNLUTestPageState();

}

class _MyNLUTestPageState extends State<MyNLUTestHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: NLUTestingScreen(),
    );
  }
}
