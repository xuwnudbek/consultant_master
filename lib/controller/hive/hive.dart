import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  //Hive already initialized. Here i just get and set new data
  static Box db = Hive.box('db');
  static String get token => db.get("token");
  static String language = db.get("language") ?? "uz";

  static init() async {
    var doc = await getApplicationDocumentsDirectory();
    Hive.initFlutter();
    Hive.init(doc.path);
    await Hive.openBox("db");
  }

  static get(String key) {
    return db.get(key);
  }

  static set(String key, value) async {
    return db.put(key, value);
  }

  static delete(String key) async {
    return db.delete(key);
  }

  static clear() async {
    return db.clear();
  }

  static close() async {
    return db.close();
  }

  static bool get isOpen => db.isOpen;
}
