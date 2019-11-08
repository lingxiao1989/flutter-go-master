class CategoryModel {
  final int id;
  final String categoryName;
  final String iconImage;

  CategoryModel(this.id, this.categoryName, {this.iconImage});

  CategoryModel.fromJson(Map<String, dynamic> json) : this(
    json['id'],
    json['categoryName'],
    iconImage: json['iconImage'] != null ? json['iconImage'] : null,
  );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryName': categoryName,
      'iconImage': iconImage,
    };
  }
}