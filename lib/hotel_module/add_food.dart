import 'package:flutter/material.dart';
import 'package:food_delivery/model/hotel_model.dart';
import 'package:food_delivery/model/food_model.dart';

//Firebase
import 'package:cloud_firestore/cloud_firestore.dart';

class AddFoodPage extends StatelessWidget {
  final Hotel hotel;
  AddFoodPage(this.hotel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Food'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            addFood();
          },
        ),
      ),
    );
  }

  void addFood() {
    var doc = Firestore.instance.collection('food_list').document();
    var id = doc.documentID;
    var data = Food(
        id,
        0,
        1,
        hotel.hotel_id,
        "title",
        "description",
        100,
        "http://mehakhotel.com/wp-content/uploads/2017/04/paneer-capsicum-recipe.jpg",
        true);

    Firestore.instance
        .collection('food_list')
        .document(id)
        .setData(data.toJson()).whenComplete(()=>{
          
        });
  }
}
