import 'package:ahmedabad_test/helpers/database_helper.dart';
import 'package:ahmedabad_test/helpers/string_helpers.dart';
import 'package:ahmedabad_test/models/cart_model.dart';
import 'package:ahmedabad_test/widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/counter/counter_bloc.dart';
import '../bloc/counter/counter_event.dart';
import '../bloc/counter/counter_state.dart';
import '../helpers/colors_helper.dart';
import '../helpers/dimentions_helper.dart';

class CartItem extends StatelessWidget {
  Cart cartItem;
  CartItem(this.cartItem) : super();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterBloc, CounterState>(
      builder: (context, state) {
        if (state is CounterLoadedState) {
          return Padding(
            padding: EdgeInsets.all(Diamentions.width15),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: ColorsHelper.primaryColor),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(Diamentions.width10),
                    child: SizedBox(
                      height: Diamentions.width90,
                      child: Image.network(
                        cartItem.getImage().toString(),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.all(Diamentions.width10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          title: cartItem.getTitle(),
                          maxLines: 2,
                          textAlign: TextAlign.start,
                          fontSize: Diamentions.font16,
                          fontColor: ColorsHelper.blackColor,
                        ),
                        SizedBox(
                          height: Diamentions.width10,
                        ),
                        CustomText(
                          title: StringHelpers.price +
                              cartItem.getPrice().toString(),
                          maxLines: 2,
                          textAlign: TextAlign.start,
                          fontSize: Diamentions.font16,
                          fontWeight: FontWeight.bold,
                          fontColor: ColorsHelper.blackColor,
                        ),
                        SizedBox(
                          height: Diamentions.width10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                addQty(cartItem, context);
                              },
                              child: Container(
                                height: Diamentions.width25,
                                width: Diamentions.width25,
                                decoration: BoxDecoration(
                                    color: ColorsHelper.primaryColor,
                                    shape: BoxShape.circle),
                                child: Icon(
                                  Icons.add,
                                  color: ColorsHelper.whiteColor,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Diamentions.width20,
                            ),
                            Container(
                              height: Diamentions.width25,
                              width: Diamentions.width25,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: ColorsHelper.primaryColor),
                                  color: ColorsHelper.whiteColor,
                                  shape: BoxShape.circle),
                              child: Center(
                                child: BlocBuilder<CounterBloc, CounterState>(
                                  builder: (context, state) {
                                    return CustomText(
                                      title: cartItem.getQty().toString(),
                                      fontSize: Diamentions.font16,
                                      fontColor: ColorsHelper.primaryColor,
                                      fontWeight: FontWeight.bold,
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Diamentions.width20,
                            ),
                            GestureDetector(
                              onTap: () {
                                removeQty(cartItem, context);
                              },
                              child: Container(
                                height: Diamentions.width25,
                                width: Diamentions.width25,
                                decoration: BoxDecoration(
                                    color: ColorsHelper.primaryColor,
                                    shape: BoxShape.circle),
                                child: Icon(
                                  Icons.remove,
                                  color: ColorsHelper.whiteColor,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ))
                ],
              ),
            ),
          );
        }
        return SizedBox();
      },
    );
  }

  addQty(Cart item, BuildContext context) async {
    DbHelper dbHelper = DbHelper();
    try {
      Cart cart = Cart(
          id: item.getId(),
          title: item.getTitle(),
          description: item.getDescription(),
          price: item.getPrice(),
          image: item.getImage(),
          qty: item.getQty() + 1,
          rate: item.getRate());
      int res = await dbHelper.updateCartItem(cart);
      context.read<CounterBloc>().add(CounterEvent.getCount);
      print("add qtyone qty added successfully $res");
    } catch (e) {
      print("KK ${e.toString()}");
    }
  }

  removeQty(Cart item, BuildContext context) async {
    DbHelper dbHelper = DbHelper();
    if (item.getQty() == 0) {
      try {
        await dbHelper.deleteCartItem(item.getId());
        context.read<CounterBloc>().add(CounterEvent.getCount);
        print("deleted successfully ");
      } catch (e) {
        print("error in deletion${e.toString()}");
      }
    } else {
      try {
        Cart cart = Cart(
            id: item.getId(),
            title: item.getTitle(),
            description: item.getDescription(),
            price: item.getPrice(),
            image: item.getImage(),
            qty: item.getQty() > 0 ? item.getQty() - 1 : 0,
            rate: item.getRate());
        int res = await dbHelper.updateCartItem(cart);
        context.read<CounterBloc>().add(CounterEvent.getCount);
        print("removed qtyone qty added successfully $res");
      } catch (e) {
        print("KK ${e.toString()}");
      }
    }
    context.read<CounterBloc>().add(CounterEvent.getCount);
  }
}
