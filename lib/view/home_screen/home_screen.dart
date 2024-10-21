// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_application_sep27/controller/home_screen_controller.dart';
import 'package:news_application_sep27/view/home_screen/widgets/news_card.dart';
import 'package:news_application_sep27/view/home_screen/widgets/trending_card.dart';
import 'package:news_application_sep27/view/news_details_screen/news_details_screen.dart';
import 'package:news_application_sep27/view/trending_screen/trending_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await context.read<HomeScreenController>().getTopHeadlines();
        await context.read<HomeScreenController>().getNewsByCategory("All");
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeScreenProvider = context.watch<HomeScreenController>();
    return SingleChildScrollView(
      child: Column(
        children: [
          Divider(
            thickness: 5,
            indent: 10,
            endIndent: 10,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 10,
              ),
              Text(
                "Trending",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TrendingScreen(),
                      ));
                },
                child: Text(
                  "See All",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[700]),
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          //trending card
          homeScreenProvider.isLoading
              ? CircularProgressIndicator()
              : CarouselSlider(
                  options: CarouselOptions(
                      scrollDirection: Axis.horizontal,
                      autoPlay: true,
                      pauseAutoPlayOnTouch: true,
                      height: 250),
                  items: List.generate(
                    homeScreenProvider.topNews.length,
                    (index) => InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewsDetailsScreen(
                                  image: homeScreenProvider
                                          .topNews[index].urlToImage ??
                                      "",
                                  title:
                                      homeScreenProvider.topNews[index].title!,
                                  source: homeScreenProvider
                                      .topNews[index].source!.name!,
                                  description: homeScreenProvider
                                      .topNews[index].description!),
                            ));
                      },
                      child: TrendingCard(
                        image:
                            homeScreenProvider.topNews[index].urlToImage ?? "",
                        source: homeScreenProvider.topNews[index].source!.name!,
                        title: homeScreenProvider.topNews[index].title!,
                      ),
                    ),
                  )),
          SizedBox(
            height: 16,
          ),

//column with padding
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Latest",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "See All",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey),
                    )
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                //category row
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      homeScreenProvider.categoriesList.length,
                      (index) => InkWell(
                        onTap: () {
                          context
                              .read<HomeScreenController>()
                              .onCategorySelection(index);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                homeScreenProvider.categoriesList[index],
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: homeScreenProvider
                                                .selectedCategoryIndex ==
                                            index
                                        ? Colors.black
                                        : Colors.grey[700]),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                height: 5,
                                width: 20,
                                color:
                                    homeScreenProvider.selectedCategoryIndex ==
                                            index
                                        ? Colors.black
                                        : Colors.grey[700],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
//listview builder
                homeScreenProvider.isCategoryLoading
                    ? Center(child: CircularProgressIndicator())
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NewsDetailsScreen(
                                        description: homeScreenProvider
                                            .news[index].description!,
                                        image: homeScreenProvider
                                                .news[index].urlToImage ??
                                            "",
                                        source: homeScreenProvider
                                            .news[index].source!.name!,
                                        title: homeScreenProvider
                                            .news[index].title!,
                                        //url: homeScreenProvider.news[index].url?? "url",
                                      ),
                                    ));
                              },
                              child: NewsCard(
                                  image: homeScreenProvider
                                          .news[index].urlToImage ??
                                      "",
                                  countryName: homeScreenProvider
                                      .news[index].source!.name!,
                                  title: homeScreenProvider.news[index].title!),
                            ),
                        separatorBuilder: (context, index) => SizedBox(
                              height: 10,
                            ),
                        itemCount: homeScreenProvider.news.length),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
