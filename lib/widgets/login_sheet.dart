import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:food_delivery/scoped_model/card_scoped_model.dart';
import 'package:food_delivery/pages/auth_page.dart';

void openLoginSheet(BuildContext context) {
  final TextEditingController _phoneNumberController = TextEditingController();
  showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        int _phoneNumber = 0;
        void openAuthPage(int phoneNumber, {CartScopedModel model}) {
          model.setLogin(enable: false);
          // Navigator.pop(context);
          print(_phoneNumberController.text);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => AuthPage(
                    int.parse(_phoneNumberController.text),
                  ),
            ),
          );
        }

        return ScopedModelDescendant<CartScopedModel>(
          builder: (context, widget, model) {
            return ListView(
              // mainAxisAlignment: MainAxisAlignment.start,
              // mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 16, bottom: 8),
                  child: Text(
                    'LOGIN',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 16, bottom: 16, top: 8),
                  child: Text(
                    'Enter your 10 digit Phone number.',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 32, bottom: 32, right: 32),
                    child: TextField(
                      controller: _phoneNumberController,
                      onChanged: (value) {
                        _phoneNumber = int.parse(value);

                        // print(_phoneNumber);

                        if (value.length == 10) {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          model.setLogin(enable: true);
                        } else
                          model.setLogin(enable: false);
                      },
                      maxLength: 10,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      cursorWidth: 1,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        // labelText: 'Phone Number',
                        prefix: Container(
                          margin: EdgeInsets.only(right: 8),
                          child: Text(
                            '+91',
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),
                        prefixIcon: Icon(Icons.phone),
                        // hintText: '10 digit number',
                      ),
                    ),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(right: 32, left: 32, bottom: 64, top: 8),
                  width: double.infinity,
                  child: RaisedButton(
                    onPressed: model.loginEnabled
                        ? () {
                            openAuthPage(_phoneNumber, model: model);
                          }
                        : null,
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      });
}
