import 'package:equatable/equatable.dart';

abstract class ProductState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ProductLoadingState extends ProductState {}

class ProductInitialState extends ProductState {}

class ProductLoadedState extends ProductState {
  var products;
  ProductLoadedState({required this.products});
}

class ProductListErrorstate extends ProductState {
  final error;
  ProductListErrorstate({this.error});
}
