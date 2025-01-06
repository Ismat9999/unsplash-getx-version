import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unsplashdemo/presantation/controller/collection_controller.dart';
import 'package:unsplashdemo/presantation/pages/photos_page.dart';
import '../../data/model/collection_model.dart';
import '../widgets/item_of_collection.dart';

class CollectionPage extends StatefulWidget {
  static const String id = "collection_page";

  const CollectionPage({super.key});

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  final _controller = Get.find<CollectionController>();



  @override
  void initState() {
    super.initState();
    _controller.apiCollectionList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            "Unsplash",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.pix_sharp,
              color: Colors.white,
            ),
          ),
        ),
        body: GetBuilder<CollectionController>(
          builder: (controller){
            return Stack(
              children: [
                ListView.builder(
                  itemCount: controller.items.length,
                  itemBuilder: (ctx, index) {
                    return itemOfCollection(context,controller.items[index]);
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