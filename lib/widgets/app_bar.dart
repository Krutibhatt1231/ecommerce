import 'package:ahmedabad_test/bloc/counter/counter_bloc.dart';
import 'package:ahmedabad_test/bloc/counter/counter_state.dart';
import 'package:ahmedabad_test/helpers/string_helpers.dart';
import 'package:ahmedabad_test/widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../bloc/counter/counter_event.dart';
import '../helpers/colors_helper.dart';
import '../helpers/dimentions_helper.dart';
import '../helpers/images_helper.dart';

class CustomAppBar extends StatefulWidget {
  String title;
  CustomAppBar({required this.title}) : super();

  @override
  State<CustomAppBar> createState() => _CustomAppBarState(title);
}

class _CustomAppBarState extends State<CustomAppBar> {
  String title;
  _CustomAppBarState(this.title);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCount();
  }

  loadCount() async {
    context.read<CounterBloc>().add(CounterEvent.getCount);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: CustomText(
        title: title,
        fontSize: Diamentions.font18,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: const IconThemeData(color: ColorsHelper.whiteColor),
      backgroundColor: ColorsHelper.primaryColor,
      elevation: 0,
      leading: Builder(
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.all(Diamentions.width5),
            child: GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Container(
                decoration: const BoxDecoration(
                    color: ColorsHelper.primaryColor, shape: BoxShape.circle),
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  foregroundImage: NetworkImage(ImagesHelper.img_logo),
                ),
              ),
            ),
          );
        },
      ),
      actions: [
        InkWell(
          onTap: () => Get.toNamed("/cart"),
          child: SizedBox(
            height: Diamentions.width50,
            width: Diamentions.width100,
            child: Stack(
              children: [
                Positioned(
                  right: Diamentions.width30,
                  top: 0,
                  bottom: 0,
                  child: Icon(
                    Icons.shopping_cart,
                    size: Diamentions.screenHeight * 0.04,
                    color: ColorsHelper.whiteColor,
                  ),
                ),
                Positioned(
                  top: Diamentions.width5,
                  right: Diamentions.width10,
                  bottom: Diamentions.width20,
                  child: Container(
                    width: Diamentions.width30,
                    height: Diamentions.width30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80),
                        border: Border.all(color: Colors.red),
                        color: ColorsHelper.redColor),
                    child: Center(child: BlocBuilder<CounterBloc, CounterState>(
                      builder: (context, state) {
                        if (state is CounterLoadedState) {
                          int count = state.count;

                          return CustomText(
                            title: count.toString(),
                            fontSize: Diamentions.font16,
                          );
                        }
                        return CustomText(
                          title: StringHelpers.zero,
                          fontSize: Diamentions.font16,
                        );
                      },
                    )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
