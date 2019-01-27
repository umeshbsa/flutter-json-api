class Flower {
  final String photo;
  final String category;
  final String name;
  final String instructions;

  Flower({this.photo, this.category, this.name, this.instructions});

  factory Flower.fromJson(Map<String, dynamic> json) {
    return new Flower(
      photo: json['photo'].toString(),
      category: json['category'],
      name: json['name'],
      instructions: json['instructions'],
    );
  }
}
