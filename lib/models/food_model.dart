class Food {
  final String name;
  final int price;
  Food({required this.name, required this.price});

  Map<String, dynamic> toJson() {
    return {"name": name, "price": price};
  }
}
