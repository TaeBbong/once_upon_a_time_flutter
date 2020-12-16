import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:once_upon_a_time_app/models/Book.dart';
import 'package:once_upon_a_time_app/utils/ScreenParameter.dart';
import 'package:once_upon_a_time_app/utils/UserParameter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecordHome extends StatefulWidget {
  @override
  _RecordHomeState createState() => _RecordHomeState();
}

class _RecordHomeState extends State<RecordHome> {
  DateTime currentBackPressTime;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  UserParameter user;
  String userName;
  final List<Book> books = [
    Book(
      index: 0,
      title: '누가 내 머리에 똥 쌌어?',
      image:
          'https://t2.daumcdn.net/thumb/R720x0/?fname=http://t1.daumcdn.net/brunch/service/user/3xdL/image/McUSP7GLtw3U4Ku0pfpfMjU9nfQ.jpg',
      pages: [
        '옛날 옛적에 흥부와 놀부가 있었습니다.',
        '둘은 사이 좋게 평생 행복하게 살았답니다!',
      ],
    ),
    Book(
      index: 1,
      title: '하품하는 악어',
      image: 'https://img.ridicdn.net/cover/805021357/xxlarge',
      pages: [
        '옛날 옛적에 흥부와 놀부가 있었습니다.',
        '둘은 사이 좋게 평생 행복하게 살았답니다!',
      ],
    ),
    Book(
      index: 2,
      title: '숲속 피아노',
      image: 'https://img.hankyung.com/photo/201704/BD.13793381.1.jpg',
      pages: [
        '옛날 옛적에 흥부와 놀부가 있었습니다.',
        '둘은 사이 좋게 평생 행복하게 살았답니다!',
      ],
    ),
    Book(
      index: 3,
      title: '숙제 해주는 로봇',
      image: 'https://image.yes24.com/Goods/35763188/L',
      pages: [
        '옛날 옛적에 흥부와 놀부가 있었습니다.',
        '둘은 사이 좋게 평생 행복하게 살았답니다!',
      ],
    ),
    Book(
      index: 4,
      title: '숲속 피아노',
      image: 'https://img.hankyung.com/photo/201704/BD.13793381.1.jpg',
      pages: [
        '옛날 옛적에 흥부와 놀부가 있었습니다.',
        '둘은 사이 좋게 평생 행복하게 살았답니다!',
      ],
    ),
    Book(
      index: 5,
      title: '숙제 해주는 로봇',
      image: 'https://image.yes24.com/Goods/35763188/L',
      pages: [
        '옛날 옛적에 흥부와 놀부가 있었습니다.',
        '둘은 사이 좋게 평생 행복하게 살았답니다!',
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _loadPrefs().then((result) {
      setState(() {
        userName = user.name;
      });
    });
  }

  _loadPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString('name');
    print(name);
    String account = prefs.getString('account');
    int money = prefs.getInt('money');
    user = UserParameter(name, account, money);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          bool result = onPressBackButton();
          return await Future.value(result);
        },
        child: Scaffold(
          appBar: userName == null
              ? AppBar(
                  backgroundColor: Colors.amber[400],
                )
              : AppBar(
                  backgroundColor: Colors.amber[400],
                  title: Text(
                    '$userName 님 안녕하세요!',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontFamily: 'THEvanillabean',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  centerTitle: true,
                ),
          body: Container(
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.all(5),
                ),
                Container(
                  padding: EdgeInsets.all(3),
                  child: Center(
                    child: Text(
                      '아래의 그림을 눌러 읽으실 동화책을 골라주세요.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 19,
                        fontFamily: 'THEvanillabean',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(3),
                  child: Center(
                    child: Text(
                      '화면을 아래쪽으로 밀면 더 많은 동화책이 보입니다.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 19,
                        fontFamily: 'THEvanillabean',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(3),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 1.5,
                    children: List.generate(6, (index) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/record/book',
                              arguments: ScreenParameter(books[index], 0),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Center(
                                  child: Image.network(
                                    books[index].image,
                                    height: MediaQuery.of(context).size.height *
                                        0.5,
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    books[index].title,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 19,
                                      fontFamily: 'THEvanillabean',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    '2000원',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 19,
                                      fontFamily: 'THEvanillabean',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool onPressBackButton() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      scaffoldKey.currentState
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Text("한 번 더 눌러 종료하기"),
        ));
      return false;
    }
    return true;
  }
}
