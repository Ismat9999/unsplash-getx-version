
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../core/services/log_service.dart';
import '../../data/datasources/remote/services/http_services.dart';
import '../../data/model/photo_model.dart';

class PhotosController extends GetxController{
  bool isLoading = false;
  List<Photo> items = [];

  apiCollectionPhotos() async {
    isLoading=true;
    update();

    var response = await Network.GET(
        Network.API_COLLECTIONS_PHOTOS, Network.paramsCollectionsPhotos(1));
    LogService.i(response!);
    var result = Network.parseCollectionsPhotos(response);

      items = result;
      isLoading = false;
  }
}
