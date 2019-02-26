import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        buttonColor: Colors.green,
        textTheme: TextTheme(
          body1: TextStyle(
            fontFamily: 'Lato',
          ),
        ),
        primaryColor: Colors.deepPurple,
      ),
      routes: {
        '/': (BuildContext context) => HomePage(),
      },
    );
  }
}
