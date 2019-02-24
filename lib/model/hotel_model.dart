class Hotel{
  int  id;
  String name ;
  String image;
  String type;
  int waitingTime;
  String rating;
  String ratingCount;

  Hotel(this.name,this.image,this.type, this.waitingTime,this.rating,this.ratingCount);

    Hotel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        type = json['type'],
        id = json['id'],
        waitingTime = json['waitingTime'],
        rating = json['rating'],
        ratingCount = json['ratingCount'],
        image = json['image'];

  Map<String, dynamic> toJson() =>
    {
      'name': name,
      'image': image,
      'id': id,
      'type': type,
      'waitingTime': waitingTime,
      'rating': rating,
      'ratingCount': ratingCount,
    };
}