import 'package:flutter/material.dart';
import 'package:food_delivery/model/hotel_model.dart';

class FoodListPage extends StatelessWidget {
  final Hotel hotel;
  FoodListPage(this.hotel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            AppBar(
              elevation: 0,
              backgroundColor: Colors.black12,
              title: Text(hotel.name),
            )
          ],
        ),
      ),
    );
  }
}
