import 'package:flutter/material.dart';
import 'package:food_delivery/model/hotel_model.dart';

class FoodListPage extends StatelessWidget {
  final Hotel hotel;
  FoodListPage(this.hotel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title: Text(
          hotel.name,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: <Widget>[
          _buildHeaderLayout(
            context,
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderLayout(context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        // alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Text(
                    'Rating',
                    style: TextStyle(color: Colors.brown),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${hotel.rating} (${hotel.ratingCount}+)',
                    style: TextStyle(),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Expanded(
                child: Column(
              children: <Widget>[
                Text(
                  'Delivered In',
                  style: TextStyle(color: Colors.brown),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '${hotel.waitingTime} Mins',
                  style: TextStyle(
                    color: hotel.waitingTime > 25 ? Colors.red : Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            )),
            Expanded(
              child: Column(
                children: <Widget>[
                  Text(
                    'Delivery Charge',
                    style: TextStyle(color: Colors.brown),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '30 Rs',
                    style: TextStyle(),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
