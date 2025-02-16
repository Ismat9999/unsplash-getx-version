import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:unsplashdemo/presantation/controller/sch_controller.dart';
import '../widgets/item_of_photo.dart';


class SearchPage extends StatefulWidget {

  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _controller = Get.find<SchController>();

  @override
  void initState() {
    super.initState();
    _controller.apiSearchPhotos();
    _controller.initScrollerListener();

  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SchController>(
      builder: (_){
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: Container(
              margin: EdgeInsets.all(10),
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[400],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(5),
                    height: 30,
                    child: Icon(Icons.search,color: Colors.white,),
                  ),
                  Expanded(child: Container(
                    margin: EdgeInsets.all(5),
                    child: TextField(
                      controller: _controller.textEditingController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Search photos, collections, users",
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                      onChanged: (value){
                        _controller.searchQuery();
                      },
                    ),
                  ),
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.black,
          ),
          body: Stack(
            children: [
              MasonryGridView.builder(
                controller: _controller.scrollController,
                gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemCount: _controller.items.length,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
                itemBuilder: (ctx,index){
                  return itemOfPhoto(context,_controller.items[index],index);
                },
              ),
              _controller.isLoading ? Center(child: CircularProgressIndicator(),):SizedBox.shrink(),
            ],
          ),
        );
      },
    );
  }
}
