import 'package:flutter/material.dart';
import 'package:once_upon_a_time_app/screens/HelpScreen.dart';
import 'package:once_upon_a_time_app/screens/ListenHome.dart';
import 'package:once_upon_a_time_app/screens/RecordBook.dart';
import 'package:once_upon_a_time_app/screens/RecordDone.dart';
import 'package:once_upon_a_time_app/screens/RecordHome.dart';
import 'package:once_upon_a_time_app/screens/SiginInScreen.dart';
import 'package:once_upon_a_time_app/screens/SplashScreen.dart';
import 'package:once_upon_a_time_app/screens/StartScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/start': (context) => StartScreen(),
        '/signin': (context) => SignInScreen(),
        '/listen': (context) => ListenHome(),
        '/record': (context) => RecordHome(),
        '/record/book': (context) => RecordBook(),
        '/record/done': (context) => RecordDone(),
        '/help': (context) => HelpScreen(),
      },
    );
  }
}
