import 'package:consultant_orzu/controller/https/http.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPageProvider extends ChangeNotifier {
  Map listCategory = {
    "all": "hammasi".tr,
    "0": "waiting_order".tr,
    "1": "sold".tr,
    "2": "denied".tr,
  };

  var selectCategory;

  List dateRange = [];
  set setDateRange(value) {
    selectCategory = null;
    dateRange = value;
    if (dateRange.isNotEmpty) {
      if (dateRange.length == 1) {
        sorted = sales.where((element) => DateTime.parse(element['created_at']).difference(dateRange[0]).inDays == 0).toList();
      } else {
        sorted = sales.where((element) {
          return (DateTime.parse(element['created_at']).isAfter(dateRange[0]) || DateTime.parse(element['created_at']).difference(dateRange[0]).inDays == 0) || (DateTime.parse(element['created_at']).isBefore(dateRange[1]) || DateTime.parse(element['created_at']).difference(dateRange[1]).inDays == 0);
        }).toList();
      }
    } else {
      sorted = sales;
    }
    notifyListeners();
  }

  void onSelectItem(value) {
    
    selectCategory = value;
    sorted = sales.where((element) => element['status'] == value || value == "all").toList();
    if (dateRange.isNotEmpty) {
      if (dateRange.length == 1) {
        sorted = sorted.where((element) => element['created_at'].toString().contains(dateRange[0])).toList();
      } else {
        sorted = sorted.where((element) {
          return DateTime.parse(element['created_at']).isAfter(dateRange[0]) && DateTime.parse(element['created_at']).isBefore(dateRange[1]);
        }).toList();
      }
    }
    notifyListeners();
  }

  List sales = [];
  Map saleAllPrice = {};
  List sorted = [];

  //loader
  bool isLoading = false;

  CartPageProvider() {
    getSales();
  }

  getSales() async {
    isLoading = true;
    notifyListeners();
    var res = await HttpService.GET(
      HttpService.sales,
      base: HttpService.mainUrl,
    );
    if (res['status'] == HttpResponse.data) {
      sales = res['data'];
      await countPrice(sales);
      sorted = sales;
    } else {
      sales = [];
    }

    isLoading = false;
    notifyListeners();
  }

  countPrice(List sales) async {
    for (var sale in sales) {
      int price = 0;
      int count = 0;

      if (sale['products'].isEmpty) return;

      sale['products'].forEach((e) {
        if (e['data'] == null) return;
        e['count'] = int.parse(e['count']);
        if (!e['data']['is_discount']) {
          price += int.tryParse("${e['data']['price'] * e['count']}") ?? 0;
        } else {
          price += int.tryParse("${e['data']['discount_price'] * e['count']}") ?? 0;
        }

        if (e['startPrice'] != null) {
          price -= int.tryParse("${e['startPrice']}") ?? 0;
        }
        count += int.tryParse("${e['count']}") ?? 0;
      });

      saleAllPrice.addAll({
        sale['id']: {
          "price": price,
          "count": count,
        }
      });
    }
    notifyListeners();
  }
}
