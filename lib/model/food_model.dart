class Food{
  int id;
  int count;
  String title;
  String description;
  dynamic price;
  String image;
  bool isVeg;

  Food(this.id, this.title,this.description,this.price, this.image, this.isVeg);

    Food.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        description = json['description'],
        price = json['price'],
        isVeg = json['isVeg'],
        image = json['image'];

  Map<String, dynamic> toJson() =>
    {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'isVeg': isVeg,
      'image': image
    };
}