import 'package:consultant_orzu/utils/hex_to_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MainSlider extends StatelessWidget {
  const MainSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainSliderProvider>(
      create: (context) => MainSliderProvider(),
      child: Consumer<MainSliderProvider>(builder: (context, provider, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 4,
              width: double.infinity,
              color: Colors.grey.shade300,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => provider.onTabPosition(3),
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: provider.tag3 ? HexToColor.mainColor : Colors.grey.shade300,
                  ),
                ),
                InkWell(
                  onTap: () => provider.onTabPosition(6),
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: provider.tag6 ? HexToColor.mainColor : Colors.grey.shade300,
                  ),
                ),
                InkWell(
                  onTap: () => provider.onTabPosition(9),
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: provider.tag9 ? HexToColor.mainColor : Colors.grey.shade300,
                  ),
                ),
                InkWell(
                  onTap: () => provider.onTabPosition(12),
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.grey.shade300,
                  ),
                ),
              ],
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 50),
              left: provider.positionIndicator + 5,
              bottom: 50,
              child: GestureDetector(
                  child: Text(
                provider.title,
                style: TextStyle(fontWeight: FontWeight.w600),
              )),
            ),
            Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("3", style: TextStyle(fontWeight: FontWeight.w600)),
                    Text("6", style: TextStyle(fontWeight: FontWeight.w600)),
                    Text("9", style: TextStyle(fontWeight: FontWeight.w600)),
                    Text("12", style: TextStyle(fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 50),
              width: provider.positionIndicator,
              left: 0,
              child: GestureDetector(
                child: Container(
                  color: HexToColor.mainColor,
                  height: 4,
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 50),
              left: provider.positionIndicator,
              child: GestureDetector(
                onPanUpdate: (details) {
                  if (details.delta.dx > 0) {
                    provider.leftOnSwipe(details.delta.dx);
                  }
                  if (details.delta.dx < 0) {
                    provider.rightOnSwipe(details.delta.dx);
                  }
                },
                onPanEnd: (details) {
                  provider.onCheckPosition();
                },
                child: Container(
                  padding: const EdgeInsets.all(2.1),
                  decoration: BoxDecoration(border: Border.all(width: 2, color: HexToColor.mainColor), color: Colors.white, borderRadius: BorderRadius.circular(20)),
                  child: CircleAvatar(
                    radius: 4,
                    backgroundColor: Colors.red,
                  ),
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}

class MainSliderProvider extends ChangeNotifier {
  final double sizeDisplay = (Get.width - 88);
  double positionIndicator = (Get.width - 88);
  bool tag3 = true;
  bool tag6 = true;
  bool tag9 = true;
  String title = "";
  void leftOnSwipe(item) {
    positionIndicator = positionIndicator + item;

    if (positionIndicator > sizeDisplay) {
      positionIndicator = sizeDisplay;
    }
    onTagSelected();
    onCheckPositionTitle();
    notifyListeners();
  }

  void rightOnSwipe(item) {
    positionIndicator = positionIndicator + item;
    if (positionIndicator < 0) {
      positionIndicator = 0;
    }
    onTagSelected();
    onCheckPositionTitle();
    notifyListeners();
  }

  void onTagSelected() {
    if (positionIndicator >= 0 && positionIndicator < sizeDisplay / 3) {
      tag3 = true;
      tag6 = false;
      tag9 = false;
    }
    if (positionIndicator >= sizeDisplay / 3 && positionIndicator < sizeDisplay * 2 / 3) {
      tag3 = true;
      tag6 = true;
      tag9 = false;
    }
    if (positionIndicator > sizeDisplay * 2 / 3) {
      tag9 = true;
      tag6 = true;
      tag3 = true;
    }
    notifyListeners();
  }

  void onCheckPosition() {
    int item = 3;
    if (positionIndicator >= 0 && positionIndicator <= sizeDisplay / 18) {
      item = 3;

      positionIndicator = 0;
    }
    if (positionIndicator > sizeDisplay / 18 && positionIndicator <= sizeDisplay / 6) {
      item = 4;

      positionIndicator = sizeDisplay / 9;
    }
    if (positionIndicator > sizeDisplay / 6 && positionIndicator <= sizeDisplay * 5 / 18) {
      item = 5;

      positionIndicator = sizeDisplay * 2 / 9;
    }

    if (positionIndicator > sizeDisplay * 5 / 18 && positionIndicator <= sizeDisplay * 7 / 18) {
      item = 6;

      positionIndicator = sizeDisplay / 3;
    }
    if (positionIndicator > sizeDisplay * 7 / 18 && positionIndicator <= sizeDisplay / 2) {
      item = 7;

      positionIndicator = sizeDisplay * 4 / 9;
    }
    if (positionIndicator > sizeDisplay / 2 && positionIndicator <= sizeDisplay * 11 / 18) {
      positionIndicator = sizeDisplay * 5 / 9;
      item = 8;
    }
    if (positionIndicator > sizeDisplay * 11 / 18 && positionIndicator <= sizeDisplay * 13 / 18) {
      item = 9;

      positionIndicator = sizeDisplay * 2 / 3;
    }
    if (positionIndicator > sizeDisplay * 13 / 18 && positionIndicator <= sizeDisplay * 5 / 6) {
      item = 10;

      positionIndicator = sizeDisplay * 7 / 9;
    }
    if (positionIndicator > sizeDisplay * 5 / 6 && positionIndicator <= sizeDisplay * 17 / 18) {
      item = 11;

      positionIndicator = sizeDisplay * 8 / 9;
    }
    if (positionIndicator > sizeDisplay * 17 / 18) {
      item = 12;

      positionIndicator = sizeDisplay;
    }
    notifyListeners();
  }

  void onCheckPositionTitle() {
    int item = 3;

    if (positionIndicator >= 0 && positionIndicator <= sizeDisplay / 18) {
      item = 3;
      title = "";
    }
    if (positionIndicator > sizeDisplay / 18 && positionIndicator <= sizeDisplay / 6) {
      item = 4;
      title = item.toString();
    }
    if (positionIndicator > sizeDisplay / 6 && positionIndicator <= sizeDisplay * 5 / 18) {
      item = 5;
      title = item.toString();
    }

    if (positionIndicator > sizeDisplay * 5 / 18 && positionIndicator <= sizeDisplay * 7 / 18) {
      item = 6;
      title = "";
    }
    if (positionIndicator > sizeDisplay * 7 / 18 && positionIndicator <= sizeDisplay / 2) {
      item = 7;
      title = item.toString();
    }
    if (positionIndicator > sizeDisplay / 2 && positionIndicator <= sizeDisplay * 11 / 18) {
      item = 8;
      title = item.toString();
    }
    if (positionIndicator > sizeDisplay * 11 / 18 && positionIndicator <= sizeDisplay * 13 / 18) {
      item = 9;
      title = "";
    }
    if (positionIndicator > sizeDisplay * 13 / 18 && positionIndicator <= sizeDisplay * 5 / 6) {
      item = 10;
      title = item.toString();
    }
    if (positionIndicator > sizeDisplay * 5 / 6 && positionIndicator <= sizeDisplay * 17 / 18) {
      item = 11;
      title = item.toString();
    }
    if (positionIndicator > sizeDisplay * 17 / 18) {
      item = 12;
      title = "";
    }

    notifyListeners();
  }

  void onTabPosition(value) {
    switch (value) {
      case 3:
        positionIndicator = 0;
        break;
      case 6:
        positionIndicator = sizeDisplay / 3;
        break;
      case 9:
        positionIndicator = sizeDisplay * 2 / 3;
        break;
      case 12:
        positionIndicator = sizeDisplay;
        break;
      default:
    }
    onTagSelected();
    onCheckPositionTitle();
  }
}
