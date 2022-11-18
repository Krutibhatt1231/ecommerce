import 'package:ahmedabad_test/widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../helpers/colors_helper.dart';
import '../helpers/dimentions_helper.dart';
import '../helpers/string_helpers.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late int selectedDrawerIndex;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedDrawerIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    _getDrawerItemWidget(int pos) {
      switch (pos) {
        case 0:
          Scaffold.of(context).closeDrawer();
          return Get.toNamed("/categories");
        case 1:
          Scaffold.of(context).closeDrawer();
          return Get.toNamed("/products");
        case 2:
          Scaffold.of(context).closeDrawer();
          return Get.toNamed("/cart");

        default:
          return Text("Error");
      }
    }

    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
      child: Drawer(
        child: Column(children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: ColorsHelper.primaryColor,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: Diamentions.width10,
                ),
                Container(
                  height: Diamentions.width50,
                  width: Diamentions.width50,
                  child: CircleAvatar(
                    backgroundColor: ColorsHelper.whiteColor,
                    radius: 20,
                    child: Icon(
                      Icons.person,
                      size: Diamentions.width50,
                      color: ColorsHelper.primaryColor,
                    ),
                  ),
                ),
                SizedBox(
                  width: Diamentions.width20,
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Diamentions.width10,
                        vertical: Diamentions.width10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomText(
                          title: "Kiran Patil",
                          fontSize: Diamentions.font18,
                          fontWeight: FontWeight.bold,
                        ),
                        CustomText(
                          title: "12345567782",
                          fontSize: Diamentions.font18,
                          fontWeight: FontWeight.bold,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              height: Diamentions.screenHeight,
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: drawerItems.length,
                  itemBuilder: (context, index) {
                    DrawerItemModel item = drawerItems[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Diamentions.width10,
                          vertical: Diamentions.width10),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedDrawerIndex = index;
                            _getDrawerItemWidget(index);

                            print("drawwer");
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              item.getIcon(),
                              size: Diamentions.width20,
                              color: ColorsHelper.primaryColor,
                            ),
                            SizedBox(
                              width: Diamentions.width10,
                            ),
                            CustomText(
                              title: item.getTitle(),
                              fontSize: Diamentions.font16,
                              fontColor: Colors.black,
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          )
        ]),
      ),
    );
  }
}

///model class
class DrawerItemModel {
  // bool? isRadioButtonFill;
  IconData? icon;
  String? title;
  DrawerItemModel(
      { //required this.isRadioButtonFill,
      required this.icon,
      required this.title});
  factory DrawerItemModel.fromJson(Map<String, dynamic> json) {
    return DrawerItemModel(
      //   isRadioButtonFill: json['isRadioButtonFill'],
      icon: json['icon'],
      title: json['title'],
    );
  }
  // getIsRadioButton() {
  //   return isRadioButtonFill ?? false;
  // }

  getIcon() {
    return icon;
  }

  getTitle() {
    return title;
  }
}

DrawerItemModel drawerItem1 =
    DrawerItemModel(icon: Icons.add, title: StringHelpers.categories);
DrawerItemModel drawerItem2 =
    DrawerItemModel(icon: Icons.circle, title: StringHelpers.products);
DrawerItemModel drawerItem3 = DrawerItemModel(
    icon: Icons.notifications_active_outlined, title: StringHelpers.cart);
List<DrawerItemModel> drawerItems = [
  drawerItem1,
  drawerItem2,
  drawerItem3,
];
