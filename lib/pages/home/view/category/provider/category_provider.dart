import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:consultant_orzu/controller/https/http.dart';
import 'package:consultant_orzu/controller/models/category/category.dart';
import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier {
  var searchController = TextEditingController();
  var scrollController = ScrollController();

  GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCartAnimation;

  ExpansionTileController expansionTileController = ExpansionTileController();

  onChanged() {
    notifyListeners();
  }

  String? _selectedCategory;
  get selectedCategory => _selectedCategory;
  set selectedCategory(value) {
    _selectedCategory = value;
    notifyListeners();
  }

  var _cartQuantityItems = 0;

  List products = [];

  CategoryProvider() {
    onInit();
  }

  String _titleCategory = "";
  get titleCategory => _titleCategory;
  set titleCategory(value) {
    _titleCategory = value;
    notifyListeners();
  }

  int page = 1;

  onInit() async {
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        getProducts("${slug1}", true);
      }
    });
    await getCategories();
  }

  bool isCategory = true;
  set changeCategory(value) {
    isCategory = value;
    titleCategory = "";
    notifyListeners();
  }

  bool isLoading = false;
  bool isAdding = false;
  List mainCategories = [];

  // Request Functions

  getCategories() async {
    isLoading = true;
    notifyListeners();

    var res = await HttpService.GET(HttpService.categories, base: HttpService.baseUrl);

    if (res['status'] == HttpResponse.data) {
      mainCategories = res['data']['data'].map((e) {
        return Category.fromMap(e);
      }).toList();

      notifyListeners();
    }

    isLoading = false;
    notifyListeners();
  }

  getProducts(String slug, [bool isAdding = false]) async {
    isLoading = true;
    this.isAdding = isAdding;
    notifyListeners();
    if (!isAdding) {
      page = 1;
    }
    var res = await HttpService.GET(
      HttpService.products + "/$slug",
      base: HttpService.baseUrl,
      params: {"page": "${page}"},
    );
    if (page == 1) {
      page++;
    }

    if (res['status'] == HttpResponse.data) {
      (res['data']);
      if (isAdding) {
        products.addAll(res['data']['data']);
        int lastPage = res['data']['meta']['last_page'] ?? 0;
        print("myPage:: $page");
        print("lastPage:: $lastPage");

        if (page <= lastPage) {
          page++;
          notifyListeners();
        }
      } else {
        products = res['data']['data'];
      }
      notifyListeners();
    }
    this.isAdding = false;
    isLoading = false;
    notifyListeners();
  }

  //local Functions
  String slug1 = "";
  void onSelectCategory({String breadCrumbs = "", slug}) {
    changeCategory = false;
    titleCategory = breadCrumbs;
    notifyListeners();
    ("__________________breadCrumbs:: $breadCrumbs");
    this.slug1 = slug;
    notifyListeners();
    getProducts("${slug}");
  }

  void listClick(GlobalKey widgetKey) async {
    await runAddToCartAnimation(widgetKey);
    await cartKey.currentState!.runCartAnimation((_cartQuantityItems).toString());
  }
}
