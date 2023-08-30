import 'package:consultant_orzu/controller/https/http.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageProvider extends ChangeNotifier {
  var searchController = SearchController();
  bool isLoading = false;
  bool isCaruselLoading = false;
  List carusel = [];
  List discounts = [];
  List categories = [];

  int page = 1;

  HomePageProvider() {
    getDiscountProducts();
    getCaruselProducts();
  }

  //Discount products
  void getDiscountProducts() async {
    isLoading = true;
    notifyListeners();

    var res = await HttpService.GET(HttpService.discounts, base: HttpService.baseUrl);

    if (res['status'] == HttpResponse.data) {
      discounts = res['data']['data'];
      notifyListeners();
    } else {
      print(res['data']);
    }

    isLoading = false;
    notifyListeners();
  }

  void getCaruselProducts() async {
    isCaruselLoading = true;
    notifyListeners();

    var res = await HttpService.GET(HttpService.carusel, base: HttpService.mainUrl);

    if (res['status'] == HttpResponse.data) {
      carusel = res['data'];
      notifyListeners();
    } else {
      print(res['data']);
    }

    isCaruselLoading = false;
    notifyListeners();
  }
}
