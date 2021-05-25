import 'package:flutter/material.dart';
import 'package:practica2_2021/src/screens/contact_screen.dart';
import 'package:practica2_2021/src/screens/dashboard.dart';
import 'package:practica2_2021/src/screens/detail_screen.dart';
import 'package:practica2_2021/src/screens/favorite_screen.dart';
import 'package:practica2_2021/src/screens/popular_screen.dart';
import 'package:practica2_2021/src/screens/profile_screen.dart';
import 'package:practica2_2021/src/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({Key key}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes:{
        '/dashboard': (BuildContext context) => Dashboard(),
        '/popular': (BuildContext context) => PopularScreen(),
        '/detail': (BuildContext context) => DetailScreen(),
        '/profile': (BuildContext context) => ProfileScreen(),
        '/contact': (BuildContext context) => ContactScreen(),
        '/favorite': (BuildContext context) => FavoriteScreen()
      } ,
      home: SplashScreenApp(),
    );
  }
}

