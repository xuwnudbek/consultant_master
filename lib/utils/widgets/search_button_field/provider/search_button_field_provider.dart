import 'package:consultant_orzu/controller/https/http.dart';
import 'package:flutter/material.dart';

class SearchButtonFieldProvider extends ChangeNotifier {
  var searchController = TextEditingController();

  bool isLoading = false;

  List _products = [];
  List get products => _products;
  set setProduct(value) {
    _products = value;
    notifyListeners();
  }

  SearchButtonFieldProvider() {
    // searchController.addListener(() async {
    //   print("++++++++++++" + searchController.text.length.toString());
    //   if (searchController.text.length > 2) {
    //     await getSearchProducts(searchController.text);
    //   } else {
    //     // setProduct = [];
    //   }
    // });
  }

  getSearchProducts(searchKey) async {
    if (searchKey.length < 3) return;
    isLoading = true;
    notifyListeners();

    var params = {"q": searchKey};
    var res = await HttpService.GET(
      HttpService.search,
      params: params,
      base: HttpService.baseUrl,
    );

    if (res['status'] == HttpResponse.data) {
      setProduct = res['data']['data'];

      print("-------------------------------------------------");
      print("search res: ${res['data']['data']}");
      print("-------------------------------------------------");

      notifyListeners();
    } else {
      notifyListeners();
    }

    isLoading = false;
    notifyListeners();
  }
}
