import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_application_sep27/model/news_data_model.dart';

class SearchScreenController with ChangeNotifier {
  NewsDataModel? newsDataModel;
  bool isLoading = false;
  List<Article> newsArticles = [];
  onSearch(String keyword) async {
    isLoading = true;
    notifyListeners();
    try {
      final url = Uri.parse(
          "https://newsapi.org/v2/everything?q=$keyword&apiKey=00f0524e9a9640bbb254dfa7777b526b");
      var news = await http.get(url);
      if (news.statusCode == 200) {
        newsDataModel = newsDataModelFromJson(news.body);
        if (newsDataModel != null) {
          newsArticles = newsDataModel!.articles ?? [];
          print(newsArticles);
        }
      }
    } catch (e) {
      print(e);
    }
    isLoading = false;
    notifyListeners();
  }
}
