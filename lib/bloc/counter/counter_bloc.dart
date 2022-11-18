import 'dart:async';

import 'package:ahmedabad_test/repositories/cart_repository.dart';
import 'package:bloc/bloc.dart';

import '../../models/cart_model.dart';
import 'counter_event.dart';
import 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  final CartRepository cartRepository;

  CounterBloc({required this.cartRepository}) : super(CounterInitialState()) {
    onEvent(CounterEvent.getCount);
  }
  @override
  Stream<CounterState> mapEventToState(CounterEvent event) async* {
    switch (event) {
      case CounterEvent.getCount:
        try {
          int count = 0;
          double total = 0.0;
          List<Cart> cartItems = [];
          count = await cartRepository.getCartCount();
          total = await cartRepository.getCartTotal();
          cartItems = await cartRepository.getCartItems();
          print("KKcount inCounterEvent.getCount$count");
          yield CounterLoadedState(
              count: count, total: total, cartItems: cartItems);
        } catch (e) {
          print("errror in counterbloc :${e}");
        }
        break;
    }
  }
}
