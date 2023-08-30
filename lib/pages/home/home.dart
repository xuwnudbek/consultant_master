import 'package:consultant_orzu/pages/home/provider/home_provider.dart';
import 'package:consultant_orzu/pages/home/view/calculator/calculator_page.dart';
import 'package:consultant_orzu/pages/home/view/cart/cart_page.dart';
import 'package:consultant_orzu/pages/home/view/category/category_page.dart';
import 'package:consultant_orzu/pages/home/view/home_page/home_page.dart';
import 'package:consultant_orzu/utils/widgets/main_bottom_bar/main_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'view/profile/profile_page.dart';

class Home extends StatelessWidget {
  Home({super.key});
  List<Widget> listWidget = [
    HomePage(),
    CategoryPage(),
    CalculatorPage(),
    CartPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeProvider>(
      create: (context) => HomeProvider(),
      child: Consumer<HomeProvider>(builder: (context, provider, child) {
        return Scaffold(
          body: SafeArea(
            bottom: false,
            child: Stack(
              children: [
                listWidget[provider.itemSelect],
              ],
            ),
          ),
          extendBody: true,
          bottomNavigationBar: MainBottomBar(
            onPressed: provider.onPressed,
          ),
        );
      }),
    );
  }
}
