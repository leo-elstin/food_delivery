import 'package:flutter/material.dart';
import 'dart:io';
import 'package:scoped_model/scoped_model.dart';
import 'package:food_delivery/scoped_model/card_scoped_model.dart';
import 'package:food_delivery/widgets/login_sheet.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext buildcontext) {
    return ScopedModelDescendant<CartScopedModel>(
        builder: (context, child, model) => Scaffold(
            resizeToAvoidBottomPadding: true,
            appBar: AppBar(
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.lock_open),
                  onPressed: () => FirebaseAuth.instance.signOut(),
                )
              ],
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
                  child: Container(
                    // decoration: BoxDecoration(),
                    height: 120,
                    width: double.infinity,
                    color: Colors.white,
                    child: Card(
                      elevation: 8,
                      margin: EdgeInsets.only(bottom :32, left: 32, right: 32, ),
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              margin: EdgeInsets.only(right: 14, bottom :8),
                               child :  FlatButton(
                                 color: Colors.green,
                              onPressed: () async {
                                FirebaseUser user = await _auth.currentUser();
                                if (user == null)
                                  openLoginSheet(buildcontext);
                                else {
                                  print('logged in');
                                }
                              },
                              child: Text('Checkout', style: TextStyle(color: Colors.white),),
                            ),),
                          ),
                        ],
                      ),
                    ),
                  ),
                  alignment: Alignment.bottomCenter,
                )
              ],
            )));
  }
}
