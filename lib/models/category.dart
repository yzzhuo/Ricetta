class RecipeCategory {
  final String id;
  final String name;
  final String image;

  RecipeCategory({required this.id, required this.name, required this.image});

  @override
  String toString() {
    return 'RecipeCategory: $name, Id: $id';
  }

  factory RecipeCategory.fromFirestore(Map<String, dynamic> data, String id) {
    return RecipeCategory(
      id: id,
      name: data['name'],
      image: data['image'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'image': image,
    };
  }
}
