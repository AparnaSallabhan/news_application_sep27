// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_application_sep27/model/book_mark_model.dart';

class BookMarkScreenController with ChangeNotifier {
  final bookMarkBox = Hive.box<BookMarkModel>("bookMarkBox");
  List keys = [];
  List<BookMarkModel> bookMarkList = [];
  bool bookmarkedNews = false;

  Future<void> addToBookMarkList(
      {String? description,
      String? image,
      String? source,
      String? title,
      BuildContext? context}) async {
    bool isBookMarked = bookMarkList.any(
      (element) => element.title == title,
    ); //to check if the item is already bookmarked
    notifyListeners();
    // for (int i = 0; i < bookMarkList.length; i++) {
    //   if (title == bookMarkList[i].title) {
    //     isBookMarked = true;
    //     notifyListeners();
    //     ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
    //       content: Text("Alredy added to BookMark"),
    //       duration: Duration(seconds: 5),
    //       backgroundColor: Colors.grey[600],
    //     ));
    //     notifyListeners();
    //   }
    // }
    if (isBookMarked) {
      ///bookmarkedNews = false;
      SnackBar(content: Text("Alredy added to Bookmark!"));
    } else if (!isBookMarked) {
      await bookMarkBox.add(BookMarkModel(description, image, source, title));
    }
    getBookMarkList();
    notifyListeners();
  }

  getBookMarkList() {
    keys = bookMarkBox.keys.toList();
    bookMarkList = bookMarkBox.values.toList();
    notifyListeners();
  }

  deleteBookMark(int index) {
    bookMarkBox.deleteAt(index);
    getBookMarkList();
  }

  deleteAllBookMark() {
    bookMarkBox.deleteAll(keys);
    getBookMarkList();
  }

  Icon bookmarkIcon(String title) {
    // for(int i=0;i<bookMarkList.length;i++){
    //   if(title == bookMarkList[i].title){
    //     Icon(Icons.bookmark);
    //   }
    //   else {
    //     return Icon(Icons.bookmark_outline);
    //   }
    // }
    // return Icon(Icons.bookmark_outline);
    bool isBookMarked = bookMarkList.any(
      (element) => element.title == title,
    ); //to check if the item is already bookmarked
    return isBookMarked
        ? Icon(
            Icons.bookmark,
            color: Colors.black,
          )
        : Icon(
            Icons.bookmark_outline,
            color: Colors.black,
          );
  }
}
