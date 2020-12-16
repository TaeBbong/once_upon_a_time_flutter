import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with AfterLayoutMixin<SplashScreen> {
  @override
  void afterFirstLayout(BuildContext context) => navigatePage();

  Future navigatePage() async {
    await Future.delayed(Duration(seconds: 2));
    // // check preference
    // if (prefs != null) {
    //   bool _seen = (prefs.getBool('seen') ?? false);
    //   if (_seen) {
    //     // dispose();
    //     Navigator.of(context).pushReplacementNamed('/home');
    //   } else {
    //     await prefs.setBool('seen', true);
    //     // dispose();
    //     Navigator.of(context).pushReplacementNamed('/intro');
    //     // intro screen
    //   }
    // } else {
    //   // dispose();
    //   Navigator.of(context).pushReplacementNamed('/intro');
    // }
    Navigator.of(context).pushReplacementNamed('/start');
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.amber[400],
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '옛날 옛적에',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontFamily: 'THEvanillabean',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
