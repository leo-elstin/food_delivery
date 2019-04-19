import 'package:flutter/material.dart';
import 'package:food_delivery/sub_pages/hotel_list.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:food_delivery/scoped_model/card_scoped_model.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              _scaffoldKey.currentState
                  .showBottomSheet<Null>((BuildContext context) {
                return Container(
                    child:  Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                     Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Persistent header for bottom bar!',
                          textAlign: TextAlign.left,
                        )),
                    Text(
                      'Then here there will likely be some other content '
                          'which will be displayed within the bottom bar',
                      textAlign: TextAlign.left,
                    ),
                  ],
                ));
              });
            },
          ),
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
    return ScopedModelDescendant<CartScopedModel>(
        builder: (context, widget, model) {
      return Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.pushNamed(context, '/cart');
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
                child: Text('${model.cartItems.length}'),
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            )
          ],
        ),
      );
    });
  }
}
