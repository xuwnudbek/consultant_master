import 'package:consultant_orzu/utils/hex_to_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.color = HexToColor.mainColor,
    this.height,
    this.width,
  });

  final Function onPressed;
  final Widget child;
  final Color color;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minWidth: width != null ? width! : Get.width * 0.4,
        minHeight: height ?? 0.0,
      ),
      child: MaterialButton(
        color: color,
        textTheme: ButtonTextTheme.primary,
        onPressed: () => onPressed(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: child,
        ),
      ),
    );
  }
}
