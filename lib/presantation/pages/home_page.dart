import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unsplashdemo/presantation/controller/home_controller.dart';
import 'package:unsplashdemo/presantation/pages/search_page.dart';
import 'collection_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
final controller= Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    controller.pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_){
        return Scaffold(
          backgroundColor: Colors.black,
          body: PageView(
            controller: controller.pageController,
            children: [
              SearchPage(),
              CollectionPage(),
            ],
            onPageChanged: (int index) {
                controller.currentTap = index;
            },
          ),
          bottomNavigationBar: CupertinoTabBar(
            backgroundColor: Colors.black,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.search,
                    size: 32,
                  )),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.collections,
                    size: 32,
                  )),
            ],
            onTap: (int index) {
                controller.currentTap = index;
              controller.pageController!.animateToPage(index,
                  duration: Duration(milliseconds: 200), curve: Curves.easeIn);
            },
            currentIndex: controller.currentTap,
            activeColor: Colors.white,
          ),
        );
      },
    );
  }
}
