import 'package:flutter/material.dart';
import 'package:food_delivery/model/hotel_model.dart';
import 'package:food_delivery/model/food_model.dart';

//Firebase
import 'package:cloud_firestore/cloud_firestore.dart';

class AddFoodPage extends StatefulWidget {
  final Hotel hotel;
  AddFoodPage(this.hotel);
  @override
  State<StatefulWidget> createState() {
    return _AddFoodState(hotel);
  }
}

class _AddFoodState extends State<AddFoodPage> {
  final Hotel hotel;
  _AddFoodState(this.hotel);
  Food food = Food();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Food'),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(16),
              child: TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(hintText: 'Food Name'),
                onChanged: (value) => {food.title = value},
              ),
            ),
            Container(
              margin: EdgeInsets.all(16),
              child: TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(hintText: 'Description'),
                onChanged: (value) => {food.description = value},
              ),
            ),
            Container(
              margin: EdgeInsets.all(16),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: 'Price'),
                onChanged: (value) => {food.price = value},
              ),
            ),
            Center(
              child: RaisedButton(
                child: Text('Add Food',
                    style: TextStyle(
                      color: Colors.white,
                    )),
                onPressed: () {
                  addFood();
                },
              ),
            ),
          ],
        ));
  }

  void addFood() {
    var doc = Firestore.instance.collection('food_list').document();
    var id = doc.documentID;

    food.id = id;
    food.hotelId = hotel.hotel_id;
    food.categoryId = 2;
    // food.description = "";
    // food.price = 100;
    food.image =
        "http://mehakhotel.com/wp-content/uploads/2017/04/paneer-capsicum-recipe.jpg";
    food.isVeg = true;

    Firestore.instance
        .collection('food_list')
        .document(id)
        .setData(food.toJson())
        .whenComplete(() => {});
  }
}
