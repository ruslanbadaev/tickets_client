import 'package:tickets/models/pack.dart';
import 'package:tickets/pages/concerts/concerts.dart';
import 'package:tickets/pages/generate/generate.dart';
import 'package:tickets/utils/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'controller.dart';

import 'pages/creation/creation.dart';
import 'pages/gallery/gallery.dart';
import 'pages/home/home.dart';
import 'utils/constants/images.dart';
import 'widgets/no_internet_connection.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> with TickerProviderStateMixin {
  @override
  initState() {
    super.initState();

    checkInternetConnection();
  }

  void checkInternetConnection() async {
    bool hasConnection = await InternetConnectionChecker().hasConnection;
    if (!hasConnection) {
      Get.to(const NoInternetConnectionWidget());
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Image.asset(
          AppImages.home,
        ),
        activeColorPrimary: CupertinoColors.black,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset(AppImages.notebook2),
        activeColorPrimary: CupertinoColors.black,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset(AppImages.settings),
        activeColorPrimary: CupertinoColors.black,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(
      init: AppController(),
      builder: (controller) {
        return Scaffold(
          // appBar: AppBar(
          //   backgroundColor: Get.theme.backgroundColor,
          //   elevation: .5,
          //   toolbarHeight: 42,
          //   centerTitle: true,
          //   title: RichText(
          //     text: TextSpan(
          //       children: <TextSpan>[
          //         TextSpan(
          //           text: '',
          //           style: context.textTheme.headline1!.copyWith(
          //             color: Get.theme.accentColor,
          //           ),
          //         ),
          //         const TextSpan(
          //           text: '',
          //         ),
          //         TextSpan(
          //           text: '',
          //           style: Get.textTheme.headline2!.copyWith(
          //             color: Get.theme.accentColor,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          //   actions: [],
          // ),
          backgroundColor: Get.theme.backgroundColor,
          body: const ConcertsScreen(),
          // floatingActionButton: Padding(
          //   padding: const EdgeInsets.only(bottom: 56),
          //   child: FloatingActionButton.extended(
          //     backgroundColor: AppColors.WHITE,
          //     onPressed: () {
          //       Get.to(const GenerateScreen(type: PackType.art));
          //     },
          //     label: Text(
          //       'Generate',
          //       style: Get.textTheme.bodyText1!.copyWith(),
          //       textAlign: TextAlign.end,
          //       overflow: TextOverflow.ellipsis,
          //     ),
          //   ),
          // ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          // floatingActionButton: controller.isLoading
          //     ? FloatingActionButton(
          //         onPressed: () {},
          //       )
          //     : null,
        );
      },
    );
  }
}
