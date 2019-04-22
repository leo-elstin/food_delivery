import 'package:flutter/material.dart';
import 'package:food_delivery/sub_pages/hotel_list.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:food_delivery/scoped_model/card_scoped_model.dart';
import 'cart_page.dart';
import 'search_page.dart';
import 'my_account.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  int _currentINdex = 0;
  final List _children = [
    ListView(
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
    SearchPage(),
    CartPage(),
    MyAccountPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: _buildCartWidget(context),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentINdex,
        onTap: (value) {
          setState(() {
            _currentINdex = value;
          });
          print(value);
        },
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.home,
              color: Colors.blue,
            ),
            title: Text(
              'Home',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: Colors.blue,
            ),
            title: Text(
              'Search',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_basket,
              color: Colors.blue,
            ),
            title: Text(
              'Cart',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              color: Colors.blue,
            ),
            title: Text(
              'Account',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      body: _children[_currentINdex],
      // body:
    );
  }

  Widget _buildCartWidget(BuildContext context) {
    return ScopedModelDescendant<CartScopedModel>(
        builder: (context, widget, model) {
     
      return model.cartItems.length > 0 && _currentINdex == 0
          ? FloatingActionButton.extended(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            ),
              label: Text(model.getCartDetails()),
              icon: Icon(Icons.shopping_basket),
              onPressed: () {
                setState(() {
                  _currentINdex = 2;
                });
              },
            )
          : Container();
    });
  }
}
