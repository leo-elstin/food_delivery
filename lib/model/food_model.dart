class Food{
  dynamic id;
  int count;
  int categoryId;
  int hotelId;
  String title;
  String description;
  dynamic price;
  String image;
  bool isVeg;

  Food({this.id,this.count, this.categoryId,this.hotelId, this.title,this.description,this.price, this.image, this.isVeg});

    Food.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        categoryId = json['category_id'],
        hotelId = json['hotel_id'],
        count = json['count'],
        description = json['description'],
        price = json['price'],
        isVeg = json['isVeg'],
        image = json['image'];

  Map<String, dynamic> toJson() =>
    {
      'id': id,
      'title': title,
      'category_id' :categoryId,
      'hotel_id' :hotelId,
      'count' :count,
      'description': description,
      'price': price,
      'isVeg': isVeg,
      'image': image
    };
}