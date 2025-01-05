
import 'package:get/get.dart';
import 'package:unsplashdemo/presantation/controller/collection_controller.dart';
import 'package:unsplashdemo/presantation/controller/photos_controller.dart';
import 'package:unsplashdemo/presantation/controller/sch_controller.dart';

class RootBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>SchController(),fenix: true);
    Get.lazyPut(()=>CollectionController(),fenix: true);
    Get.lazyPut(()=>PhotosController(),fenix: true);
  }
}