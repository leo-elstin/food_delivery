import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/cart_page.dart';
import 'pages/auth_page.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:food_delivery/scoped_model/card_scoped_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(MyApp());
final FirebaseAuth _auth = FirebaseAuth.instance;
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: CartScopedModel(),
      child: MaterialApp(
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
          '/cart': (BuildContext context) => CartPage(),
        },
      ),
    );
  }
}
