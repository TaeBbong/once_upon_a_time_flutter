import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(),
        body: Center(
          child: Column(
            children: [
              Container(
                child: Text(
                  '시작하기',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              Container(
                child: Text(
                  '당신은 누구인가요?',
                  style: TextStyle(fontSize: 40),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/listen');
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      color: Colors.red,
                      child: Center(child: Text('청취자')),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/record');
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      color: Colors.blue,
                      child: Center(child: Text('녹음자')),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
