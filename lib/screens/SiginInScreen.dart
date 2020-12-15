import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(),
        body: Center(
          child: Column(
            children: [
              Container(
                child: Text(
                  '회원가입',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              InkWell(
                onTap: () async {
                  Navigator.pushReplacementNamed(context, '/record');
                },
                child: Container(
                  height: 100,
                  width: 100,
                  color: Colors.blue,
                  child: Center(child: Text('간단 가입 완료하기')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
