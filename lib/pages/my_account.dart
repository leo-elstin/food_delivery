import 'package:flutter/material.dart';
import 'package:food_delivery/pages/order_tracking_page.dart';

class MyAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => OrderTrackingPage()));
          },
          child: Text('Open Mao'),
        ),
      ),
    );
  }
}
