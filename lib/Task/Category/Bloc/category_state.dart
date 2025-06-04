




// import 'package:equatable/equatable.dart';
// import 'package:pro2/Task/Home_/ProductSliders/Model/Product_model.dart';

// abstract class CategoryState extends Equatable{
//   const CategoryState();
//   @override
//   List<Object>get props => [];
// }
// class CategoryInitial extends CategoryState{}

// class CategoryLoading extends CategoryState{}

// class CategoryLoaded extends CategoryState{
//   final List<Product>CategoryList;
//   const CategoryLoaded({required this.CategoryList});
//   List<Object?> get pops => [CategoryList];
// }

// class CategoryError extends CategoryState{
//       final String?error;
//      CategoryError({required this.error});
// }



import 'package:pro2/Task/Home_/ProductSliders/Model/Product_model.dart';


abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<Product> categoriesList;

  CategoryLoaded(this.categoriesList);
}

class CategoryError extends CategoryState {
  final String message;

  CategoryError(this.message);
}
