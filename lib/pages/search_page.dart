import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../model/photo_model.dart';
import '../services/http_services.dart';
import '../services/log_service.dart';

import 'details_page.dart';

class SearchPage extends StatefulWidget {
  static const String id = "search_page";

  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isLoading = false;
  List<Photo> items = [];
  int currentPage = 1;
  ScrollController scrollController = ScrollController();

  _callDetailsPage(Photo photo) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return DetailsPage(
        photo: photo,
      );
    }));
  }

  @override
  void initState() {
    super.initState();

    scrollController.addListener((){
      if(scrollController.position.maxScrollExtent <= scrollController.offset){
        currentPage++;
        LogService.i(currentPage.toString());
        _apiSearchPhotos();
      }
    });

    _apiSearchPhotos();
  }

  _apiSearchPhotos() async {
    setState(() {
      isLoading = true;
    });
    var response = await Network.GET(
        Network.API_SEARCH_PHOTOS, Network.paramsSearchPhotos("search", currentPage));
    var result = Network.parseSearchPhotos(response!);
    LogService.i(response!);

    setState(() {
      items.addAll(result.results);
      isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:
      Container(
        padding: EdgeInsets.only(top: 25),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
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
                    child: GestureDetector(
                      onTap: (){
                        Network.BASE;
                      },
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search photos, collections, users",
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  MasonryGridView.builder(
                    controller: scrollController,
                    gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    itemCount: items.length,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                    itemBuilder: (contex,index){
                      return _itemOfPhoto(items[index],index);
                    },
                  ),
                  isLoading ? Center(child: CircularProgressIndicator(),):SizedBox.shrink(),
                ],
              ),
            ),
          ],

        ),
      ),
    );
  }

  Widget _itemOfPhoto(Photo photo, int index) {
    return GestureDetector(
      onTap: () {
        _callDetailsPage(photo);
      },
      child: Container(
        height: (index % 5 + 5) * 50.0,
        child: Image.network(
          photo.urls.small!,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}