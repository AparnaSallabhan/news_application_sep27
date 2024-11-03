import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_application_sep27/model/news_data_model.dart';
import 'package:news_application_sep27/model/source_model.dart';

class SearchScreenController with ChangeNotifier {
  NewsDataModel? newsDataModel;
  bool isLoading = false;
  bool searchTapped = false;
  List<Article> newsArticles = [];
  onSearch(String keyword,bool tapped) async {
    isLoading = true;
    searchTapped = tapped;
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

  SourceModel? sourceModel;
  List<NewsSource>? sourceList = [];
  List searchCatList = ["Authors", "Topics", "Sources"];
  int selectedSearchcat = 0;
  getSources() async {
    isLoading = true;
    notifyListeners();
    try {
      final sourceUrl = Uri.parse(
          "https://newsapi.org/v2/top-headlines/sources?apiKey=00f0524e9a9640bbb254dfa7777b526");
      var source = await http.get(sourceUrl);
      if (source.statusCode == 200) {
        sourceModel = sourceModelFromJson(source.body);
        if (sourceModel != null) {
          sourceList = sourceModel!.sources!.toList();
          print(sourceList);
        }
      }
    } catch (e) {
      print(e);
    }
    isLoading = false;
    notifyListeners();
  }
}
