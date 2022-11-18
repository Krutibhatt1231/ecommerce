import 'package:ahmedabad_test/widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/counter/counter_bloc.dart';
import '../bloc/counter/counter_event.dart';
import '../bloc/counter/counter_state.dart';
import '../helpers/colors_helper.dart';
import '../helpers/dimentions_helper.dart';
import '../helpers/string_helpers.dart';

class Footer extends StatefulWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
//  double totalAmount = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    loadCount();
  }

  loadCount() async {
    context.read<CounterBloc>().add(CounterEvent.getCount);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Diamentions.screenWidth,
      height: Diamentions.width60,
      color: ColorsHelper.primaryColor,
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: CustomText(
              title: StringHelpers.copy_right_msg,
              fontSize: Diamentions.font12,
              fontWeight: FontWeight.bold,
              fontColor: ColorsHelper.whiteColor,
            ),
          ),
          Expanded(
            flex: 3,
            child: BlocBuilder<CounterBloc, CounterState>(
                builder: (context, state) {
              if (state is CounterLoadedState) {
                int count = state.count;
                double total = state.total;

                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        title:
                            StringHelpers.total_items + " ${count.toString()}",
                        fontSize: Diamentions.font14,
                        fontColor: ColorsHelper.whiteColor,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(
                        height: Diamentions.width10,
                      ),
                      CustomText(
                        title: StringHelpers.total_price +
                            "${double.parse((total).toStringAsFixed(2))}",
                        fontSize: Diamentions.font14,
                        fontWeight: FontWeight.bold,
                        fontColor: ColorsHelper.whiteColor,
                      ),
                    ],
                  ),
                );
              }
              return CustomText(
                title: StringHelpers.zero,
                fontSize: Diamentions.font16,
              );
            }),
          ),
        ],
      ),
    );
  }
}
