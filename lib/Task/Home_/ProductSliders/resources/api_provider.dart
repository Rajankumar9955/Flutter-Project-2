import 'package:pro2/Task/Home_/ProductSliders/Model/Product_model.dart';
import 'package:dio/dio.dart';

class ApiProvider {
  Dio dio = Dio();

  final String url = 'https://phplaravel-1264682-5431883.cloudwaysapps.com/api/products';

  Future<List<Product>> fetchProductsList() async {
    try {
      Response response = await dio.get(url);

      if (response.data is Map && response.data.containsKey('data')) {
        List<dynamic> value = response.data['data'];
        return value.map((e) => Product.fromJson(e)).toList();
      } else if (response.data is List) {
        List<dynamic> value = response.data;
        return value.map((e) => Product.fromJson(e)).toList();
      } else {
        throw Exception('Unexpected response format');
      }
    } catch (e) {
      print("Error fetching products: $e");
      rethrow; 
    }
  }
}
