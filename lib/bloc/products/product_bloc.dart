import 'dart:io';

import 'package:ahmedabad_test/bloc/products/product_state.dart';
import 'package:ahmedabad_test/bloc/products/products_events.dart';
import 'package:ahmedabad_test/helpers/string_helpers.dart';
import 'package:ahmedabad_test/repositories/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/product_model.dart';

class ProductBloc extends Bloc<ProductEvents, ProductState> {
  final ProductRepository productRepository;
  List<ProductModel> listProducts = [];
  ProductBloc({required this.productRepository})
      : super(ProductInitialState()) {}

  @override
  Stream<ProductState> mapEventToState(ProductEvents event) async* {
    switch (event) {
      case ProductEvents.fetchProducts:
        yield ProductLoadingState();

        try {
          listProducts = await productRepository.getProductList();

          yield ProductLoadedState(products: listProducts);
        } on SocketException {
          yield ProductListErrorstate(
            error: (StringHelpers.no_internet),
          );
        } on HttpException {
          yield ProductListErrorstate(
            error: (StringHelpers.service_error),
          );
        } on FormatException {
          yield ProductListErrorstate(
            error: (StringHelpers.format_error),
          );
        } catch (e) {
          print(e.toString());
          yield ProductListErrorstate(
            error: (StringHelpers.unknown_error + e.toString()),
          );
        }
        break;
    }
  }
}
