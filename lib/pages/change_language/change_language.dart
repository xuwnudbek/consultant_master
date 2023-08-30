import 'package:consultant_orzu/controller/hive/hive.dart';
import 'package:consultant_orzu/utils/hex_to_color.dart';
import 'package:consultant_orzu/utils/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeLanguage extends StatefulWidget {
  const ChangeLanguage({super.key});

  @override
  State<ChangeLanguage> createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {
  var language = HiveService.get("language");

  void changeLanguage(String language) {
    HiveService.set("language", language);

    setState(() {
      this.language = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MainButton(
              color: language == "uz" ? HexToColor.mainColor : Colors.grey,
              onPressed: () {
                changeLanguage("uz");
                Get.back();
              },
              child: Text(
                "O'zbek",
                style: Get.textTheme.titleSmall!.copyWith(color: Colors.white),
              ),
            ),
            SizedBox(height: 10),
            MainButton(
              color: language == "ru" ? HexToColor.mainColor : Colors.grey,
              onPressed: () {
                changeLanguage("ru");
                Get.back();
              },
              child: Text(
                "Русский",
                style: Get.textTheme.titleSmall!.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
