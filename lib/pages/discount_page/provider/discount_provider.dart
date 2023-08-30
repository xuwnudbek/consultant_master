import 'package:consultant_orzu/controller/https/http.dart';
import 'package:flutter/foundation.dart';

class DiscountProvider extends ChangeNotifier {
  DiscountProvider(id) {
    getDiscount(id);
  }

  Map carusel = {};
  bool isLoading = false;

  getDiscount(id) async {
    isLoading = true;
    notifyListeners();

    var res = await HttpService.GET(HttpService.carusel + "/$id", base: HttpService.mainUrl);

    if (res['status'] == HttpResponse.data) {
      carusel = res['data'] ?? {};
      notifyListeners();
    } else {
      print(res);
    }

    isLoading = false;
    notifyListeners();
  }
}
