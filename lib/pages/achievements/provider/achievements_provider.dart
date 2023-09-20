import 'package:consultant_orzu/controller/hive/hive.dart';
import 'package:consultant_orzu/controller/https/http.dart';
import 'package:consultant_orzu/utils/widgets/main_snackbars.dart';
import 'package:flutter/material.dart';

class AchievementsProvider extends ChangeNotifier {
  bool isLoading = false;

  int sold = 0;
  int order = 0;
  int denied = 0;

  Map seller = {};

  ProfileProvider() {
    getProfile();
  }

  getProfile() async {
    var sellerId = HiveService.get("seller")['id'];
    isLoading = true;
    notifyListeners();

    var res = await HttpService.POST(HttpService.saller + "/$sellerId", base: HttpService.mainUrl, body: {"_method": "PUT"});

    ("#####################################################");
    (res);
    ("#####################################################");

    if (res['status'] == HttpResponse.error || res['status'] == HttpResponse.none) {
      MainSnackbars.error(res['data']);
      ("Vashshe error");
      return;
    }
    notifyListeners();
    seller = res['data'];
    //Get sold, order, denied orders count
    await getSalesAndSort(seller['sales']);

    isLoading = false;
    notifyListeners();
  }

  getSalesAndSort(List sales) {
    order = sales.where((element) => element['status'] == "0").toList().length;
    sold = sales.where((element) => element['status'] == '1').toList().length;
    denied = sales.where((element) => element['status'] == "2").toList().length;

    ("order: $order, sold: $sold, denied: $denied");
    notifyListeners();
  }
}
