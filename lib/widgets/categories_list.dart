import 'package:ahmedabad_test/bloc/categories/categories_state.dart';
import 'package:ahmedabad_test/bloc/categories/catgories_bloc.dart';
import 'package:ahmedabad_test/helpers/colors_helper.dart';
import 'package:ahmedabad_test/helpers/dimentions_helper.dart';
import 'package:ahmedabad_test/widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../bloc/categories/categories_events.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({Key? key}) : super(key: key);

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCategories();
  }

  loadCategories() async {
    context.read<CategoriesBloc>().add(CategoriesEvents.fetchCategories);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (BuildContext contex, CategoriesState state) {
      if (state is CategoriesListErrorstate) {
        final error = state.error;
        String message = '${error}\nTap to Retry.';
        return Text(
          message,
        );
      }
      if (state is CategoriesLoadedState) {
        List<String> categories = state.categories;
        return _list(categories);
      }
      return Center(
        child: CircularProgressIndicator(),
      );
    });
  }

  Widget _list(List<String> categories) {
    return Expanded(
      child: GridView.builder(
          itemCount: categories.length,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemBuilder: (_, index) {
            //  var s = categories[index].toString();
            return Padding(
              padding: EdgeInsets.all(Diamentions.width10),
              child: Container(
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed("/products");
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: ColorsHelper.whiteColor,
                        border: Border.all(color: ColorsHelper.primaryColor)),
                    child: Center(
                      child: CustomText(
                        title: categories[index].toString(),
                        fontSize: Diamentions.font20,
                        fontColor: ColorsHelper.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
