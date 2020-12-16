import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final nameController = TextEditingController();
  final accountController = TextEditingController();
  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  _loadPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void dispose() {
    nameController.dispose();
    accountController.dispose();
    super.dispose();
  }

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
          child: SingleChildScrollView(
            child: Column(
              // direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: Text(
                    '회원가입',
                    style: TextStyle(
                      fontSize: 35,
                      fontFamily: 'THEvanillabean',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 400,
                        child: TextFormField(
                          controller: nameController,
                          // obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            hintText: '이름',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                      ),
                      Container(
                        width: 400,
                        child: TextFormField(
                          controller: accountController,
                          // obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            hintText: '계좌정보',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                ),
                InkWell(
                  onTap: () async {
                    await prefs.setBool('login', true);
                    await prefs.setString('name', nameController.text);
                    await prefs.setString('account', accountController.text);
                    await prefs.setInt('money', 0);
                    Navigator.pushReplacementNamed(context, '/record');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.amber[400],
                        border: Border.all(color: Colors.transparent),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    height: 60,
                    width: 300,
                    child: Center(
                      child: Text(
                        '가입하기',
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'THEvanillabean',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
