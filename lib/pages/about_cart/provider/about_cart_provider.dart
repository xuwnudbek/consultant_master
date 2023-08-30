import 'package:consultant_orzu/controller/https/http.dart';
import 'package:consultant_orzu/utils/widgets/main_snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutCartProvider extends ChangeNotifier {
  bool isLoading = false;
  Map save = {};

  onDeleteProduct(id) async {
    notifyListeners();

    await HttpService.POST(
      HttpService.deleteProduct + "/$id",
      base: HttpService.mainUrl,
      body: {"_method": "DELETE"},
    );

    

    notifyListeners();

    await Future.delayed(Duration(milliseconds: 500));
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

    isLoading = false;
    notifyListeners();
  }
}
