


import 'package:equatable/equatable.dart';
import 'package:pro2/Task/Home_/ProductSliders/Model/Product_model.dart';

abstract class ProductsState extends Equatable{
  const ProductsState();
  @override
  List<Object>get props => [];
}
class ProductInitial extends ProductsState{}

class ProductLoading extends ProductsState{}

class ProductLoaded extends ProductsState{
  final List<Product>ProductList;
  const ProductLoaded({required this.ProductList});
  List<Object?> get pops => [ProductList];
}

class ProductError extends ProductsState{
      final String?error;
      const ProductError({required this.error});
}