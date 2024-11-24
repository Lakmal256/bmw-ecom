class CarModel {
  String description;
  String id;
  String image;
  String name;
  String price;
  String type;

  CarModel({
    required this.description,
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    required this.type,
  });

  factory CarModel.fromJson(Map<String, dynamic> value) {
    return CarModel(
        description: value['description'],
        id: value['id'],
        image: value['image'],
        name: value['name'],
        price: value["price"],
        type: value['type']);
  }
}
