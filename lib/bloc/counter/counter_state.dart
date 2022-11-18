import 'package:equatable/equatable.dart';

import '../../models/cart_model.dart';

abstract class CounterState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CounterInitialState extends CounterState {}

class CounterItemsLoadingState extends CounterState {}

class CounterLoadedState extends CounterState {
  int count;
  double total;
  List<Cart> cartItems;
  CounterLoadedState(
      {required this.count, required this.total, required this.cartItems});
  @override
  List<Object> get props => [count, total, cartItems];
}
