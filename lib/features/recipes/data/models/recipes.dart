class Recipe {
  final int id;
  final String title;
  final String imageUrl;

  Recipe({required this.id, required this.title, required this.imageUrl});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      title: json['title'],
      imageUrl: json['image'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'image': imageUrl,
      };
}
