import 'package:consultant_orzu/pages/welcome/welcome.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

extension Authentication on http.Response {
  /// [checkAuth] function checks if the response body contains the word "Unauthenticated"
  void checkAuth() {
    if (this.body.toString().contains(RegExp(r'Unauthenticated.'))) {
      print("Unauthenticated 1111");
      print(this.body);
      Get.offAll(() => Welcome());
    }
  }
}
