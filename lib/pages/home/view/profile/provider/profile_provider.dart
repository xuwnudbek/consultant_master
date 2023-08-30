import 'dart:convert';
import 'dart:math';

import 'package:consultant_orzu/controller/hive/hive.dart';
import 'package:consultant_orzu/controller/https/http.dart';
import 'package:consultant_orzu/utils/widgets/main_snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

class ProfileProvider extends ChangeNotifier {
  var db = Hive.box("db");
  var language;
  bool isLoading = false;

  int sold = 0;
  int order = 0;
  int denied = 0;

  Map seller = {};

  ProfileProvider() {
    getLanguage();
    getProfile();
  }

  getProfile() async {
    var sellerId = HiveService.get("seller")['id'];
    isLoading = true;
    notifyListeners();
    var res = await HttpService.POST(
      HttpService.saller + "/$sellerId",
      base: HttpService.mainUrl,
      body: {"_method": "PUT"},
    );

    if (res['status'] == HttpResponse.error || res['status'] == HttpResponse.none) {
      MainSnackbars.error(res['data']);
      return;
    }

    seller = res['data'];
    //Get sold, order, denied orders count
    await getSalesAndSort(seller['sales']);

    isLoading = false;
    notifyListeners();
  }

  getSalesAndSort(List sales) {
    order = sales.where((element) => element['status'] == 0).toList().length;
    sold = sales.where((element) => element['status'] == 1).toList().length;
    denied = sales.where((element) => element['status'] == 2).toList().length;

    print("order: $order, sold: $sold, denied: $denied");
    notifyListeners();
  }

  getLanguage() {
    language = db.get("language");
    notifyListeners();
  }

  refresh() {
    getProfile();
    getLanguage();
  }

  logout() async {
    await Future.delayed(Duration(seconds: 1));
    await HiveService.clear();
    Get.back();
  }
}
