import 'package:consultant_orzu/controller/hive/hive.dart';
import 'package:consultant_orzu/controller/https/http.dart';
import 'package:consultant_orzu/controller/models/product/product.dart';
import 'package:consultant_orzu/utils/widgets/main_snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutProductProvider extends ChangeNotifier {
  int imageCaruselIndex = 0;
  set changeCaruselIndex(value) {
    imageCaruselIndex = value;
    notifyListeners();
  }

  String slug;

  var seller = HiveService.get("seller");

  AboutProductProvider({required this.slug}) {
    getProduct();
  }

  Product? product;
  List questions = [];
  List features = [];
  List badges = [];

  bool isLoading = true;

  ///[getProduct] is getting product by [slug]
  getProduct() async {
    isLoading = true;
    notifyListeners();

    var res = await HttpService.GET("${HttpService.product}/$slug", base: HttpService.baseUrl);

    if (res['status'] == HttpResponse.data) {
      product = Product.fromMap(res['data']['data']);

      features = res['data']['data']['features'];
      badges = res['data']['data']['badges'] ?? [];

      await getQuestions(product?.categoryId ?? 0);
      notifyListeners();

      if (product!.isDiscount) {
        changeBottomPrice = product?.discountPrice?.truncate() ?? 0;
      } else {
        product!.discountPrice = 0;
        changeBottomPrice = product?.price?.truncate() ?? 0;
      }
    } else {
      print("_____________________Product Error:: ${res['data']}");
    }

    isLoading = false;
    notifyListeners();
  }

  ///[id] is  product's category id
  getQuestions(id) async {
    var res = await HttpService.GET(HttpService.getQuestions + "/$id", base: HttpService.mainUrl);
    if (res['status'] == HttpResponse.data) {
      questions = res['data'];
    } else {
      (res['data']);
    }
    notifyListeners();
  }

  //BottomSheetX Detalization
  var phone = "";
  set changePhone(value) {
    phone = value;
    notifyListeners();
  }

  var bottomPrice = 0;
  set changeBottomPrice(value) {
    bottomPrice = value;
    notifyListeners();
  }

  int bottomCount = 0;

  void bottomInc() {
    bottomCount++;
    notifyListeners();
  }

  void bottomDec() {
    if (bottomCount == 0) return;
    bottomCount--;
    notifyListeners();
  }

  var dateController = TextEditingController();
  var initPriceController = TextEditingController();
  bool isPayInitPrice = false;
  set changeIsPayInitPrice(value) {
    isPayInitPrice = value;
    notifyListeners();
  }

  bool isFormalizating = false;
  formalization() async {
    var seller = HiveService.get("seller");
    isFormalizating = true;
    notifyListeners();

    var params = {
      "saller_id": "${seller['id']}",
      "product_id": product?.id.toString(),
      "date": dateController.text,
      "count": bottomCount.toString(),
    };

    if (initPriceController.text.isNotEmpty) {
      params['startPrice'] = initPriceController.text.replaceAll(RegExp(r'[^0-9]'), '');
    } else {
      params['startPrice'] = "0";
    }
    notifyListeners();

    var res = await HttpService.POST(
      HttpService.sale,
      base: HttpService.mainUrl,
      params: params,
    );

    if (res['status'] == HttpResponse.data) {
      MainSnackbars.success("added_to_calculator".tr);
    } else {
      MainSnackbars.error("${res['data']}");
    }

    isFormalizating = false;
    notifyListeners();

    clear();
  }

  clear() {
    dateController.clear();
    initPriceController.clear();
    bottomCount = 0;
    notifyListeners();
  }
}
