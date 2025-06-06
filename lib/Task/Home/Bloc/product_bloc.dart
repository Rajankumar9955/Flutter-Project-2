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
          final data = jsonDecode(response.body.toString());
            print(data);
         
          List<ProductModel>productList=[];
          data['products'].map((e){
            productList.add(ProductModel.fromJson(e));
          }).toList();
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
