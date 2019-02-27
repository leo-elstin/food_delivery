import 'package:flutter/material.dart';
import 'package:food_delivery/model/food_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:food_delivery/pages/cart_page.dart';
import 'package:food_delivery/scoped_model/card_scoped_model.dart';

class FoodAdapter extends StatelessWidget {
  final Food product;
  FoodAdapter(this.product);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showBottomSheet(context, food: product),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(product.image),
                    ),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                margin: EdgeInsets.only(left: 16, top: 5, right: 5, bottom: 5),
                height: 100,
                width: 100,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                        product.title,
                        style: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'Lato',
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        product.description,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13.0,
                          fontFamily: 'Roboto',
                          color: Color(0xFF212121),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              shape: BoxShape.rectangle,
                              color: product.isVeg ? Colors.green : Colors.red,
                            ),
                            margin: EdgeInsets.all(10),
                          ),
                        ),
                        Text(
                          'Rs. ${product.price}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'Lato',
                            color: Colors.brown,
                            fontWeight: FontWeight.normal,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider()
        ],
      ),
    );
  }

  void _showBottomSheet(context, {Food food}) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return ScopedModelDescendant<CartScopedModel>(
              builder: (context, child, model) {
            var isAdded = true;
            model.cartItems.forEach((f) {
              if (f.id == food.id) {
                isAdded = false;
              }
            });
            return Container(
              margin: EdgeInsets.all(10),
              child: new Wrap(
                children: <Widget>[
                  _buildCardForSheet(food),
                  Container(
                    margin: EdgeInsets.only(left: 25, top: 10),
                    child: Text('Quantity'),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(left: 25, top: 5, right: 25),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 25),
                          child: IconButton(
                            icon: Icon(
                              Icons.remove_circle,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              model.decrement();
                            },
                          ),
                        ),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.blueGrey,
                              width: 1,
                            ),
                          ),
                          child: Container(
                            width: 35,
                            height: 35,
                            padding: EdgeInsets.all(8),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                '${model.counter}',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 25),
                          child: IconButton(
                            icon: Icon(
                              Icons.add_box,
                              color: Colors.green,
                            ),
                            onPressed: () {
                              model.increment();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    child: Container(
                      margin: EdgeInsets.only(right: 16, bottom: 32),
                      child: isAdded
                          ? RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              )),
                              color: Theme.of(context).buttonColor,
                              onPressed: () {
                                Navigator.pop(context);
                                food.count = model.counter;
                                model.addToCart(food);
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (BuildContext context) =>
                                //           CartPage(),
                                //     ));
                              },
                              child: Text(
                                "Add to Cart",
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          : Container(
                              margin: EdgeInsets.all(24),
                              child: OutlineButton(
                                onPressed: (){},
                                child: Text('Added'),
                              ),
                            ),
                    ),
                    alignment: Alignment.centerRight,
                  )
                ],
              ),
            );
          });
        });
  }

  Widget _buildCardForSheet(Food product) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(product.image),
                  ),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              margin: EdgeInsets.only(left: 16, top: 5, right: 5, bottom: 5),
              height: 100,
              width: 100,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      product.title,
                      style: TextStyle(
                          color: Colors.black54,
                          fontFamily: 'Lato',
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      product.description,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'Roboto',
                        color: Color(0xFF212121),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            shape: BoxShape.rectangle,
                            color: product.isVeg ? Colors.green : Colors.red,
                          ),
                          margin: EdgeInsets.all(10),
                        ),
                      ),
                      Text(
                        'Rs. ${product.price}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Lato',
                          color: Colors.brown,
                          fontWeight: FontWeight.normal,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Divider()
      ],
    );
  }
}
