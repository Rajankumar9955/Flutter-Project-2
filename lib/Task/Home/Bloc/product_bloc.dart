import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:pro2/Task/Model/product_model.dart';
import 'product_event.dart';
import 'product_state.dart';


class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<GetProductsEvent>((event, emit) async {
      emit(ProductLoading());

      try {
        final response = await http.get(
          Uri.parse("https://phplaravel-1264682-5431883.cloudwaysapps.com/api/products"),
        );

        if (response.statusCode == 200) {
          final jsonData = json.decode(response.body);

          List<ProductModel> productList = List<ProductModel>.from(
            jsonData.map((item) => ProductModel.fromJson(item)),
          );

          emit(ProductLoaded(productList));
        } else {
          emit(ProductError("Server error: ${response.statusCode}"));
        }
      } catch (e) {
        emit(ProductError("Failed to fetch products: $e"));
      }
    });
  }
}
