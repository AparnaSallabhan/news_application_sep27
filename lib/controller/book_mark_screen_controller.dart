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
    bool isBookMarked = false; //to check if the item is already bookmarked
    notifyListeners();
    for (int i = 0; i < bookMarkList.length; i++) {
      if (title == bookMarkList[i].title) {
        isBookMarked = true;
        ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
          content: Text("Alredy added to BookMark"),
          duration: Duration(seconds: 5),
          backgroundColor: Colors.grey[600],
        ));
        notifyListeners();
      }
    }
    if (isBookMarked) {
      bookmarkedNews = false;
    } else if (!isBookMarked) {
      await bookMarkBox.add(BookMarkModel(description, image, source, title));
      bookmarkedNews = true;
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
}
