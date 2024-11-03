// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:news_application_sep27/view/book_mark_screen/book_mark_screen.dart';
import 'package:news_application_sep27/view/home_screen/home_screen.dart';
import 'package:news_application_sep27/view/profile_screen/profiile_screen.dart';
import 'package:news_application_sep27/view/search_screen/search_screen.dart';
import 'package:news_application_sep27/view/widgets/application_logo.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({super.key});

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  int selectedIndex = 0;
  List<Widget> screens = [
    HomeScreen(),
    SearchScreen(),
    BookMarkScreen(),
    ProfiileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   forceMaterialTransparency: true,
      //   leading: ApplicationLogo(
      //     smallSize: true,
      //   ),
      //   leadingWidth: 200,
      // ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                color: Color(0xff3A6D8C),
              ),
              activeIcon: Icon(
                Icons.home_filled,
                color: Color(0xff001F3F),
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.explore_outlined,
                color: Color(0xff3A6D8C),
              ),
              activeIcon: Icon(
                Icons.explore,
                color: Color(0xff001F3F),
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.bookmark_outline,
                color: Color(0xff3A6D8C),
              ),
              activeIcon: Icon(
                Icons.bookmark,
                color: Color(0xff001F3F),
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline_sharp,
                color: Color(0xff3A6D8C),
              ),
              activeIcon: Icon(
                Icons.person,
                color: Color(0xff001F3F),
              ),
              label: ""),
        ],
      ),
      body: screens[selectedIndex],
    );
  }
}
