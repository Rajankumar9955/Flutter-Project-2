import 'package:equatable/equatable.dart';

abstract class WishProductEvent extends Equatable {
  const WishProductEvent();

  @override
  List<Object> get props => [];
}

class GetWishProductsEvent extends WishProductEvent {}
