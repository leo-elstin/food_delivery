class Food{
  int id;
  String title;
  String description;
  double price;
  String image = '';

  Food(this.id, this.title,this.description,this.price, this.image);

    Food.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        description = json['description'],
        price = json['price'],
        image = json['image'];

  Map<String, dynamic> toJson() =>
    {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'image': image
    };
}