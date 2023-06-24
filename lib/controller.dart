import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class AppController extends GetxController {
  final RxBool _isDarkTheme = false.obs;
  final RxBool _isLoading = false.obs;

  String url = '';
  // User? _currentUser;

  bool get isDarkTheme => _isDarkTheme.value;
  bool get isLoading => _isLoading.value;

  // User? get currentUser => _currentUser;

  final PersistentTabController navigationController = PersistentTabController(initialIndex: 0);

  @override
  void onReady() {
    super.onReady();

    getCurrentUser();
  }

  getCurrentUser() {
    // _currentUser = FirebaseAuth.instance.currentUser;
    update();
  }

  logOut() async {
    // await FirebaseAuth.instance.signOut();
    // _currentUser = null;

    update();
  }

  toggleTheme() {
    log('here');
    if (Get.isDarkMode) {
      Get.changeThemeMode(ThemeMode.light);
      Get.changeThemeMode(ThemeMode.light);
      update();
    } else {
      Get.changeThemeMode(ThemeMode.dark);
      Get.changeThemeMode(ThemeMode.dark);
      update();
    }
  }

  void createImage() async {}

  var tabIndex = 0;

  void changeTabIndex(int? index) {
    tabIndex = index ?? 0;
    update();
  }

  void startLoading() {
    _isLoading.value = true;
    update();
  }

  void endLoading() {
    _isLoading.value = false;
    update();
  }
}
