import 'package:consultant_orzu/controller/https/http.dart';
import 'package:consultant_orzu/utils/hex_to_color.dart';
import 'package:consultant_orzu/utils/shadow/container_shadow.dart';
import 'package:consultant_orzu/utils/widgets/loaders/cp_indicator.dart';
import 'package:consultant_orzu/utils/widgets/main_button.dart';
import 'package:consultant_orzu/utils/widgets/main_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'provider/change_profile_provider.dart';

class ChangeProfile extends StatelessWidget {
  const ChangeProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        title: Text(
          "change_profile".tr,
          style: Get.textTheme.titleSmall,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ChangeNotifierProvider<ChangeProfileProvider>(
          create: (context) => ChangeProfileProvider(),
          builder: (context, snapshot) {
            return Consumer<ChangeProfileProvider>(builder: (context, provider, _) {
              return provider.isLoading
                  ? CPIndicator()
                  : SafeArea(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      height: Get.width * 0.275,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: HexToColor.light,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 7,
                                            offset: Offset(0, 3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      margin: EdgeInsets.only(right: 15, bottom: 15),
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: Get.width * 0.2,
                                            height: Get.width * 0.2,
                                            decoration: BoxDecoration(
                                              border: Border.all(width: 4, color: HexToColor.mainColor),
                                              color: Colors.white,
                                              boxShadow: shadowContainer(),
                                              borderRadius: BorderRadius.circular(100),
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(100),
                                              child: Stack(
                                                children: [
                                                  provider.seller['image'] != null
                                                      ? Image.network(
                                                          "${HttpService.images}${provider.seller['image']}",
                                                          fit: BoxFit.cover,
                                                        )
                                                      : Image.asset(
                                                          "assets/images/unknown.jpg",
                                                          fit: BoxFit.cover,
                                                        ),
                                                  Positioned(
                                                    bottom: 0,
                                                    child: InkWell(
                                                      onTap: () {
                                                        provider.imagePicker();
                                                      },
                                                      child: Container(
                                                        width: Get.width * 0.18,
                                                        height: 30,
                                                        decoration: BoxDecoration(
                                                          color: HexToColor.greyTextFieldColor.withOpacity(.5),
                                                          borderRadius: BorderRadius.circular(10),
                                                        ),
                                                        child: Icon(
                                                          Icons.camera_alt_rounded,
                                                          color: HexToColor.greyTextFieldColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        _title("name".tr),
                                        MainInputField(
                                          isEnabled: provider.isEnabled,
                                          controller: provider.nameController,
                                          hintText: "name".tr,
                                        ),
                                        SizedBox(height: 15),
                                        _title("surname".tr),
                                        MainInputField(
                                          isEnabled: provider.isEnabled,
                                          controller: provider.surnameController,
                                          hintText: "surname".tr,
                                        ),
                                        SizedBox(height: 15),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        _title("phone".tr),
                                        MainInputField(
                                          isEnabled: provider.isEnabled,
                                          controller: provider.phoneController,
                                          hintText: "+998",
                                          inputFormatters: [
                                            MaskTextInputFormatter(
                                              mask: "+998 ## ### ## ##",
                                              filter: {"#": RegExp(r'^[0-9]')},
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        _title("email".tr),
                                        MainInputField(
                                          isEnabled: provider.isEnabled,
                                          controller: provider.emailController,
                                          hintText: "email".tr,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              _title("old_password".tr),
                              MainInputField(
                                isEnabled: provider.isEnabled,
                                controller: provider.oldPassword,
                                hintText: "old_password".tr,
                                onChangableVisibility: true,
                              ),
                              SizedBox(height: 15),
                              _title("new_password".tr),
                              MainInputField(
                                isEnabled: provider.isEnabled,
                                controller: provider.newPassword,
                                hintText: "new_password".tr,
                                onChangableVisibility: true,
                              ),
                              SizedBox(height: 15),
                              _title("confirm_password".tr),
                              MainInputField(
                                isEnabled: provider.isEnabled,
                                controller: provider.confirmPassword,
                                hintText: "confirm_password".tr,
                                onChangableVisibility: true,
                              ),
                              SizedBox(height: 15),
                              SizedBox(height: 15),
                              MainButton(
                                color: Colors.green,
                                height: 55,
                                width: Get.width,
                                onPressed: () {
                                  provider.changeProfile();
                                },
                                child: Text(
                                  "save_profile".tr,
                                  style: Get.textTheme.bodyLarge!.copyWith(
                                    fontSize: 15.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
                            ],
                          ),
                        ),
                      ),
                    );
            });
          }),
    );
  }

  Widget _title(String data) {
    return Padding(
      padding: EdgeInsets.only(left: 8.0, bottom: 5),
      child: Text(
        "$data",
        style: Get.textTheme.bodyLarge,
      ),
    );
  }
}
