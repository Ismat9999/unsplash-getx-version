import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../core/services/log_service.dart';
import '../../data/datasources/remote/services/http_services.dart';
import '../../data/model/photo_model.dart';

class SchController extends GetxController{
  bool isLoading =true;
  List<Photo> items = [];
  String search= "office";
  TextEditingController textEditingController=TextEditingController();

  ScrollController scrollController = ScrollController();
  int currentPage = 1;

  initScrollerListener(){
    scrollController.addListener((){
      if(scrollController.position.maxScrollExtent <= scrollController.offset){
        currentPage++;
        LogService.i(currentPage.toString());
        apiSearchPhotos();
      }
    });
  }
   apiSearchPhotos()async{
    isLoading= true;
    update();

    var response = await Network.GET(
        Network.API_SEARCH_PHOTOS, Network.paramsSearchPhotos(search, currentPage));
    LogService.i(response!);
    var result = Network.parseSearchPhotos(response!).results;

    items.addAll(result);
    isLoading = false;
    update();
  }

  searchQuery()async{
    items.clear();
    if(textEditingController.text != ''){
      search = textEditingController.text;
    }
    apiSearchPhotos();
  }
}