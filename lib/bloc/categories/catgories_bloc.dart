import 'dart:io';

import 'package:ahmedabad_test/bloc/categories/categories_events.dart';
import 'package:ahmedabad_test/bloc/categories/categories_state.dart';
import 'package:ahmedabad_test/helpers/string_helpers.dart';
import 'package:ahmedabad_test/repositories/categories_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesBloc extends Bloc<CategoriesEvents, CategoriesState> {
  final CategoriesRepository categoriesRepository;
  List<String> listCategories = [];
  CategoriesBloc({required this.categoriesRepository})
      : super(CategoriesInitialState()) {}

  @override
  Stream<CategoriesState> mapEventToState(CategoriesEvents event) async* {
    switch (event) {
      case CategoriesEvents.fetchCategories:
        yield CategoriesLoadingState();
        try {
          listCategories = await categoriesRepository.getCategoriesList();
          yield CategoriesLoadedState(categories: listCategories);
        } on SocketException {
          yield CategoriesListErrorstate(
            error: (StringHelpers.no_internet),
          );
        } on HttpException {
          yield CategoriesListErrorstate(
            error: (StringHelpers.service_error),
          );
        } on FormatException {
          yield CategoriesListErrorstate(
            error: (StringHelpers.format_error),
          );
        } catch (e) {
          print(e.toString());
          yield CategoriesListErrorstate(
            error: (StringHelpers.unknown_error + e.toString()),
          );
        }
        break;
    }
  }
}
