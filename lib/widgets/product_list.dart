import 'package:ahmedabad_test/bloc/products/product_bloc.dart';
import 'package:ahmedabad_test/bloc/products/products_events.dart';
import 'package:ahmedabad_test/helpers/colors_helper.dart';
import 'package:ahmedabad_test/helpers/dimentions_helper.dart';
import 'package:ahmedabad_test/helpers/string_helpers.dart';
import 'package:ahmedabad_test/widgets/rounded_button.dart';
import 'package:ahmedabad_test/widgets/text.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../bloc/categories/catgories_bloc.dart';
import '../bloc/counter/counter_bloc.dart';
import '../bloc/counter/counter_event.dart';
import '../bloc/products/product_state.dart';
import '../helpers/database_helper.dart';
import '../models/cart_model.dart';
import '../models/product_model.dart';
import '../repositories/cart_repository.dart';
import '../repositories/categories_repository.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      loadProducts();
    });
  }

  loadProducts() async {
    context.read<ProductBloc>().add(ProductEvents.fetchProducts);
  }

  @override
  Widget build(BuildContext context) {
    loadProducts();
    //  var bloc = Provider.of<CartProvider>(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              CategoriesBloc(categoriesRepository: CategoriesRepository()),
        ),
        BlocProvider(
          create: (context) => CounterBloc(cartRepository: CartRepository()),
        ),
      ],
      child: BlocBuilder<ProductBloc, ProductState>(
          builder: (BuildContext contex, ProductState state) {
        if (state is ProductListErrorstate) {
          final error = state.error;
          String message = error;
          return Text(
            message,
          );
        }
        if (state is ProductLoadedState) {
          List<ProductModel> products = state.products;

          return _list(products);
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }

  Widget _list(List<ProductModel> products) {
    return Expanded(
      child: ListView.builder(
          itemCount: products.length,
          shrinkWrap: true,
          itemBuilder: (_, index) {
            ProductModel item = products[index];
            return Padding(
              padding: EdgeInsets.only(
                  left: Diamentions.width10,
                  right: Diamentions.width10,
                  bottom: Diamentions.width10),
              child: Card(
                shadowColor: Colors.grey[2],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.white,
                elevation: 8.0,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          title: item.getTitle(),
                          fontSize: Diamentions.font16,
                          fontColor: ColorsHelper.primaryColor,
                        ),
                        SizedBox(
                          height: Diamentions.width10,
                        ),
                        Row(
                          children: [
                            Image.network(
                              item.getImage(),
                              width: Diamentions.width90,
                              height: Diamentions.width100,
                              fit: BoxFit.fill,
                            ),
                            SizedBox(
                              width: Diamentions.width10,
                            ),
                            Expanded(
                                child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    title: item.getDecsription(),
                                    fontSize: Diamentions.font14,
                                    fontColor: Colors.grey,
                                    textAlign: TextAlign.start,
                                    maxLines: 2,
                                  ),
                                  SizedBox(
                                    height: Diamentions.width10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RatingBar(
                                        isHalfAllowed: true,
                                        size: Diamentions.screenWidth * 0.05,
                                        alignment: Alignment.centerLeft,
                                        filledIcon: Icons.star,
                                        halfFilledIcon: Icons.star_half,
                                        emptyIcon: Icons.star_border_outlined,
                                        emptyColor: Colors.grey,
                                        halfFilledColor: Colors.amber,
                                        initialRating:
                                            item.getRating().getRate(),
                                        maxRating: 5,
                                        onRatingChanged: (double) {},
                                      ),
                                      CustomText(
                                        title: StringHelpers.count +
                                            item
                                                .getRating()
                                                .getCount()
                                                .toString(),
                                        fontSize: Diamentions.font14,
                                        fontColor: Colors.grey,
                                        textAlign: TextAlign.start,
                                        maxLines: 2,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: Diamentions.width10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                        title: StringHelpers.price +
                                            StringHelpers.rupee +
                                            item.getPrice().toString(),
                                        fontSize: Diamentions.font14,
                                        fontColor: Colors.red,
                                        textAlign: TextAlign.start,
                                        maxLines: 2,
                                      ),
                                      SizedBox(
                                        width: Diamentions.width10,
                                      ),
                                      Expanded(
                                        child: Container(
                                          width: Diamentions.width100,
                                          height: Diamentions.width30,
                                          child: RoundedButton(
                                            borderRadius: 4,
                                            fontColor: ColorsHelper.whiteColor,
                                            backgroundColor:
                                                ColorsHelper.primaryColor,
                                            fontSize: Diamentions.font12,
                                            onTap: () {
                                              checkItemInDatabase(item);
                                            },
                                            title: StringHelpers.add_to_cart,
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  checkItemInDatabase(ProductModel item) async {
    bool isFound = false;
    DbHelper dbHelper = DbHelper();
    try {
      List<Cart> cartItems = await dbHelper.getCartList() as List<Cart>;
      late Cart foundCartItem;
      if (cartItems.length > 0) {
        for (int i = 0; i < cartItems.length; i++) {
          if (cartItems[i].getId() == item.getId()) {
            isFound = true;
            foundCartItem = cartItems[i];
            break;
          } else {
            isFound = false;
          }
        }
        // cartItems.forEach(
        //   (element) async {
        //     if (element.getId() == item.getId()) {
        //       isFound = true;
        //       break;
        //     } else {
        //       isFound = false;
        //       // Cart cart = Cart(
        //       //     id: item.getId(),
        //       //     title: item.getTitle(),
        //       //     description: item.getDecsription(),
        //       //     price: item.getPrice(),
        //       //     image: item.getImage(),
        //       //     qty: 1,
        //       //     rate: item.getRating().getRate());
        //       //
        //       // int result = await dbHelper.insertCartItem(cart);
        //       // print("data is inserted==> :$result");
        //       // Get.snackbar(
        //       //     StringHelpers.success, StringHelpers.added_message_success,
        //       //     snackPosition: SnackPosition.BOTTOM,
        //       //     backgroundColor: Colors.grey);
        //     }
        //   },
        // );
        if (isFound) {
          updateCountOfItem(item, foundCartItem);
        } else {
          addItemToCart(item);
        }
      } else {
        addItemToCart(item);
      }
      context.read<CounterBloc>().add(CounterEvent.getCount);
    } catch (e) {
      Get.snackbar(StringHelpers.error, e.toString());
    }
  }

  updateCountOfItem(ProductModel productItem, Cart cartItem) async {
    DbHelper dbHelper = DbHelper();
    try {
      Cart cart = Cart(
          id: productItem.getId(),
          title: productItem.getTitle(),
          description: productItem.getDecsription(),
          price: productItem.getPrice(),
          image: productItem.getImage(),
          qty: cartItem.getQty() + 1,
          rate: productItem.getRating().getRate());
      int res = await dbHelper.updateCartItem(cart);
      print("user updated succesfully$res");
      Get.snackbar(StringHelpers.success, StringHelpers.updated_message_success,
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.grey);
      context.read<CounterBloc>().add(CounterEvent.getCount);
    } catch (e) {
      print("KK ${e.toString()}");
    }
  }

  addItemToCart(ProductModel item) async {
    DbHelper dbHelper = DbHelper();
    Cart cart = Cart(
        id: item.getId(),
        title: item.getTitle(),
        description: item.getDecsription(),
        price: item.getPrice(),
        image: item.getImage(),
        qty: 1,
        rate: item.getRating().getRate());

    int result = await dbHelper.insertCartItem(cart);
    print("data is inserted==> :$result");
    Get.snackbar(StringHelpers.success, StringHelpers.added_message_success,
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.grey);
    context.read<CounterBloc>().add(CounterEvent.getCount);
  }
}
