class CategoryModel {
  String catImgSrc;
  String catImgName;
  CategoryModel({required this.catImgName, required this.catImgSrc});

  static CategoryModel fromAPI2App(Map<String, dynamic> category) {
    return CategoryModel(
        catImgName: category["imgUrl"], catImgSrc: category["CategoryName"]);
  }
}
