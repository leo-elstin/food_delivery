import 'package:flutter/material.dart';
import 'package:food_delivery/sub_pages/hotel_list.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(55, 0, 179, 1,),
        title: Text('Home'),
        actions: <Widget>[
          _buildCartWidget(context),
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child: Text(
              'Nearby Hotels',
              style: TextStyle(fontSize: 18),
            ),
          ),
          HotelList()
        ],
      ),
    );
  }

  Widget _buildCartWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      child: Stack(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigator.pushNamed(context, '/cart');
            },
          ),
          Container(
            height: 35,
            width: 60,
            padding: EdgeInsets.only(right: 10),
            alignment: Alignment.topRight,
            child: Container(
              width: 20,
              height: 20,
              alignment: Alignment.center,
              padding: EdgeInsets.all(2),
              child: Text('5'),
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
          )
        ],
      ),
    );
  }
}
