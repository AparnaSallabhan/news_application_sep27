// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:news_application_sep27/controller/home_screen_controller.dart';
import 'package:news_application_sep27/view/home_screen/widgets/trending_card.dart';
import 'package:provider/provider.dart';

class TrendingScreen extends StatelessWidget {
  const TrendingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final trendingScreenProvider = context.watch<HomeScreenController>();
    return Scaffold(
      appBar: AppBar(
          //
          // leadingWidth: 200,
          ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(
              thickness: 5,
              indent: 10,
              endIndent: 10,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Trending News",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10,),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => TrendingCard(
                    image:
                        trendingScreenProvider.topNews[index].urlToImage ?? "",
                    title: trendingScreenProvider.topNews[index].title!,
                    source:
                        trendingScreenProvider.topNews[index].source!.name!),
                separatorBuilder: (context, index) => SizedBox(
                  height: 10,
                ),
                itemCount: trendingScreenProvider.topNews.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
