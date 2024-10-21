// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:news_application_sep27/controller/book_mark_screen_controller.dart';
import 'package:news_application_sep27/view/home_screen/widgets/news_card.dart';
import 'package:provider/provider.dart';

class BookMarkScreen extends StatefulWidget {
  const BookMarkScreen({super.key});

  @override
  State<BookMarkScreen> createState() => _BookMarkScreenState();
}

class _BookMarkScreenState extends State<BookMarkScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<BookMarkScreenController>().getBookMarkList();
    },);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final bookMarkScreenProvider = context.watch<BookMarkScreenController>();
    return Scaffold(
     // appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(
              thickness: 5,
             
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "See Your Bookmarks here!",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff001F3F)),
                ),Spacer(),
                IconButton(onPressed: () {
                  context.read<BookMarkScreenController>().deleteAllBookMark();
                }, icon: Icon(Icons.delete))
              ],
            ),
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) => NewsCard(
                      image: bookMarkScreenProvider.bookMarkList[index].image??"",
                      countryName: bookMarkScreenProvider.bookMarkList[index].source??"source",
                      title: bookMarkScreenProvider.bookMarkList[index].title??"title",
                      bookMarked: () {
                        context.read<BookMarkScreenController>().deleteBookMark(index);
                      },
                      ),
                  separatorBuilder: (context, index) => SizedBox(
                        height: 15,
                      ),
                  itemCount: bookMarkScreenProvider.bookMarkList.length),
            )
          ],
        ),
      ),
    );
  }
}
