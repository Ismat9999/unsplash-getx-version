import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  int currentTap = 0;
  PageController? pageController;

  void changePage(int index) {
    currentTap = index;
  }

}