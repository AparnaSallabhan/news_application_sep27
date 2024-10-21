// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_application_sep27/controller/book_mark_screen_controller.dart';
import 'package:news_application_sep27/controller/home_screen_controller.dart';
import 'package:news_application_sep27/controller/search_screen_controller.dart';
import 'package:news_application_sep27/model/book_mark_model.dart';
import 'package:news_application_sep27/view/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(BookMarkModelAdapter());
  var box = await Hive.openBox<BookMarkModel>("bookMarkBox");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SearchScreenController(),),
        ChangeNotifierProvider(create: (context) => HomeScreenController(),),
        ChangeNotifierProvider(create: (context) => BookMarkScreenController(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}