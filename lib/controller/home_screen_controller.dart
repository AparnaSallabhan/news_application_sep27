
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_application_sep27/model/news_data_model.dart';

class HomeScreenController with ChangeNotifier {
  NewsDataModel? topHeadlines;
  List<Article> topNews = [];
  NewsDataModel ? categoryNews;
  
  List <Article> news = [];
  bool isLoading = false;

  bool isCategoryLoading = false;
  int selectedCategoryIndex = 0;
  List categoriesList = ["All","business","entertainment","general","health","science","sports","technology"];

  Future<void> getTopHeadlines() async {
    isLoading = true;
    notifyListeners();
    var url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=00f0524e9a9640bbb254dfa7777b526b");
    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        topHeadlines = newsDataModelFromJson(response.body);
        if (topHeadlines != null) {
          topNews = topHeadlines!.articles ?? [];
          print(topNews);
        }
      }
    } catch (e) {
      print(e);
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> getNewsByCategory(String category) async {
    isCategoryLoading=true;
    notifyListeners();
    var categoryUrl = Uri.parse(
        "https://newsapi.org/v2/everything?q=$category&apiKey=00f0524e9a9640bbb254dfa7777b526b");
    try {
      var categoryRes = await http.get(categoryUrl);
      if(categoryRes.statusCode ==200){
        categoryNews = newsDataModelFromJson(categoryRes.body);
        if(categoryNews!=null){
          news = categoryNews!.articles ?? [];
        }
      }
    } catch (e) {
      print(e);
    }
    isCategoryLoading = false;
    notifyListeners();
  }

  void onCategorySelection(int index){
    selectedCategoryIndex = index;
    notifyListeners();
    getNewsByCategory(categoriesList[selectedCategoryIndex]);
  }
}
