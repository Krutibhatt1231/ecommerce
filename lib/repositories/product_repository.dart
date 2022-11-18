import 'package:ahmedabad_test/api/product_api.dart';

import '../models/product_model.dart';

class ProductRepository {
  Future<List<ProductModel>> getProductList() {
    return ProductService().getProducts();
  }
}
