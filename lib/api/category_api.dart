import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class CategoriesApi {
  getCategories();
}

class CategoriesService extends CategoriesApi {
  String BASE_URL = "https://fakestoreapi.com/products";
  String CATEGORIES = "/categories";
  String PRODUCTS = "/products";

  Future<List<String>> getCategories() async {
    List<String> item;
    try {
      item = [];
      var uri = Uri.parse(BASE_URL + CATEGORIES);
      var response =
          await http.get(uri, headers: {"ContentType": "application/json"});
      print(response.body);
      var categoriesList = json.decode(response.body);

      print(categoriesList);
      categoriesList.forEach((element) {
        print(element);
        item.add(element);
      });
      return item;
    } catch (e) {
      print("error in categories service api $e");
      return List<String>.empty();
    }
  }
}
