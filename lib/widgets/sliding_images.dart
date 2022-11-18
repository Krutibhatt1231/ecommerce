import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helpers/colors_helper.dart';
import '../helpers/dimentions_helper.dart';

class ViewPager extends StatefulWidget {
  @override
  State<ViewPager> createState() => _ViewPagerState();
}

class _ViewPagerState extends State<ViewPager> {
  late PageController _pageController;
  int _activePage = 0;
  List images = [
    "https://i.picsum.photos/id/102/4320/3240.jpg?hmac=ico2KysoswVG8E8r550V_afIWN963F6ygTVrqHeHeRc",
    "https://i.picsum.photos/id/994/200/300.jpg?grayscale&hmac=riqPpxGGQ5D79-pa8T3ocGwMo9gLdmDsamgtmsAYjW0",
    "https://i.picsum.photos/id/102/4320/3240.jpg?hmac=ico2KysoswVG8E8r550V_afIWN963F6ygTVrqHeHeRc",
    "https://i.picsum.photos/id/994/200/300.jpg?grayscale&hmac=riqPpxGGQ5D79-pa8T3ocGwMo9gLdmDsamgtmsAYjW0",
    "https://i.picsum.photos/id/6/5000/3333.jpg?hmac=pq9FRpg2xkAQ7J9JTrBtyFcp9-qvlu8ycAi7bUHlL7I",
  ];
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _pageController = PageController(viewportFraction: 0.8, initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: Diamentions.screenWidth,
          height: Diamentions.width200,
          child: PageView.builder(
              itemCount: images.length,
              pageSnapping: true,
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  _activePage = page;
                });
              },
              itemBuilder: (context, pagePosition) {
                return Container(
                    width: Diamentions.screenWidth,
                    height: Diamentions.width100,
                    margin: EdgeInsets.all(Diamentions.width10),
                    child: Image.network(
                      images[pagePosition],
                      width: Diamentions.screenWidth,
                      height: Diamentions.width50,
                      fit: BoxFit.fitWidth,
                    ));
              }),
        ),
        SizedBox(
          height: Diamentions.width50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List<Widget>.generate(
                images.length,
                (index) => Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Diamentions.width10),
                      child: InkWell(
                        onTap: () {
                          _pageController.animateToPage(index,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black12,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            radius: 5,
                            // check if a dot is connected to the current page
                            // if true, give it a different color
                            backgroundColor: _activePage == index
                                ? ColorsHelper.primaryColor
                                : Colors.white30,
                          ),
                        ),
                      ),
                    )),
          ),
        )
      ],
    );
  }
}
