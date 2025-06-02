
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro1/Task/LoginSection/Login_Page.dart';

class IntroController extends GetxController {
  var currentPage = 0.obs;
  final pageController = PageController();

  void nextPage() {
    if (currentPage < 2) {
      currentPage++;
      pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.bounceIn);
    } else {
      Get.to(() => LoginPage());
    }
  }

  void prevPage() {
    if (currentPage > 0) {
      currentPage--;
      pageController.previousPage(duration: Duration(milliseconds: 300), curve: Curves.bounceIn);
    }
  }

  void skip() {
    Get.to(() => LoginPage());
  }
}
