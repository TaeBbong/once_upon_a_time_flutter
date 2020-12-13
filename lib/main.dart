import 'package:flutter/material.dart';
import 'package:once_upon_a_time_app/screens/ListenHome.dart';
import 'package:once_upon_a_time_app/screens/RecordBook.dart';
import 'package:once_upon_a_time_app/screens/RecordHome.dart';
import 'package:once_upon_a_time_app/screens/SplashScreen.dart';
import 'package:once_upon_a_time_app/screens/StartScreen.dart';
import 'package:provider/provider.dart';

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
        '/listen': (context) => ListenHome(),
        '/record': (context) => RecordHome(),
        '/record/book': (context) => RecordBook(),
      },
    );
    // return MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider<FirebaseAuthService>(
    //       create: (_) => FirebaseAuthService(),
    //     ),
    //     ChangeNotifierProvider<MyUser>(
    //       create: (_) => MyUser(),
    //     ),
    //   ],
    //   child: MaterialApp(
    //     title: 'Flutter Demo',
    //     debugShowCheckedModeBanner: false,
    //     theme: ThemeData(
    //       primarySwatch: Colors.blue,
    //       visualDensity: VisualDensity.adaptivePlatformDensity,
    //     ),
    //     initialRoute: '/splash',
    //     routes: {
    //       '/': (context) => StartScreen(),
    //       '/splash': (context) => SplashScreen(),
    //       '/listen': (context) => ListenHome(),
    //       '/record': (context) => RecordHome(),
    //     },
    //   ),
    // );
  }
}
