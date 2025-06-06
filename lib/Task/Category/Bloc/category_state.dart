import 'package:equatable/equatable.dart';
import 'package:pro2/Task/Model/category_model.dart';
import 'package:pro2/Task/Model/product_model.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object> get props => [];

}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesLoaded extends CategoriesState {
  final List<CategoriesModel> CategoriesProducts;
  
  const CategoriesLoaded(this.CategoriesProducts);

  @override
  List<Object> get props => [CategoriesProducts];
}

class CategoriesError extends CategoriesState {
  final String message;
  const CategoriesError(this.message);

  @override
  List<Object> get props => [message];
}
