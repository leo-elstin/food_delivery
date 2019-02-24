import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
          body1: TextStyle(
            // fontFamily: 'Lato',
          ),
        ),
        primaryColor: Colors.blue,
      ),
      routes: {
        '/': (BuildContext context) => HomePage(),
      },
    );
  }
}
