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
      title: '옛날 옛적에',
      image: 'images/logo.png',
      pages: [
        '옛날옛적에 김할머니가 살고계셨어요\n\n김할머니는 매일매일 아이고 허리야 아이고 다리야!하시며 학생들에게 급식을 나누어주었습니다.',
        '하지만 날이갈수록 다리는 더 아파왔고,\n\n설상가상으로 할머니가 일하시는 학교에 전염병이 돌아서 학교가 문을 닫게되었어요.',
        '갑자기 일자리를 잃으신 김할머니는 슬프고 두려웠습니다.\n\n“다른 할머니들은 괜찮을까?”\n\n궁금해진 김할머니는 친구들을 찾아 경로당으로 가보았습니다.',
        '할머니의 친구들은 경로당에 둥글게 모여 무언가를 하고있었어요.\n\n“다들 뭐하고있어?”\n\n김할머니가 묻자 친구들이 대답했습니다\n\n“옛날옛적에!”'
      ],
    ),
    Book(
      index: 1,
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
  ];
  final List<String> help = [
    '화면에 나오는 문장을 또박또박 읽어주세요.\n다 읽으셨으면 다음 버튼을 눌러\n다음 페이지로 넘어가주세요.',
    '중간에 멈추고 싶으실 땐 정지버튼을\n눌러 잠시 멈추실 수 있습니다.',
    '이후 다시 시작하고 싶으실 때는\n시작버튼을 눌러\n이어서 녹음해주세요.',
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
                  leading: Container(),
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
                              '/help',
                              arguments: ScreenParameter(books[index], 0, help),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Center(
                                  child: index == 0
                                      ? Image.asset(
                                          books[index].image,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.5,
                                        )
                                      : Image.network(
                                          books[index].image,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
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
