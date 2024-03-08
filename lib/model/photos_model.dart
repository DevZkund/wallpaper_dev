class PhotosModel {
  String imgSrc;
  String imgName;

  PhotosModel({required this.imgSrc, required this.imgName});
  static PhotosModel fromAPI2App(Map<String, dynamic> photoMap) {
    return PhotosModel(
        imgName: photoMap["photographer"],
        imgSrc: (photoMap["src"])["portrait"]);
  }
}
