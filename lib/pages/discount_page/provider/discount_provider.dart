import 'package:consultant_orzu/controller/https/http.dart';
import 'package:flutter/material.dart';

class DiscountProvider extends ChangeNotifier {
  DiscountProvider(id) {
    getDiscount(id);
  }

  Map carusel = {};
  bool isLoading = false;

  Image? image;

  getDiscount(id) async {
    isLoading = true;
    notifyListeners();

    var res = await HttpService.GET(HttpService.carusel + "/$id", base: HttpService.mainUrl);

    if (res['status'] == HttpResponse.data) {
      carusel = res['data'] ?? {};
      notifyListeners();
      image = Image.network(carusel['image']);
    } else {
      (res);
    }

    isLoading = false;
    notifyListeners();
  }
}
