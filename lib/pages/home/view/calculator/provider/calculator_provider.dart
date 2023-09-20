import 'package:consultant_orzu/controller/https/http.dart';
import 'package:consultant_orzu/utils/widgets/main_snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalculatorProvider extends ChangeNotifier {
  CalculatorProvider() {
    getSave();
  }
  bool isLoading = false;
  Map save = {};
  int allPrice = 0;
  int allInitialPrice = 0;
  int countProducts = 0;

  String phone = "";

  oformit(String phone) async {
    if (phone.isEmpty) return;

    phone = "+998" + phone.replaceAll(RegExp(r'[^0-9]'), '');

    isLoading = true;
    notifyListeners();
    var res = await HttpService.POST(
      HttpService.sale,
      body: {"phone": phone},
      base: HttpService.mainUrl,
    );

    (res);
    if (res['status'] == HttpResponse.data) {
      MainSnackbars.success("save_sent".tr);
    }
    await onRefresh(withOutLoading: true);

    isLoading = false;
    notifyListeners();

    return res;
  }

  getSave({withOutLoading = false}) async {
    if (!withOutLoading) {
      isLoading = true;
    }
    notifyListeners();

    var res = await HttpService.GET(
      HttpService.save,
      base: HttpService.mainUrl,
    );

    if (res['status'] == HttpResponse.data) {
      save = res['data'];
      await countPrice(save);
    } else {
      save = {};
    }

    if (!withOutLoading) {
      isLoading = false;
    }
    notifyListeners();
  }

  countPrice(Map save) async {
    if (save.isEmpty) return;
    int initPrice = 0;
    int price = 0;
    int count = 0;

    save['products'].forEach((e) {
      e['count'] = int.parse("${e['count']}");
      price += int.tryParse("${(e['data']['discount_price'] ?? e['data']['price']) * e['count']}") ?? 0;

      initPrice += int.tryParse("${e['startPrice']}") ?? 0;

      count += int.tryParse("${e['count']}") ?? 0;
    });

    allPrice = price;
    allInitialPrice = initPrice;
    countProducts = count;
    notifyListeners();
  }

  onChangeCount(id, value) async {
    if (value < 0) return;
    notifyListeners();

    await HttpService.POST(
      HttpService.updateProduct + "/$id",
      base: HttpService.mainUrl,
      body: {
        "count": "${value}",
        // "_method": "PUT"
      },
    );

    onRefresh(withOutLoading: true);

    notifyListeners();

    await Future.delayed(Duration(milliseconds: 500));
  }

  onDeleteProduct(id) async {
    notifyListeners();

    var res = await HttpService.POST(
      HttpService.deleteProduct + "/$id",
      base: HttpService.mainUrl,
      body: {"_method": "DELETE"},
    );

    onRefresh(withOutLoading: true);

    notifyListeners();

    await Future.delayed(Duration(milliseconds: 200));
  }

  void deleteSave() async {
    isLoading = true;
    notifyListeners();

    var res = await HttpService.POST(
      HttpService.save + "/${save['id']}",
      base: HttpService.mainUrl,
      body: {"_method": "DELETE"},
    );

    if (res['status'] == HttpResponse.data) {
      MainSnackbars.success("sale_deleted".tr);
    } else {
      MainSnackbars.error("save_not_deleted".tr);
    }

    onRefresh(withOutLoading: true);

    isLoading = false;
    notifyListeners();
  }

  onRefresh({withOutLoading = false}) {
    getSave(withOutLoading: withOutLoading);
  }
}
