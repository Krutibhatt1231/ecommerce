import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/product_model.dart';

abstract class ProductApi {
  getProducts();
}

class ProductService extends ProductApi {
  String BASE_URL = "https://fakestoreapi.com";
  String PRODUCTS = "/products";

  Future<List<ProductModel>> getProducts() async {
    List<ProductModel> products;
    try {
      products = [];
      var uri = Uri.parse(BASE_URL + PRODUCTS);
      var response =
          await http.get(uri, headers: {"ContentType": "application/json"});
      //  print(response.body);
      //    categoriesList = categoriesFromJson(response.body);
      var productList = json.decode(response.body);

      productList.forEach((element) {
        ProductModel item =
            ProductModel.fromJson(element as Map<String, dynamic>);
        print(element);
        products.add(item);
        print(item.getId());
      });
      return products;
    } catch (e) {
      print("error in products service api $e");
      return List<ProductModel>.empty();
    }
  }
}
