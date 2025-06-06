import 'package:equatable/equatable.dart';
import 'package:pro2/Task/Model/product_model.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductModel> productsList;
  const ProductLoaded(this.productsList);

  @override
  List<Object> get props => [productsList];
}

class ProductError extends ProductState {
  final String message;
  const ProductError(this.message);

  @override
  List<Object> get props => [message];
}
