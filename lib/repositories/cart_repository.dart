import 'package:ahmedabad_test/helpers/database_helper.dart';

import '../models/cart_model.dart';

class CartRepository {
  DbHelper dbHelper = DbHelper();

  Future<int> getCartCount() {
    print("KKgetCartCountCartRepository ${dbHelper.getCartItemCount()}");
    return dbHelper.getCartItemCount();
  }

  Future<double> getCartTotal() async {
    double total = 0.0;
    var items = await dbHelper.getCartList() as List;
    items.forEach((element) {
      double temp = element.getQty() * element.getPrice();
      total += temp;
    });
    return total;
  }

  Future<List<Cart>> getCartItems() async {
    var items = await dbHelper.getCartList() as List<Cart>;
    return items;
  }
}
