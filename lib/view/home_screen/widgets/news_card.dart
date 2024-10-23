// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:news_application_sep27/controller/book_mark_screen_controller.dart';
import 'package:provider/provider.dart';

class NewsCard extends StatelessWidget {
  const NewsCard(
      {super.key,
      required this.image,
      required this.countryName,
      required this.title,
      this.bookMarked});
  final String image;
  final String countryName;
  final String title;
  final VoidCallback? bookMarked;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl: image,
            placeholder: (context, url) =>
                Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => Center(child: Lottie.asset("lib/assets/lottie_files/animation.json",height: 80)),
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                countryName,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
              )
            ],
          ),
        ),
        IconButton(
            onPressed: bookMarked,
            icon: context.watch<BookMarkScreenController>().bookmarkIcon(title))
               
      ],
    );
  }
}
