import 'package:equatable/equatable.dart';
import 'package:pro2/Task/Model/product_model.dart';

abstract class WishProductState extends Equatable {
  const WishProductState();

  @override
  List<Object> get props => [];
}

class WishProductInitial extends WishProductState {}

class WishProductLoading extends WishProductState {}

class WishProductLoaded extends WishProductState {
  final List<ProductModel> wishlistProducts;
  const WishProductLoaded(this.wishlistProducts);

  @override
  List<Object> get props => [wishlistProducts];
}

class WishProductError extends WishProductState {
  final String message;
  const WishProductError(this.message);

  @override
  List<Object> get props => [message];
}
