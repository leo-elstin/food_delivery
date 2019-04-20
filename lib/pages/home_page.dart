import 'package:flutter/material.dart';
import 'package:food_delivery/sub_pages/hotel_list.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:food_delivery/scoped_model/card_scoped_model.dart';
import 'cart_page.dart';
import 'search_page.dart';

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
    Text('Account')
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.search),
      //   onPressed: () {},
      // ),
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
