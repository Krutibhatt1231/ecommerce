import 'package:ahmedabad_test/bloc/categories/catgories_bloc.dart';
import 'package:ahmedabad_test/bloc/counter/counter_bloc.dart';
import 'package:ahmedabad_test/helpers/colors_helper.dart';
import 'package:ahmedabad_test/helpers/dimentions_helper.dart';
import 'package:ahmedabad_test/repositories/cart_repository.dart';
import 'package:ahmedabad_test/widgets/categories_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../helpers/string_helpers.dart';
import '../repositories/categories_repository.dart';
import '../widgets/app_bar.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/footer.dart';
import '../widgets/sliding_images.dart';
import '../widgets/text.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
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
            title: StringHelpers.categories,
          ),
        ),
        drawer: CustomDrawer(),
        body: Padding(
          padding: EdgeInsets.all(Diamentions.width10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ViewPager(),
              SizedBox(
                height: Diamentions.width5,
              ),
              CustomText(
                title: StringHelpers.categories,
                fontSize: Diamentions.font18,
                fontColor: ColorsHelper.primaryColor,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: Diamentions.width15,
              ),
              const CategoriesList(),
              SizedBox(
                height: Diamentions.width20,
              ),
              Footer(),
            ],
          ),
        ),
      ),
    );
  }
}
