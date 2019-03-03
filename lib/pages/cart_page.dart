import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:food_delivery/scoped_model/card_scoped_model.dart';
import 'package:food_delivery/widgets/login_sheet.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext buildcontext) {
    return ScopedModelDescendant<CartScopedModel>(
        builder: (context, child, model) => Scaffold(
          resizeToAvoidBottomPadding :true,
            appBar: AppBar(
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black),
              brightness: Brightness.light,
              backgroundColor: Colors.white,
              title: Text(
                'My Foods',
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: Stack(
              children: <Widget>[
                ListView.builder(
                  itemBuilder: (buildcontext, i) {
                    return Text('${model.cartItems[i].count}');
                  },
                  itemCount: model.cartItems.length,
                ),
                Align(
                  child: RaisedButton(
                    onPressed: () {
                      openLoginSheet(buildcontext);
                    },
                    child: Text('Checkout'),
                  ),
                  alignment: Alignment.bottomCenter,
                )
              ],
            )));
  }
}
