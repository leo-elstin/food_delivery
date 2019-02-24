import 'package:flutter/material.dart';
import 'package:food_delivery/model/hotel_model.dart';

class FoodListPage extends StatelessWidget {
  final Hotel hotel;
  FoodListPage(this.hotel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hotel.name),
        centerTitle: true,
      ),
      body: Center(),
    );
  }
}
