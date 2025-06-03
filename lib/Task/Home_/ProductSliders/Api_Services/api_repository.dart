


import 'package:pro2/Task/Home_/ProductSliders/Api_Services/api_provider.dart';
import 'package:pro2/Task/Home_/ProductSliders/Model/Product_model.dart';


class ApiRepository {
  final ApiProvider _apiProvider=ApiProvider();
  Future<List<Product>>fetchProductsList(){
    return _apiProvider.fetchProductsList();
  }
}
class NetworkError extends Error{}