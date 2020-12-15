import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartScreen extends StatelessWidget {
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                      child: Text(
                        '당신은 누구인가요?',
                        style: TextStyle(
                          fontSize: 35,
                          fontFamily: 'THEvanillabean',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(5)),
                    Container(
                      child: Text(
                        '버튼을 눌러 알려주세요.',
                        style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'THEvanillabean',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      bool _logined = prefs.getBool('login') ?? false;
                      if (_logined) {
                        Navigator.pushReplacementNamed(context, '/record');
                      } else {
                        prefs.setBool('login', true);
                        Navigator.pushReplacementNamed(context, '/signin');
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.amber[400],
                          border: Border.all(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      height: 160,
                      width: 160,
                      child: Center(
                        child: Text(
                          '녹음자',
                          style: TextStyle(
                            fontSize: 35,
                            fontFamily: 'THEvanillabean',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            title: Column(
                              children: <Widget>[
                                Text("앗, 잠시만요!"),
                              ],
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  "아직 개발 중인 화면입니다.",
                                ),
                                Text(
                                  "금방 완성해서 올게요!",
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                ),
                                Text(
                                  "밍기원정대 올림.",
                                ),
                              ],
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: Text("확인"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.lightBlue[200],
                          border: Border.all(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      height: 160,
                      width: 160,
                      child: Center(
                        child: Text(
                          '청취자',
                          style: TextStyle(
                            fontSize: 35,
                            fontFamily: 'THEvanillabean',
                            fontWeight: FontWeight.w400,
                            // fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
