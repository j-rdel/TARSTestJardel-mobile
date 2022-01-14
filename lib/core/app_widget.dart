import 'package:flutter/material.dart';
import 'package:tarstest/splash/splash_page.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "TARS",
      home: SplashPage(),
    ); //pagina que você vai trabalhar
  }
}
