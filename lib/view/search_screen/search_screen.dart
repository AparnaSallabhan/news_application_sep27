// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_application_sep27/controller/search_screen_controller.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context.read<SearchScreenController>().getSources();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final searchScreenProvider = context.watch<SearchScreenController>();

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Divider(
                  thickness: 5,
                ),
                SizedBox(
                  height: 10,
                ),
                //search bar
                SearchBar(
                  controller: controller,
                  hintText: "Search",
                  leading: IconButton(
                      onPressed: () {
                        context
                            .read<SearchScreenController>()
                            .onSearch(controller.text);
                      },
                      icon: Icon(Icons.search)),
                  // onChanged: (value) {
                  //   if(value.isNotEmpty){
                  //     context
                  //       .read<SearchScreenController>()
                  //       .onSearch(controller.text);
                  //   }
                  // },
                ),
                SizedBox(
                  height: 10,
                ),
                //tabBar
                TabBar(
                    tabAlignment: TabAlignment.center,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: Colors.blue,
                    indicatorWeight: 4,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    dividerColor: Colors.white,
                    tabs: [
                      Tab(
                        text: "Authors",
                       
                      ),
                      Tab(
                        text: "Topics",
                      ),
                      Tab(
                        text: "Source",
                      ),
                    ]),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Builder(
                    builder: (context) {
                      if (searchScreenProvider.isLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (searchScreenProvider.newsArticles.isEmpty) {
                        return Center(
                          child: Text("No Data Found"),
                        );
                      } else {
                        return Column(
                          children: [
                            ListView.separated(
                                itemBuilder: (context, index) => Container(
                                      padding: EdgeInsets.all(10),
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Colors.white),
                                      child: Column(
                                        children: [
                                          CachedNetworkImage(
                                            imageUrl: searchScreenProvider
                                                .newsArticles[index].urlToImage
                                                .toString(),
                                            placeholder: (context, url) =>
                                                CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                                          // Image.network(searchScreenProvider
                                          //     .newsArticles[index].urlToImage
                                          //     .toString()),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            searchScreenProvider
                                                .newsArticles[index].title
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                separatorBuilder: (context, index) => SizedBox(
                                      height: 10,
                                    ),
                                itemCount:
                                    searchScreenProvider.newsArticles.length),
                          ],
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
