import 'package:flutter/material.dart';
import 'package:food_delivery/model/food_model.dart';
import 'package:food_delivery/adapter/food_adapter.dart';
//Firebase Db
import 'package:cloud_firestore/cloud_firestore.dart';

class FoodList extends StatelessWidget {
  final String _id;
  FoodList(this._id);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('hotel_list/$_id/food_list/')
          .where('isVeg',isEqualTo: false)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: RefreshProgressIndicator(),
          );
        final int count = snapshot.data.documents.length;
        return count > 0 ? ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: count,
          itemBuilder: (_, int index) {
            final DocumentSnapshot document = snapshot.data.documents[index];

            var product = Food.fromJson(document.data);
            return FoodAdapter(product);
          },
        ) :Center(child: Text('No items found.'),);
      },
    );
  }
}
