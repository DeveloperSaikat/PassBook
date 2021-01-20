import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/home_page.dart';
import 'package:flutter_app/pass_gen.dart';

void main() {
  runApp(MyAppState());
}

class MyAppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/password': (context) => PasswordGenerator()
      },
    );
  }
}








