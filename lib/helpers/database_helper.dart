import 'dart:async';
import 'dart:io';

import 'package:ahmedabad_test/models/cart_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  Database? _database;
  var CREATE_TABLE_CART =
      'CREATE TABLE cart (id INTEGER, title TEXT, description TEXT,rate DOUBLE ,price DOUBLE,image TEXT,qty INTEGER )';
  var DROP_TABLE_CART = 'DROP TABLE IF EXISTS cart';
  Future<Database> get db async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDatabase();
    return _database!;
  }

  initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    var db = await openDatabase(
      join(documentDirectory.path, 'CartDB.db'),
      version: 1,
      onCreate: onCreate,
      onUpgrade: onUpgradeDb,
    );
    return db;
  }

  onCreate(Database db, int version) async {
    await db.execute(CREATE_TABLE_CART);
  }

  onUpgradeDb(Database db, int oldVersion, int newVersion) async {
    await db.execute(DROP_TABLE_CART);
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }

  Future<int> insertCartItem(Cart model) async {
    var dbClient = await db;
    Map<String, dynamic> row = {
      "id": model.getId(),
      "title": model.getTitle(),
      "description": model.getDescription(),
      "rate": model.getRate(),
      "price": model.getPrice(),
      "image": model.getImage(),
      "qty": model.getQty(),
    };

    return await dbClient.insert("cart", row);
  }

  Future<List<Cart>> getCartList() async {
    var dbClient = await db;
    List<Cart> cartList = [];

    List<Map> map = await dbClient.rawQuery('SELECT * FROM cart');
    for (int i = 0; i < map.length; i++) {
      Cart model = Cart(
          id: map[i]['id'],
          title: map[i]['title'],
          description: map[i]['description'],
          rate: map[i]['rate'],
          qty: map[i]['qty'],
          price: map[i]['price'],
          image: map[i]['image']);
      cartList.add(model);
    }
    return cartList;
  }

  updateCartItem(Cart item) async {
    try {
      final dbClient = await db;
      var result = await dbClient.update("cart", item.toJson(),
          where: "id = ?", whereArgs: [item.getId()]);
      print("$result :: cart item has been updated successfully");
      return result;
    } catch (e) {
      print("error$e");
    }
  }

  deleteCartItem(int id) async {
    final dbClient = await db;
    dbClient.delete("cart", where: "id = ?", whereArgs: [id]);
  }

  Future<int> getCartItemCount() async {
    var dbClient = await db;
    int totalCount = 0;
    List<Cart> cartList = [];

    List<Map> map = await dbClient.rawQuery('SELECT * FROM cart');
    for (int i = 0; i < map.length; i++) {
      int qty = map[i]['qty'];
      Cart model = Cart(
          id: map[i]['id'],
          title: map[i]['title'],
          description: map[i]['description'],
          rate: map[i]['rate'],
          price: map[i]['price'],
          image: map[i]['image'],
          qty: map[i]['qty']);
      totalCount = totalCount + qty;
      cartList.add(model);
    }
    return totalCount;
  }
}
