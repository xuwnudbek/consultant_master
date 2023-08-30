import 'package:consultant_orzu/controller/https/http.dart';
import 'package:consultant_orzu/utils/widgets/main_snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

class LoginProvider extends ChangeNotifier {
  var login = TextEditingController();
  var password = TextEditingController();
  bool isLoading = false;

  LoginProvider() {
    language = Hive.box("db").get("language") ?? "uz";
  }

  //db
  Box get db => Hive.box("db");
  get language => db.get("language");
  set language(value) {
    db.put("language", value);
    notifyListeners();
  }

  auth() async {
    isLoading = true;
    notifyListeners();

    var data = {
      "phone": login.text,
      "password": password.text,
    };
    var res = await HttpService.POST(
      HttpService.login,
      base: HttpService.mainUrl,
      body: data,
    );

    print("______________________________${res}");

    if (res['status'] == HttpResponse.data) {
      if (res['data'] is String) {
        MainSnackbars.error(res['data']);
        return;
      }
      print(res);
      var token = res['data']['token'];
      await db.put("token", token);
      await db.put("seller", res['data']);
      Get.back();
    } else if (res['status'] == HttpResponse.error) {
      MainSnackbars.error("login_password_error".tr);
    } else {
      MainSnackbars.error("connection_error".tr);
    }

    isLoading = false;
    notifyListeners();
  }

  bool validate() {
    if (login.text.isEmpty || password.text.isEmpty) return false;

    return true;
  }
}

/*
    var token = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiOWE5NDFlMDIxYzEwNDU1ZDgwMDljNGJiMTQ1MWUwYjVkYmRmMjJjYjAyNTRmY2MxMzlmYTI1NDkwOGY1NjNlMGNjOTUyNWRiYjE0MzgwMGEiLCJpYXQiOjE2OTE0MDc0NjguNTgxOTM2LCJuYmYiOjE2OTE0MDc0NjguNTgxOTQsImV4cCI6MTcyMzAyOTg2OC41Nzg1ODgsInN1YiI6IjcyIiwic2NvcGVzIjpbXX0.UThkgaVxtFKUhI8V5-hYQdcxxh7hxkxvYqdT1Ah7f9pQ5GL4-VgVPUr3U3D0YaPgpAeYkJg-ApUJeY8aGTpP8zAdbjBgIr5OomkJ09WOIJ2ouMXbZHblIQNp8JZlokLqC9uMTQn0lHRAUc7Es0QzU9x3ycr9A5u5kpmSJmRUblP2G4Rz-vONmp1Ol4xbcGlxv2l2SXhkNyxrK2lQPRxDZuCqeDMpPu_kvT-GNHfa85Uz_SdQZaSCyRdUnfM1fUY_OguHqBfDAtTFT8aWF_poJddQf8-QaCr4e4TDw0_fTZH6ejXKCH643Yt1pERRyoDBUKuEbwfOANfWET7NKVa_tUZt8jQF_h5usvus5rA04xZHAgafDITjlJLmZFnXi5q1thkyJdm6Lm0_gLHuvOofeQVZr0epKAgg4ONF2MDH5gzP_VpAsk7izRx26iWFh8rcAsyIQG7lCo8_2v4za2yOZlpBqlNrVEYSGIWUy-35yirSkDghh1bBQ7BUND2bqruYzuN51hhKH41anHslDuH9PVdpsm7WndaV1zg1yP4At6HnYhkVoY7JpklzPqbegwOKfbAgaQQ5M-Ogwmf2Szm06SpvS7jhUcUazLHUGsKO5PGs0GGNMytqlsoMZpO7XSWCc7obf0e5eBSMOCX3Y3dQTzeB_a3Wmz71Fl7GMpSpwLg";
    await db.put("token", token);
*/
