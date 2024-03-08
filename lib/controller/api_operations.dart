import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:wallpaper_dev/model/category_model.dart';
import 'dart:convert';

import 'package:wallpaper_dev/model/photos_model.dart';

class ApiOperations {
  static List<PhotosModel> trendingWallpaper = [];
  static List<PhotosModel> searchingWallpapers = [];
  static List<CategoryModel> cateogryModelList = [];
  // Trending
  static Future<List<PhotosModel>> getTrendingWallpaperFromApi() async {
    await http.get(Uri.parse("https://api.pexels.com/v1/curated"), headers: {
      "Authorization":
          "YRRGRW4k1gsgXKNaghTdbv6AG0eBK35y2lP1MuVb40psqHcAtcunUOo6",
    }).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData["photos"];
      for (var element in photos) {
        trendingWallpaper.add(PhotosModel.fromAPI2App(element));
      }
    });
    return trendingWallpaper;
  }

  // Searching
  static Future<List<PhotosModel>> getSearchWallpaperFromApi(String query) async {
    await http.get(
      Uri.parse(
          "https://api.pexels.com/v1/search?query=$query&per_page=30&page=1"),
      headers: {
        "Authorization":
            "YRRGRW4k1gsgXKNaghTdbv6AG0eBK35y2lP1MuVb40psqHcAtcunUOo6",
      },
    ).then(
      (value) {
        Map<String, dynamic> jsonData = jsonDecode(value.body);
        List photos = jsonData["photos"];
        searchingWallpapers.clear();
        for (var element in photos) {
          searchingWallpapers.add(PhotosModel.fromAPI2App(element));
        }
      },
    );
    return searchingWallpapers;
  }

  // Category
  static List<CategoryModel> getCategoryListFromApi() {
    List categoryName = [
      "Cars",
      "Nature",
      "Bikes",
      "Street",
      "City",
      "Flowers"
    ];
    cateogryModelList.clear();
    // ignore: avoid_function_literals_in_foreach_calls
    categoryName.forEach((catName) async {
      final random = Random();
      PhotosModel photosModel =
          (await getSearchWallpaperFromApi(catName))[0 + random.nextInt(11 - 0)];
      cateogryModelList.add(
          CategoryModel(catImgName: catName, catImgSrc: photosModel.imgSrc));
    });
    return cateogryModelList;
  }
}
