import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeContentController extends GetxController {
  var currentPage = 0.obs;

  void promoBanner(int index) {
    currentPage.value = index;
  }
  void SearchProduct(){
       TextEditingController searchData=TextEditingController();
  }
}