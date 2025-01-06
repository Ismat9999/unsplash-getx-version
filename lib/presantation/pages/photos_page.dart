import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:unsplashdemo/presantation/controller/photos_controller.dart';
import '../../data/model/collection_model.dart';
import '../widgets/item_of_photo.dart';

class PhotosPage extends StatefulWidget {
  final Collection? collection;

  const PhotosPage({super.key, this.collection});

  @override
  State<PhotosPage> createState() => _PhotosPageState();
}

class _PhotosPageState extends State<PhotosPage> {
  final _controller =Get.find<PhotosController>();

  @override
  void initState() {
    super.initState();
    _controller.apiCollectionPhotos();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            widget.collection!.title!,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
        body: GetBuilder<PhotosController>(
          builder: (controller){
            return Stack(
              children: [
                MasonryGridView.builder(
                  gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: controller.items.length,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                  itemBuilder: (ctx, index) {
                    return itemOfPhoto(context,controller.items[index], index);
                  },
                ),

                controller.isLoading ? Center(child: CircularProgressIndicator(),) : SizedBox.shrink(),
              ],
            );
          },
        ),
    );
  }
}