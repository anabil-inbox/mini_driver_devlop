import 'package:get/get.dart';

class HomeViewModel extends GetxController {
  int selectedTab = 0;
  void changeTab(int x) {
    selectedTab = x;
    update();
  }

  bool isTabBarOutBox = false;
}
