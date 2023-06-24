import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_yandex_ads/yandex.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'app.dart';
import 'controllers/session_controller.dart';
import 'firebase_config.dart';
import 'utils/constants/translations.dart';
import 'utils/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

void main() async {
  await GetStorage.init();
  // MobileAds.instance.initialize();
  // FlutterYandexAds.initialize();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.web);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();

    Get.put(SessionController());
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          translations: Languages(),
          locale: Locale(box.read('language') ?? Get.deviceLocale?.countryCode ?? 'en'),
          fallbackLocale: const Locale('en'),
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light,
          home: GetBuilder<SessionController>(
            init: SessionController(),
            builder: (controller) {
              return const App();
            },
          ),
        );
      },
    );
  }
}
