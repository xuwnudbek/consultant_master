import 'dart:convert';

import 'package:consultant_orzu/controller/hive/hive.dart';
import 'package:consultant_orzu/utils/widgets/main_snackbars.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HttpService {
  // static String baseUrl = "127.0.0.1:8000";
  static String baseUrl = "app.orzugrand.uz";
  static String _baseAdditional = "api/frontend";

  //BaseUrl
  static String categories = "${_baseAdditional}/categories";
  static String tabs = "${_baseAdditional}/tabs";
  static String products = "${_baseAdditional}/products";
  static String product = "${_baseAdditional}/products/view";
  static String discounts = "${_baseAdditional}/products/discounts";
  static String search = "${_baseAdditional}/search";
  static String productWithId = "${_baseAdditional}/favorites";

  ///----------------------------------------------------------------------

  // static String mainUrl = "192.168.0.127:2004";
  static String mainUrl = "192.168.0.127:2004";
  static String _mainAdditional = "api";

  //MainUrl
  static String images = "${Uri.http(mainUrl, "images")}/";
  static String login = "${_mainAdditional}/login";
  static String saller = "${_mainAdditional}/saller";
  static String carusel = "${_mainAdditional}/chegirma";
  static String sale = "${_mainAdditional}/sale";
  static String sales = "${_mainAdditional}/sales";
  static String save = "${_mainAdditional}/save";
  static String updateProduct = "${_mainAdditional}/change";
  static String deleteProduct = "${_mainAdditional}/delete";
  static String getQuestions = "${_mainAdditional}/questions";

  //Headers
  static Map<String, String> get headers => {
        "Accept": "application/json",
        "Authorization": "Bearer ${HiveService.get("token")}",
      };

  //Functions
  static POST(url, {body, required base, params}) async {
    var response;
    try {
      var uri = Uri.http(base, url, params);
      print("______________${uri}");

      var res = await http.post(
        uri,
        body: body,
        headers: headers,
      );

      print(res.statusCode);

      if (res.statusCode < 299) {
        response = {
          "status": HttpResponse.data,
          "data": jsonDecode(res.body),
        };
      } else {
        response = {
          "status": HttpResponse.error,
          "data": jsonDecode(res.body),
        };
        print(res.statusCode);
      }

      return response;
    } catch (e) {
      print(e);
      response = {
        "status": HttpResponse.none,
        "data": "connection_error".tr,
      };

      return response;
    }
  }

  static GET(url, {required base, params}) async {
    var response;
    var uri = Uri.http(base, url, params);
    print(uri);

    try {
      var uri = Uri.http(base, url, params);
      print("uri: ${uri}");
      var res = await http.get(uri, headers: headers);

      if (res.statusCode < 299) {
        response = {
          "status": HttpResponse.data,
          "data": jsonDecode(res.body),
        };
        return response;
      } else {
        response = {
          "status": HttpResponse.error,
          "data": jsonDecode(res.body),
        };
        return response;
      }
    } catch (e) {
      response = {
        "status": HttpResponse.none,
        "data": "connection_error".tr,
      };
    }

    return response;
  }

  static uploadFile(path, int id) async {
    var uri = Uri.http(mainUrl, "${saller}/$id");

    var request = http.MultipartRequest("POST", uri);
    request.headers.addAll(headers..addAll({"Content-Type": "multipart/form-data"}));
    request.fields.addAll({"_method": "PUT"});
    request.files.add(await http.MultipartFile.fromPath("image", path));

    var res = await request.send();

    if (res.statusCode < 299) {
      return {
        "status": HttpResponse.data,
        "data": jsonDecode(await res.stream.bytesToString()),
      };
    } else {
      return {
        "status": HttpResponse.error,
        "data": jsonDecode(await res.stream.bytesToString()),
      };
    }
  }
}

enum HttpResponse { error, none, data }
