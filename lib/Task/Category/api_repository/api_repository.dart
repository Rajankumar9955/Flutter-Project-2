
import 'package:dio/dio.dart';
import 'package:pro2/Task/Home_/ProductSliders/Model/Product_model.dart';

class CategoryRepository {
  final Dio _dio = Dio();

  Future<List<Product>> fetchCategories() async {
    final response = await _dio.get('https://phplaravel-1264682-5431883.cloudwaysapps.com/api/categories');

    if (response.statusCode == 200) {
      return (response.data as List)
          .map((json) => Product.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
