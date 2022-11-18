import '../api/category_api.dart';

class CategoriesRepository {
  Future<List<String>> getCategoriesList() {
    return CategoriesService().getCategories();
  }
}
