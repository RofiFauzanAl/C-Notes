class CategoryModel{
  int? idCategory;
  String? name, createCategoryAt, updateCategoryAt;

  CategoryModel({
    this.idCategory,
    this.name,
    this.createCategoryAt,
    this.updateCategoryAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    idCategory: json['idCategory'],
    name: json['name'],
    createCategoryAt: json['createCategoryAt'],
    updateCategoryAt: json['updateCategoryAt'],
  );

}