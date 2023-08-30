import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class AnimationNextPage extends StatelessWidget {
  AnimationNextPage({super.key, required this.child, required this.page});
  Widget child;
  Widget page;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedBuilder: (_, openContainer) {
        return child;
      },
      openColor: Colors.white,
      closedElevation: 0,
      closedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0), side: BorderSide.none),
      transitionDuration: const Duration(milliseconds: 1000),
      openBuilder: (_, closeContainer) {
        return page;
      },
    );
  }
}
