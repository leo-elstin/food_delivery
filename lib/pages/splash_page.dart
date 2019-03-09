import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:food_delivery/pages/home_page.dart';

Duration _timerDuration = new Duration(seconds: 5);

class SplashScreen extends StatelessWidget {
// Creating a new timer element.

  @override
  Widget build(BuildContext context) {
    void _startNewPage() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }

    RestartableTimer _timer =
         RestartableTimer(_timerDuration, _startNewPage);

    return Scaffold(
      body: Center(
        child: Image.network(
            'https://pngimage.net/wp-content/uploads/2018/06/home-delivery-logo-png-1.png'),
      ),
    );
  }
}
