import 'package:flutter/material.dart';
import 'package:food_delivery/model/hotel_model.dart';
import 'package:food_delivery/pages/food_list_page.dart';
//Firebase Db
import 'package:cloud_firestore/cloud_firestore.dart';

class HotelList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('hotel_list').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return Text('Loading...');
        final int messageCount = snapshot.data.documents.length;
        return ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: messageCount,
          itemBuilder: (_, int index) {
            final DocumentSnapshot document = snapshot.data.documents[index];
            // Map hotelMap = jsonDecode(document.data);
            var data = Hotel.fromJson(document.data);
            // print(data.toJson());
            return _buildHotelCard(context, hotel: data);
          },
        );
      },
    );
  }

  Widget _buildHotelCard(BuildContext context, {hotel: Hotel}) {
    return Container(
      height: 250,
      width: MediaQuery.of(context).size.width * .75,
      padding: EdgeInsets.only(left: 8, right: 8),
      child: Card(
        elevation: 1,
        child: InkWell(
          splashColor: Colors.black26,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => FoodListPage(hotel),
              ),
            );
          },
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                // decoration: BoxDecoration(
                //   shape:BoxShape.circle,
                //   image: DecorationImage(
                //     image: NetworkImage(hotel.image),
                //     fit: BoxFit.cover,
                //   ),
                //   borderRadius: BorderRadius.only(
                //     topLeft: Radius.circular(4),
                //     topRight: Radius.circular(4),
                //   ),
                // ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      hotel.name,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Lato'),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      hotel.type,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Lato'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          '${hotel.waitingTime.toString()} Mins',
                          style: TextStyle(
                              color: hotel.waitingTime < 25
                                  ? Colors.black
                                  : Colors.red,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Lato'),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          hotel.rating != null ? '${hotel.rating}' : 'N/A',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Lato'),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.star,
                          size: 18,
                        ),
                        Text(
                          hotel.ratingCount != null ? ' (${hotel.ratingCount}+)' : '',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Lato'),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
