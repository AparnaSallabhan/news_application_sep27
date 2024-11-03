// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:news_application_sep27/view/widgets/application_logo.dart';

class ProfiileScreen extends StatefulWidget {
  const ProfiileScreen({super.key});

  @override
  State<ProfiileScreen> createState() => _ProfiileScreenState();
}

class _ProfiileScreenState extends State<ProfiileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
 appBar: AppBar(
        backgroundColor: Colors.white,
        forceMaterialTransparency: true,
        leading: ApplicationLogo(
          smallSize: true,
        ),
        leadingWidth: 200,
      ),
      body: Column(
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
            "Profile",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10,
          ),
          CircleAvatar(
            radius: 80,
            child: Icon(Icons.person,size: 90,),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "UserName",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 10,),
          
        ],
      ),
    );
  }
}
