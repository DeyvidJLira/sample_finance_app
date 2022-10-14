import 'package:finance_app_class/model/category.dart';

abstract class CategoryMock {
  static List<Category> getCategories() {
    return {"Alimentação", "Jogos", "Educação", "Saúde", "Transporte"}
        .map((e) => Category(name: e))
        .toList();
  }
}
