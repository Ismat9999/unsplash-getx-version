
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../core/services/log_service.dart';
import '../../data/datasources/remote/services/http_services.dart';
import '../../data/model/collection_model.dart';

class CollectionController extends GetxController{
  bool isLoading = false;
  List<Collection> items = [];

  apiCollectionList() async {
   isLoading =true;
   update();
    var response = await Network.GET(
        Network.API_COLLECTIONS, Network.paramsCollections(1));
    var result = Network.parseCollections(response!);
    LogService.i(response!);

      items = result;
      isLoading = false;
      update();
  }
}