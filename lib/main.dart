import 'package:consultant_orzu/controller/hive/hive.dart';
import 'package:consultant_orzu/pages/home/home.dart';
import 'package:consultant_orzu/pages/welcome/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'controller/language/language.dart';
import 'utils/hex_to_color.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MainProvider()),
      ],
      builder: (context, snapshot) {
        return ResponsiveSizer(
          builder: (context, orientation, deviceType) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: <Locale>[
                const Locale('uz'),
                const Locale('ru'),
              ],
              locale: Locale("${Hive.box("db").get("language") ?? "uz"}"),
              translations: Language(),
              theme: ThemeData(
                appBarTheme: AppBarTheme(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  iconTheme: IconThemeData(color: HexToColor.blackColor),
                ),
                scaffoldBackgroundColor: Colors.white,
                fontFamily: "Montserrat",
                textTheme: TextTheme(
                  titleLarge: TextStyle(
                    fontSize: 20.8.sp,
                    color: HexToColor.light,
                    fontWeight: FontWeight.w700,
                  ),
                  titleMedium: TextStyle(
                    fontSize: 18.8.sp,
                    color: HexToColor.blackColor,
                    fontWeight: FontWeight.w600,
                  ),
                  titleSmall: TextStyle(
                    fontSize: 15.8.sp,
                    color: HexToColor.blackColor,
                    fontWeight: FontWeight.w600,
                  ),
                  bodyLarge: TextStyle(
                    fontSize: 14.sp,
                    color: HexToColor.blackColor,
                    fontWeight: FontWeight.w600,
                  ),
                  bodyMedium: TextStyle(
                    fontSize: 13.8.sp,
                    color: HexToColor.mainColor,
                  ),
                  bodySmall: TextStyle(
                    fontSize: 12.sp,
                    color: HexToColor.mainColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                //  data: Theme.of(context).copyWith(
                canvasColor: HexToColor.mainColor,
                // ),
              ),
              // home: Home(),
              // home: Login(),
              home: Consumer<MainProvider>(
                builder: (context, provider, _) {
                  return Welcome(); //provider.token != null ? Home() : Welcome();
                },
              ),
            );
          },
        );
      },
    );
  }
}
////

class MainProvider extends ChangeNotifier {
  var db = Hive.box("db");
  String? token;
  String? language;
  Map seller = {};

  MainProvider() {
    token = db.get("token");
    db.watch(key: "token").listen((event) {
      onChangeToken();
    });

    seller = db.get("seller") ?? {};
    db.watch(key: "seller").listen((event) {
      onChangeToken();
      Get.reloadAll();
    });

    language = db.get("language");
    db.watch(key: "language").listen((event) {
      onChangeLanguage();
    });
  }

  onChangeToken() {
    token = db.get("token");
    notifyListeners();
  }

  onChangeLanguage() {
    language = db.get("language");
    Get.updateLocale(Locale(language ?? "uz"));
    notifyListeners();
  }
}
