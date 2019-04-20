import 'package:flutter/material.dart';
import 'package:food_delivery/model/category_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
//Firebase Db
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(top: 32, right: 16, left: 16),
              child: TextField(
                  style: TextStyle(fontSize: 18),
                  decoration: textDecoration('Search'))),
          Container(
            margin: EdgeInsets.only(top: 16, right: 16, left: 16, bottom: 4),
            child: Text(
              'CATEGORIES',
              style: TextStyle(fontSize: 18),
            ),
          ),
          DecoratedBox(
            child: SizedBox(
              width: 75,
              height: 2,
            ),
            decoration: BoxDecoration(color: Colors.black38),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('category_list').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: RefreshProgressIndicator(),
                );
              final int count = snapshot.data.documents.length;
              print(count);
              // return Container();
              return count > 0
                  ? GridView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: count,
                      gridDelegate:
                          new SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: (BuildContext context, int index) {
                        final DocumentSnapshot document =
                            snapshot.data.documents[index];
                        // Map hotelMap = jsonDecode(document.data);
                        var data = Category.fromJson(document.data);
                        return _buildHotelCard(context, hotel: data);
                      },
                    )
                  : Center(
                      child: Text('data'),
                    );
            },
          ),
        ],
      ),
    );
  }

  InputDecoration textDecoration(String label) {
    return InputDecoration(
      prefixIcon: Icon(Icons.search),
      hasFloatingPlaceholder: true,
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      // hintText: 'Enter your product title',
      labelStyle: TextStyle(color: Colors.grey),
      errorStyle: TextStyle(
        color: Colors.black,
      ),
      hintText: 'Search for food or resturants',
      // labelText: label,
    );
  }

  Widget _buildHotelCard(BuildContext context, {hotel: Category}) {
    return Container(
      height: 200,
      width: double.infinity,
      // padding: EdgeInsets.only(left: 8, right: 8),
      child: Card(
        elevation: 1,
        child: InkWell(
          splashColor: Colors.black26,
          onTap: () {
            // Navigator.of(context).push(
            //   // MaterialPageRoute(
            //   //   // builder: (BuildContext context) => FoodListPage(hotel),
            //   // ),
            // );
          },
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 188.2,
            decoration: BoxDecoration(
              image: DecorationImage(
                colorFilter: ColorFilter.mode(Colors.black38, BlendMode.colorBurn),
                image: CachedNetworkImageProvider(hotel.image),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            child: Text(
              hotel.title.toString().toUpperCase(),
              style: TextStyle(color: Colors.white,fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
