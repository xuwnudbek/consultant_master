import 'package:consultant_orzu/utils/hex_to_color.dart';
import 'package:consultant_orzu/utils/shadow/container_shadow.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CPIndicator extends StatelessWidget {
  CPIndicator({super.key, this.dimension = 30});

  double dimension;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 75,
          maxHeight: 75,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: shadowContainer(),
        ),
        padding: EdgeInsets.all(20),
        child: LoadingAnimationWidget.beat(
          color: HexToColor.mainColor,
          size: dimension,
        ),
      ),
    );
  }
}
