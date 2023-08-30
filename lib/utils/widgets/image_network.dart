import 'package:flutter/material.dart';

class ImageNetwork extends StatelessWidget {
  ImageNetwork(this.imgPath, {super.key, this.imgFit = BoxFit.contain});

  String imgPath;
  BoxFit imgFit;
  @override
  Widget build(BuildContext context) {
    return Image.network(
      imgPath,
      fit: imgFit,
    );
  }
}
