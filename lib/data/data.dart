import 'package:news_app/models/category_model.dart';

List<CategoryModel> getCategories() {
  {
    return [
      CategoryModel(
        categoryName: 'Business',
        categoryImage: 'assets/images/business.jpg',
      ),
      CategoryModel(
        categoryName: 'Entertainment',
        categoryImage: 'assets/images/entertainment.jpg',
      ),
      CategoryModel(
        categoryName: 'General',
        categoryImage: 'assets/images/general.jpg',
      ),
      CategoryModel(
        categoryName: 'Health',
        categoryImage: 'assets/images/health.jpg',
      ),
      CategoryModel(
        categoryName: 'Sports',
        categoryImage: 'assets/images/sport.jpg',
      ),
    ];
  }
}
