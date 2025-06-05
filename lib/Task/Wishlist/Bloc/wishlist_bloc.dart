import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:pro2/Task/Model/product_model.dart';
import 'wishlist_event.dart';
import 'wishlist_state.dart';


class WishProductBloc extends Bloc<WishProductEvent, WishProductState> {
  WishProductBloc() : super(WishProductInitial()) {
    on<GetWishProductsEvent>((event, emit) async {
      emit(WishProductLoading());

      try {
        final response = await http.get(
          Uri.parse("https://phplaravel-1264682-5431883.cloudwaysapps.com/api/products"),
        );

        if (response.statusCode == 200) {
          var data= jsonDecode(response.body.toString());
           print(data);
          List<ProductModel> productList = [];
          data['products'].map((e){
            productList.add(ProductModel.fromJson(e));
          }).toList();

          emit(WishProductLoaded(productList));
        } else {
          emit(WishProductError("Server error: ${response.statusCode}"));
        }
      } catch (e) {
        emit(WishProductError("Failed to fetch products: $e"));
      }
    });
  }
}
