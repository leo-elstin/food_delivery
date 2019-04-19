import 'package:flutter/material.dart';
import 'package:food_delivery/model/food_model.dart';
import 'package:food_delivery/adapter/food_adapter.dart';
import 'package:food_delivery/model/hotel_model.dart';
//Firebase Db
import 'package:cloud_firestore/cloud_firestore.dart';

class FoodList extends StatelessWidget {
  final int _id;
  final int _catId;
  FoodList(this._id, this._catId);

  @override
  Widget build(BuildContext context) {
    print(_id);
    print(_catId);
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('food_list')
          // .where('tags',arrayContains: 'biriyani')
          .where('hotel_id', isEqualTo: _id)
          .where('category_id', isEqualTo: _catId)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: RefreshProgressIndicator(),
          );
        final int count = snapshot.data.documents.length;
        return count > 0
            ? ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: count,
                itemBuilder: (_, int index) {
                  final DocumentSnapshot document =
                      snapshot.data.documents[index];
                  var product = Food.fromJson(document.data);
                  return FoodAdapter(product);
                },
              )
            : Text('No items found');
      },
    );
  }
}
