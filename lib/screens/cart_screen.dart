import 'package:ahmedabad_test/bloc/counter/counter_state.dart';
import 'package:ahmedabad_test/helpers/images_helper.dart';
import 'package:ahmedabad_test/widgets/cart_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../bloc/counter/counter_bloc.dart';
import '../bloc/counter/counter_event.dart';
import '../helpers/colors_helper.dart';
import '../helpers/dimentions_helper.dart';
import '../helpers/string_helpers.dart';
import '../models/cart_model.dart';
import '../repositories/cart_repository.dart';
import '../widgets/app_bar.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/footer.dart';
import '../widgets/rounded_button.dart';
import '../widgets/text.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Cart> cartItems = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCartItems();
  }

  loadCartItems() async {
    context.read<CounterBloc>().add(CounterEvent.getCount);
  }

  @override
  Widget build(BuildContext context) {
    loadCartItems();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CounterBloc(cartRepository: CartRepository()),
        ),
      ],
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(Diamentions.width50),
            child: CustomAppBar(
              title: StringHelpers.cart,
            ),
          ),
          drawer: const CustomDrawer(),
          body: Container(
            width: Diamentions.screenWidth,
            height: Diamentions.screenHeight,
            child: BlocBuilder<CounterBloc, CounterState>(
              builder: (context, state) {
                if (state is CounterLoadedState) {
                  cartItems = state.cartItems;
                  if (cartItems.isEmpty) {
                    return Container(
                      width: Diamentions.screenWidth,
                      height: Diamentions.screenHeight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            ImagesHelper.img_no_data,
                            width: Diamentions.screenWidth,
                            height: Diamentions.width200,
                          ),
                          SizedBox(
                            height: Diamentions.width10,
                          ),
                          CustomText(
                            title: StringHelpers.no_data_found,
                            fontSize: Diamentions.font18,
                            maxLines: 2,
                            textAlign: TextAlign.start,
                            fontColor: ColorsHelper.primaryColor,
                          ),
                          SizedBox(
                            height: Diamentions.width10,
                          ),
                          Container(
                            width: Diamentions.width200,
                            height: Diamentions.width30,
                            child: RoundedButton(
                              borderRadius: 4,
                              fontColor: ColorsHelper.whiteColor,
                              backgroundColor: ColorsHelper.primaryColor,
                              fontSize: Diamentions.font12,
                              onTap: () {
                                Get.toNamed("/categories");
                              },
                              title: StringHelpers.go_to_categories,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // CustomText(
                        //   title: StringHelpers.cart_items,
                        //   fontSize: Diamentions.font18,
                        //   fontColor: ColorsHelper.primaryColor,
                        //   fontWeight: FontWeight.bold,
                        // ),
                        SizedBox(
                          height: Diamentions.width15,
                        ),

                        Container(
                          child: Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.cartItems.length,
                              itemBuilder: (BuildContext context, int index) {
                                print("KKK :${cartItems[index].getImage()}");
                                return CartItem(cartItems[index]);
                              },
                            ),
                          ),
                        ),
                        Footer(),
                        //  Expanded(child: CartList()),
                      ],
                    );
                  }
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          )),
    );
  }
}
