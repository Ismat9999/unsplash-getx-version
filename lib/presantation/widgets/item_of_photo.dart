import 'package:flutter/material.dart';
import '../../data/model/photo_model.dart';
import '../pages/details_page.dart';

Widget itemOfPhoto(Photo photo, int index) {
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
_callDetailsPage(Photo photo) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (BuildContext context) {
    return DetailsPage(
      photo: photo,
    );
  }));
}