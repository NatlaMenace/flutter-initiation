class Item {
  String name;
  double price;
  String category;

  Item({required this.name, required this.price, required this.category});

  // Convert a Item object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'category': category,
    };
  }

  // Create a Item object from a Map object
  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      name: map['name'],
      price: map['price'],
      category: map['category'],
    );
  }
}
