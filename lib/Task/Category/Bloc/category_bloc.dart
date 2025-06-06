
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:pro2/Task/Model/category_model.dart';
import 'category_event.dart';
import 'category_state.dart';


class CategoryBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoryBloc() : super(CategoriesInitial()) {
    on<GetCategoriesEvent>((event, emit) async {
      emit(CategoriesLoading());

      try {
        final response = await http.get(
          Uri.parse("https://phplaravel-1264682-5431883.cloudwaysapps.com/api/categories"),
        );

        if (response.statusCode == 200) {
          var data= jsonDecode(response.body.toString());
           print(data);
          List<CategoriesModel> productList = [];
          data['categories'].map((e){
            productList.add(CategoriesModel.fromJson(e));
          }).toList();

          emit(CategoriesLoaded(productList));
        } else {
          emit(CategoriesError("Server error: ${response.statusCode}"));
        }
      } catch (e) {
        emit(CategoriesError("Failed to fetch products: $e"));
      }
    });
  }
}
