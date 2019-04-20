class Category{
  int  id;
  int  hotel_id;
  String title ;
  String image;
  String type;
  int waitingTime;
  String rating;
  String ratingCount;

  Category(this.title,this.id,this.image,this.type, this.waitingTime,this.rating,this.ratingCount);

    Category.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        type = json['type'],
        id = json['id'],
        hotel_id = json['hotel_id'],
        waitingTime = json['waitingTime'],
        rating = json['rating'],
        ratingCount = json['ratingCount'],
        image = json['image'];

  Map<String, dynamic> toJson() =>
    {
      'title': title,
      'image': image,
      'id': id,
      'hotel_id': hotel_id,
      'type': type,
      'waitingTime': waitingTime,
      'rating': rating,
      'ratingCount': ratingCount,
    };
}