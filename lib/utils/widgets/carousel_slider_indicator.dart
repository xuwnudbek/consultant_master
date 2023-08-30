import 'package:consultant_orzu/utils/hex_to_color.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CarouselSliderIndicator extends StatelessWidget {
  CarouselSliderIndicator({
    super.key,
    this.length = 0,
    this.position = 0,
    required this.list,
  });
  int position;
  int length;
  List list;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: list.map((e) {
            return AnimatedContainer(
              height: 7.sp,
              margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
              width: position == list.indexOf(e) ? 20 : 6,
              decoration: BoxDecoration(color: position == list.indexOf(e) ? HexToColor.mainColor : Colors.grey, borderRadius: BorderRadius.circular(5)),
              duration: const Duration(milliseconds: 500),
            );
          }).toList()

          //  getWidget(),
          ),
    );
  }

  List<Widget> getWidget() {
    List<Widget> listWidget = [];
    for (int i = 0; i < length; i++) {
      listWidget.add(
        AnimatedContainer(
          height: 7,
          margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
          width: position == i ? 30 : 7,
          decoration: BoxDecoration(color: position == i ? HexToColor.redContainerColor : Colors.grey, borderRadius: BorderRadius.circular(5)),
          duration: const Duration(milliseconds: 500),
        ),
      );
    }

    return listWidget;
  }
}
