// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_application_sep27/controller/book_mark_screen_controller.dart';
import 'package:news_application_sep27/view/book_mark_screen/book_mark_screen.dart';
import 'package:provider/provider.dart';

class NewsDetailsScreen extends StatelessWidget {
  const NewsDetailsScreen({
    super.key,
    required this.image,
    required this.title,
    required this.source,
    required this.description,
    // required this.url
  });
  final String image;
  final String title;
  final String source;
  final String description;
  // final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookMarkScreen(),
                    ));
                context.read<BookMarkScreenController>().addToBookMarkList(
                    image: image,
                    title: title,
                    source: source,
                    description: description,
                    context: context
                    );
              },
              icon: Icon(
                context.watch<BookMarkScreenController>().bookmarkedNews
                    ? Icons.bookmark
                    : Icons.bookmark_outline,
                color: Colors.black,
              ))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  imageUrl: image,
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                      Center(child: Icon(Icons.error)),
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                source,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                title,
                style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                description,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withOpacity(.7)),
              ),
              SizedBox(
                height: 10,
              ),
              // Text(
              //   url,
              //   style: TextStyle(
              //       fontSize: 16,
              //       fontWeight: FontWeight.w400,
              //       color: Colors.black.withOpacity(.7)),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
