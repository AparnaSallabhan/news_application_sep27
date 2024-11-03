// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_application_sep27/controller/search_screen_controller.dart';
import 'package:news_application_sep27/view/widgets/application_logo.dart';
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        forceMaterialTransparency: true,
        leading: ApplicationLogo(
          smallSize: true,
        ),
        leadingWidth: 200,
      ),
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
                          .onSearch(controller.text,true);
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
                height: 15,
              ),
              //row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                    3,
                    (index) => Column(
                          children: [
                            Text(
                              searchScreenProvider.searchCatList[index],
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Container(
                              height: 4,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(15)),
                              width: 20,
                            )
                          ],
                        )),
              ),

              SizedBox(
                height: 10,
              ),
              Expanded(
                child:
                searchScreenProvider.searchTapped? Builder(
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
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.white),
                                    child: Column(
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl: searchScreenProvider
                                              .newsArticles[index].urlToImage
                                              .toString(),
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
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
                ):

                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => Container(
                  height: 200,
                  width: double.maxFinite,

                  decoration: BoxDecoration(border: Border.all(
                  width: 5,
                    color: Colors.black
                  )),
                ), separatorBuilder: (context, index) => SizedBox(height: 10,), itemCount: searchScreenProvider.sourceList!.length),
              )
            ],
          ),
        ),
      ),
    );
  }
}
