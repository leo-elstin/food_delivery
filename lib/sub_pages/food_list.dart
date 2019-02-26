import 'package:flutter/material.dart';
import 'package:food_delivery/model/food_model.dart';
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
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: RefreshProgressIndicator(),
          );
        final int messageCount = snapshot.data.documents.length;
        return ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: messageCount,
          itemBuilder: (_, int index) {
            final DocumentSnapshot document = snapshot.data.documents[index];

            var data = Food.fromJson(document.data);
            print(data..title);
            return (Text('data'));
          },
        );
      },
    );
  }
}
