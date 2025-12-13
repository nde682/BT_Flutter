import 'package:flutter/material.dart';
import 'package:flutter_application_1/home_screen.dart';
// import 'package:flutter_application_1/my_class.dart';
// import 'package:flutter_application_1/my_news.dart';
// // import 'package:flutter_application_1/bmi.dart';
// // import 'package:flutter_application_1/feedback_form.dart';
// import 'package:flutter_application_1/form_login.dart';
// import 'package:flutter_application_1/my_product.dart';
// import 'package:flutter_application_1/register_form.dart';
// import 'package:flutter_application_1/ran_color.dart';
// import 'package:flutter_application_1/my_home_page.dart';
// import 'package:flutter_application_1/my_place.dart';
// import 'package:flutter_application_1/my_place_homepage.dart';
// import 'package:flutter_application_1/ran_color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false, 
      home: HomeScreen(),
    );
  }
}

