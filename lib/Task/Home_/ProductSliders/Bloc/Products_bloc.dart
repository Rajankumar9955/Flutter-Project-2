

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro2/Task/Home_/ProductSliders/Api_Services/api_repository.dart';
import 'package:pro2/Task/Home_/ProductSliders/Bloc/Products_event.dart';
import 'package:pro2/Task/Home_/ProductSliders/Bloc/Products_state.dart';
import 'package:pro2/Task/Home_/ProductSliders/Model/Product_model.dart';


class ProductsBloc extends Bloc <ProductsEvent, ProductsState>{
  ProductsBloc():super(ProductInitial()){
    final ApiRepository apiRepository=ApiRepository();

    on((event, emit)async{
      try{

        emit(ProductLoading());
        final List<Product>productList=await  apiRepository.fetchProductsList();
        emit(ProductLoaded(ProductList: productList));
        // if(productList[0].error !=null){
        //      emit(ProductError(error: productList[0].error));
        // }
      }on NetworkError{
        emit(ProductError(error: "failed to fetch the data"));

      }
    }); 

  }
}