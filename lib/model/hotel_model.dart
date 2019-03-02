class Hotel{
  String  id;
  int  hotel_id;
  String name ;
  String image;
  String type;
  int waitingTime;
  String rating;
  String ratingCount;

  Hotel(this.name,this.id,this.image,this.type, this.waitingTime,this.rating,this.ratingCount);

    Hotel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        type = json['type'],
        id = json['id'],
        hotel_id = json['hotel_id'],
        waitingTime = json['waitingTime'],
        rating = json['rating'],
        ratingCount = json['ratingCount'],
        image = json['image'];

  Map<String, dynamic> toJson() =>
    {
      'name': name,
      'image': image,
      'id': id,
      'hotel_id': hotel_id,
      'type': type,
      'waitingTime': waitingTime,
      'rating': rating,
      'ratingCount': ratingCount,
    };
}