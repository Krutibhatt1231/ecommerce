import 'package:ahmedabad_test/helpers/dimentions_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/categories/catgories_bloc.dart';
import '../bloc/counter/counter_bloc.dart';
import '../bloc/products/product_bloc.dart';
import '../helpers/colors_helper.dart';
import '../helpers/string_helpers.dart';
import '../repositories/cart_repository.dart';
import '../repositories/categories_repository.dart';
import '../repositories/product_repository.dart';
import '../widgets/app_bar.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/footer.dart';
import '../widgets/product_list.dart';
import '../widgets/sliding_images.dart';
import '../widgets/text.dart';

class PorductListScreen extends StatefulWidget {
  const PorductListScreen({Key? key}) : super(key: key);

  @override
  State<PorductListScreen> createState() => _PorductListScreenState();
}

class _PorductListScreenState extends State<PorductListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
      child: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(Diamentions.width50),
              child: CustomAppBar(
                title: StringHelpers.products,
              )),
          drawer: const CustomDrawer(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ViewPager(),
              SizedBox(
                height: Diamentions.width5,
              ),
              CustomText(
                title: StringHelpers.productslist,
                fontSize: Diamentions.font18,
                fontColor: ColorsHelper.primaryColor,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: Diamentions.width15,
              ),
              BlocProvider(
                  create: (context) =>
                      ProductBloc(productRepository: ProductRepository()),
                  child: ProductList()),
              Footer(),
            ],
          )),
    );
  }
}
