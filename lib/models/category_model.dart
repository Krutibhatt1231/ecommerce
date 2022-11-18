import 'dart:convert';

List<CategoriesModel> categoriesFromJson(String str) =>
    List<CategoriesModel>.from(
        json.decode(str).map((x) => CategoriesModel.fromJson(x)));

String albumsToJson(List<CategoriesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoriesModel {
  String? catName;
  CategoriesModel({this.catName});

  getCategoryName() {
    return catName;
  }

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(
        catName: json["catName"],
      );

  Map<String, dynamic> toJson() => {
        "catName": catName,
      };
}
