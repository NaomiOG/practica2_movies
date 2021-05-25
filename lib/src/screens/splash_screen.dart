import 'package:flutter/material.dart';
import 'package:practica2_2021/src/screens/login.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashScreenApp extends StatefulWidget{
  SplashScreenApp({Key key}) : super(key: key);
  @override
 
  _SplashScreenAppState createState() => _SplashScreenAppState();

}

class _SplashScreenAppState extends State<SplashScreenApp>{
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 10,
      navigateAfterSeconds: Login(),
      title: Text('Bienvenidos'),
      photoSize: 100.0,  
      image: Image.asset('assets/palomitas.png'),
      gradientBackground: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.blueAccent, Colors.blueGrey],

      ),
      loaderColor: Colors.red,
      loadingText: Text('Iniciando Aplicación'),
    );
  }
}