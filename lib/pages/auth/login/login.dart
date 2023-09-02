import 'package:consultant_orzu/pages/auth/login/provider/login_provider.dart';
import 'package:consultant_orzu/utils/hex_to_color.dart';
import 'package:consultant_orzu/utils/widgets/loaders/loading_indicator.dart';
import 'package:consultant_orzu/utils/widgets/main_button.dart';
import 'package:consultant_orzu/utils/widgets/main_snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Login extends StatelessWidget {
  Login({super.key});

  var _formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginProvider>(
        create: (context) => LoginProvider(),
        builder: (context, snapshot) {
          return Consumer<LoginProvider>(
            builder: (ctx, provider, _) {
              return Scaffold(
                body: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _buildAppbar(provider),
                        Spacer(),
                        _buildForm(provider),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
  }

  Widget _buildForm(LoginProvider provider) {
    return Form(
      key: _formState,
      child: Container(
        padding: EdgeInsets.all(60),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: HexToColor.light,
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              spreadRadius: 0.5,
              color: HexToColor.greyTextFieldColor,
            ),
          ],
        ),
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  "login".tr,
                  style: Theme.of(Get.context!).textTheme.titleMedium,
                ),
              ],
            ),
            SizedBox(height: 15),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: HexToColor.greyTextFieldColor,
              ),
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: provider.login,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "phone".tr,
                ),
                style: Theme.of(Get.context!).textTheme.bodyLarge,
              ),
            ),
            SizedBox(height: 10),
            //password field
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: HexToColor.greyTextFieldColor,
              ),
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: provider.password,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "password".tr,
                  errorStyle: TextStyle(
                    fontSize: 0,
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: HexToColor.error,
                    ),
                  ),
                ),
                style: Theme.of(Get.context!).textTheme.bodyLarge,
              ),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MainButton(
                  onPressed: () async {
                    if (provider.validate()) {
                      await provider.auth();
                    } else {
                      MainSnackbars.error("all_fields_not_filled".tr);
                    }
                  },
                  child: Row(
                    children: [
                      provider.isLoading
                          ? LoadingIndicator()
                          : Text(
                              "login".tr,
                              style: TextStyle(
                                color: HexToColor.light,
                                fontSize: 14.sp,
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppbar(LoginProvider provider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_rounded,
            size: 20.sp,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: HexToColor.mainColor,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: DropdownButton(
            borderRadius: BorderRadius.circular(10),
            underline: SizedBox.shrink(),
            iconEnabledColor: HexToColor.light,
            value: provider.language ?? "uz",
            items: [
              for (var lan in ["uz", "ru"])
                DropdownMenuItem(
                  child: Text(
                    "${lan.toString().capitalize}",
                    style: TextStyle(
                      fontSize: 26,
                      color: HexToColor.light,
                    ),
                  ),
                  value: lan,
                )
            ].toList(),
            onChanged: (e) {
              provider.language = e;
              print(provider.language);
            },
          ),
        ),
      ],
    );
  }
}
