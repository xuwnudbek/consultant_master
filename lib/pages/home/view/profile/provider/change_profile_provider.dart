import 'package:consultant_orzu/controller/hive/hive.dart';
import 'package:consultant_orzu/controller/https/http.dart';
import 'package:consultant_orzu/utils/widgets/main_snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ChangeProfileProvider extends ChangeNotifier {
  var nameController = TextEditingController();
  var surnameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var oldPassword = TextEditingController();
  var newPassword = TextEditingController();
  var confirmPassword = TextEditingController();
  var imagePath;

  bool isLoading = false;
  bool isSaving = false;
  Map seller = {};
  bool isEnabled = true;

  ChangeProfileProvider() {
    getSeller();
  }

  changeProfile() async {
    //Check inputs
    if (!isValid()) return;

    isSaving = true;
    notifyListeners();

    var fting = "+" + phoneController.text.replaceAll(RegExp(r'[^0-9]'), '');

    var data = {
      "name": nameController.text,
      "email": emailController.text,
      "surname": surnameController.text,
      "phone": fting,
      "old_password": oldPassword.text,
      "password": newPassword.text,
      "confirm_password": confirmPassword.text,
      "_method": "PUT",
    };

    if (fting.length < 13) {
      MainSnackbars.warning("Telefon raqam noto'g'ri");
      return;
    }

    if (nameController.text.isEmpty) data.remove("name");
    if (surnameController.text.isEmpty) data.remove("surname");
    if (phoneController.text.isEmpty) data.remove("phone");
    if (emailController.text.isEmpty) data.remove("email");
    if (oldPassword.text.isEmpty) data.remove("old_password");
    if (newPassword.text.isEmpty) data.remove("password");
    if (confirmPassword.text.isEmpty) data.remove("confirm_password");

    var sellerId = HiveService.get("seller")['id'];

    notifyListeners();

    var res = await HttpService.POST(
      HttpService.saller + "/$sellerId",
      base: HttpService.mainUrl,
      body: data,
    );

    print(res);

    if (res['status'] == HttpResponse.data) {
      if (res['data'].runtimeType == String) {
        MainSnackbars.error("incorrect_password".tr);
        return;
      } else if (res['data'].runtimeType == Map) {
        seller = res['data'];
      }
      MainSnackbars.success("saved_changes".tr);
    } else {
      MainSnackbars.warning(res['data']);
    }

    isSaving = false;
    notifyListeners();
  }

  setSellerData() {
    nameController.value = TextEditingValue(text: seller['name']);
    surnameController.value = TextEditingValue(text: seller['surname']);
    emailController.value = TextEditingValue(text: seller['email']);
    phoneController.value = TextEditingValue(
      text: seller['phone'],
      selection: TextSelection.fromPosition(
        TextPosition(
          offset: seller['phone'].length,
        ),
      ),
    );
    notifyListeners();
  }

  getSeller() async {
    var sellerId = HiveService.get("seller")['id'];
    isLoading = true;
    notifyListeners();

    var res = await HttpService.POST(
      HttpService.saller + "/$sellerId",
      base: HttpService.mainUrl,
      body: {"_method": "PUT"},
    );
    seller = res['data'];
    notifyListeners();

    isLoading = false;
    notifyListeners();

    setSellerData();
  }

  bool isValid() {
    if (nameController.text.isEmpty) {
      MainSnackbars.warning("${'name'.tr} bo'sh bo'lmasligi kerak");
      return false;
    }
    if (surnameController.text.isEmpty) {
      MainSnackbars.warning("${'surname'.tr} bo'sh bo'lmasligi kerak");
      return false;
    }
    if (phoneController.text.isEmpty || phoneController.text.length < 9) {
      MainSnackbars.warning("${'phone'.tr} " + "empty".tr);
      return false;
    }
    if (emailController.text.isEmpty) {
      MainSnackbars.warning("${'email'.tr} bo'sh bo'lmasligi kerak");
      return false;
    } else if (!emailController.text.isEmail) {
      MainSnackbars.warning("${emailController.text} " + "not_email".tr);
    }

    if (oldPassword.text.isEmpty & (newPassword.text.isNotEmpty || confirmPassword.text.isNotEmpty)) {
      MainSnackbars.warning("${'old_password'.tr} " + "empty".tr);
      return false;
    }
    if (newPassword.text.isNotEmpty & confirmPassword.text.isEmpty) {
      MainSnackbars.warning("${'new_password'.tr} " + "doesnt_match".tr);
      return false;
    }
    if (newPassword.text.isEmpty & confirmPassword.text.isNotEmpty) {
      MainSnackbars.warning("${'new_password'.tr} " + "need_to_fill".tr);
      return false;
    }

    if (oldPassword.text.isNotEmpty & (newPassword.text.isEmpty & confirmPassword.text.isEmpty)) {
      oldPassword.clear();

      return false;
    }

    if (oldPassword.text.isNotEmpty & (newPassword.text.isNotEmpty & confirmPassword.text.isNotEmpty)) {
      if (newPassword.text != confirmPassword.text) {
        MainSnackbars.warning("new_password".tr + " " + "doesnt_match".tr);
        return false;
      }
    }
    return true;
  }

  imagePicker() async {
    XFile? image;
    await ImagePicker().pickImage(source: ImageSource.gallery).then((value) async {
      if (value != null) {
        image = value;
        imagePath = image!.path;
        await updateImage(image!.path);
        notifyListeners();
      } else {
        imagePath = null;
        notifyListeners();
      }
    });
    refresh();
  }

  updateImage(String path) async {
    var res = await HttpService.uploadFile(path, seller['id']);
    print(res);
  }

  refresh() {
    getSeller();
  }
}

//1692956603
