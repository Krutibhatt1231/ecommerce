import 'package:ahmedabad_test/helpers/string_helpers.dart';
import 'package:ahmedabad_test/screens/cart_screen.dart';
import 'package:ahmedabad_test/screens/categories_screen.dart';
import 'package:ahmedabad_test/screens/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const CategoriesScreen(),
          '/categories': (context) => const CategoriesScreen(),
          '/products': (context) => const PorductListScreen(),
          '/cart': (context) => const CartScreen(),
        },
        title: StringHelpers.app_name,
        theme: ThemeData(
          dividerColor: Colors.transparent,
          primaryColor: const Color(0xff6f7cd2),
        ));
  }
}
